import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:store/models/favoris.dart';
import 'package:store/models/product.dart';

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
      subtitle: Text('${widget.product.price}€'),
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