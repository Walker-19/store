import 'dart:async';

import 'package:flutter/material.dart';

// classe du widget
class AdWidget extends StatefulWidget {
  AdWidget({super.key});

  // liste des pubs
  final List adsList = [
    // Map : accéder aux propriétés par des crochets
    {"img": "ad.webp", "text": "Text01"},
    {"img": "ad2.webp", "text": "Text02"},
    {"img": "ad3.webp", "text": "Text03"},
  ];

  @override
  State<AdWidget> createState() => _AdWidgetState();
}

// classe de l'état du widget
class _AdWidgetState extends State<AdWidget> {
  // propriétés
  int adIndex = 0;

  // état : propriété d'un widget utlisé dans la méthode build
  double adPosition = 0;

  // initState : méthode liée à l'affichage d'un widget
  @override
  void initState() {
    super.initState();

    // minuteur
    Timer.periodic(Duration(seconds: 2), _changeAdPosition);
  }

  // minuteur
  void _changeAdPosition(Timer timer) {
    // widget permet d'accéder à la classe du widget à partir de classe d'un état
    if (adIndex < widget.adsList.length - 1) {
      adIndex++;
    } else {
      adIndex = 0;
    }

    // setState permet de modifier un état, nouvel apppel de build
    setState(() {
      // modifier un état
      adPosition = -(adIndex * MediaQuery.of(context).size.width);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInSine,
            left: adPosition,
            child: SizedBox(
              height: 220,
              child: ListView(
                // shrinkWrap : la hauteur du widget est dépendant du contenu du widget
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  ...widget.adsList.map((ad) {
                    return Column(
                      children: [
                        // image stockée dans l'application
                        Image.asset(
                          'assets/images/${ad['img']}',
                          // récupérer la largeur de l'écran
                          width: MediaQuery.of(context).size.width,
                        ),
                        Text(ad['text']),
                      ],
                    );
                  }),
                  //   Column(
                  //     children: [
                  //       // image stockée dans l'application
                  //       Image.asset(
                  //         'assets/images/ad.webp',
                  //         // récupérer la largeur de l'écran
                  //         width: MediaQuery.of(context).size.width,
                  //       ),
                  //       Text('Text 01'),
                  //     ],
                  //   ),
                  //   Column(
                  //     children: [
                  //       // image stockée dans l'application
                  //       Image.asset(
                  //         'assets/images/ad2.webp',
                  //         // récupérer la largeur de l'écran
                  //         width: MediaQuery.of(context).size.width,
                  //       ),
                  //       Text('Text 02'),
                  //     ],
                  //   ),
                  //   Column(
                  //     children: [
                  //       // image stockée dans l'application
                  //       Image.asset(
                  //         'assets/images/ad3.webp',
                  //         // récupérer la largeur de l'écran
                  //         width: MediaQuery.of(context).size.width,
                  //       ),
                  //       Text('Text 03'),
                  //     ],
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
