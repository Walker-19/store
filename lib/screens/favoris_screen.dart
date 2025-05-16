import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store/models/cart.dart';
import 'package:store/models/favoris.dart';
import 'package:store/models/product.dart';
import 'package:store/widgets/shared/payment_button_widget.dart';
class FavorisScreen extends StatefulWidget {
  const FavorisScreen({super.key});

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  late Future<List<Product>> _favorisList;

  @override
  void initState() {
    super.initState();
    _loadFavoris();
  }

  void _loadFavoris() {
    _favorisList = Favoris().load();
  }

  Future<void> _refresh() async {
    setState(() {
      _loadFavoris();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Vos Favoris", style: TextTheme.of(context).headlineMedium, textAlign: TextAlign.center,),

          SizedBox(
            width: double.infinity,
            child: FutureBuilder(future: _favorisList, builder: (context, snapshot) {
            final List<Product> data = snapshot.data ?? [];
            inspect(data);
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (_, __) => const Divider(),
                itemCount: data.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: ListTile(
                      leading: Image.network(data[index].images![0],),
                      title: Text(data[index].title!),
                      subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Text('${data[index].price}€'),
                        PaymentButtonWidget(
              width: 70,
              height: 40,
              backgroundColor: Colors.white,
              child: Icon(Icons.add_shopping_cart_sharp, size: 20,), onPressed: () async{
              final cart = Cart();
                  final currentCart = await cart.load() ?? [];
              
                    await cart.add(data[index]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Produit ajouté au panier"),
                        backgroundColor: Colors.green,
                      ),
                    );
                        })
              
                      ],
                    ),
                      trailing: IconButton( onPressed: () async{
                        bool favoris = await Favoris().remove(data[index]);
                        if(favoris) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Produit supprimé')),
                        );
                          await _refresh();
                        } 
                      }, icon: Icon(Icons.delete)),
                    ),
                  );
              },),
            );
          },))
        ],
      ),
    );
  
  }
}
