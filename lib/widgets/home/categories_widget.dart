import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:store/models/category.dart';
import 'package:store/providers/category_provider.dart';
import 'package:store/services/categories_icons.dart';
import 'package:store/services/category_api_service.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // inspect : débogage
    // inspect(CategoryApiService().getCategories());
    // inspect(CategoriesIcon().getIcon('clothes'));

    return Column(
      spacing: 10,
      children: [
        Text("Categories", style: Theme.of(context).textTheme.headlineMedium),
        /*
          pour parcourir une Future (promesse JS), utiliser obligatoirement FutureBuilder
        */
        FutureBuilder(
          future: CategoryApiService().getCategories(),
          // snpashot contient les données de la future
          builder: (context, snapshot) {
            // si les données de la future sont accessibles
            if (snapshot.hasData) {
              // données de la future
              List<Category> data = snapshot.requireData;
              // inspect(data);

              // affichage en grille
              return SizedBox(
                height: 500,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: data.length,
                  // personnalisation de la grille
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // nombre de colonnes
                    crossAxisCount: 3,
                    // aspect des cellules
                    childAspectRatio: 1.3,
                  ),
                  // cellules de la grille
                  itemBuilder: (context, index) {
                    /*
                      ! permet d'indiquer la valeur est existante
                      ? permet d'indiquer la valeur est peut-être nulle
                    */
                    if (CategoriesIcon().categoryIsExists(data[index].slug!)) {
                      return InkWell(
                        onTap: () {
                          // print(data[index].name);
                          // stocker la catégorie sélectionnée dans le provider
                          context.read<CategoryProvider>().category =
                              data[index];

                          /*
                            naviguer à partir du context :
                              remplacer un écran :
                                - go / replace : utiliser le path d'une route
                                - goNamed / replaceNamed : utiliser le nom d'une route
                              ajouter un écran à la pile des écrans
                                - push : utiliser le path d'une route
                                - pushNamed : utiliser le nom d'une route
                          */
                          context.pushNamed('category');
                        },
                        child: Column(
                          children: [
                            Text(data[index].name!),
                            Icon(
                              CategoriesIcon().getIcon(data[index].slug!),
                              size: 80,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              );
            }

            // si les données de la future sont inaccessibles
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
