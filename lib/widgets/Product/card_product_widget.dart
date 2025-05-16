import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store/models/cart.dart';
import 'package:store/models/favoris.dart';
import 'package:store/models/product.dart';
import 'package:store/widgets/shared/payment_button_widget.dart';

class CardProductWidget extends StatefulWidget {
  final Product product;
  final GestureTapCallback function;
   const CardProductWidget({super.key, required this.product, required this.function});

  @override
  State<CardProductWidget> createState() => _CardProductWidgetState();
}

class _CardProductWidgetState extends State<CardProductWidget> {

  late bool containsInFavoris = false; 

   @override
  void initState()  {
      super.initState();
     _loadFavorisState();
    
  }

 Future<void> _loadFavorisState() async{
    final favoris = Favoris();
  final list = await favoris.load();

  final isInfavorite = list.any((p) => p.id == widget.product.id);

  setState(() {
    containsInFavoris = isInfavorite;
  });
      
  }


  void toogleFavoris() async{
    final favoris = Favoris();

    setState(() {
      containsInFavoris = !containsInFavoris;
    });

    if(containsInFavoris) {
      await favoris.add(widget.product);

    }
    else {
      await favoris.remove(widget.product);
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.product.images![0]),
      title: Text(widget.product.title!),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text('${widget.product.price}€'),
          PaymentButtonWidget(
            width: 70,
            height: 40,
            backgroundColor: Colors.white,
            child: Icon(Icons.add_shopping_cart_sharp, size: 20,), onPressed: () async{
            final cart = Cart();
                final currentCart = await cart.load() ?? [];

                  await cart.add(widget.product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Produit ajouté au panier"),
                      backgroundColor: Colors.green,
                    ),
                  );
          })

        ],
      ),
      onTap: widget.function,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          InkWell(
            onTap: toogleFavoris,
            child: IconFavoris(isInFavoris: containsInFavoris),
            
          ), 
          Icon(Icons.arrow_forward_ios, size: 15),
        ],
      ),
    );
  }
}



class IconFavoris extends StatelessWidget {
 final bool isInFavoris ;
   const IconFavoris({super.key, required this.isInFavoris});

  @override
  Widget build(BuildContext context) {
    return   isInFavoris ?  Icon(Icons.favorite, color: Colors.redAccent, size: 25) : Icon(Icons.favorite_border_outlined, size: 25);
  }
}