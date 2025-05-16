import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store/models/favoris.dart';
import 'package:store/models/product.dart';
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
          Text("Vos Favoris"),

          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 200,
            child: FutureBuilder(future: _favorisList, builder: (context, snapshot) {
            final List<Product> data = snapshot.data ?? [];
            inspect(data);
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: ListTile(
                    leading: Image.network(data[index].images![0],),
                    title: Text(data[index].title!),
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
            },);
          },))
        ],
      ),
    );
  
  }
}
