import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  Widget _getLeftButton(BuildContext context) {
    /*
      context.canPop() : savoir si l'écran affiché peut être supprimé
    */
    return context.canPop()
        ? IconButton(
          onPressed: () {
            // supprimer l'écran affiché
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        )
        : IconButton(
          onPressed: () {
            // ouvrir le drawer
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _getLeftButton(context),
      title: Text('My Store'),
      actions: [
        IconButton(
          onPressed: () {
            print('cart');
          },
          icon: Icon(Icons.shopping_cart),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
        // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        IconButton(
          onPressed: () {
            context.replaceNamed('login');
          },
          icon: Icon(Icons.person),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
