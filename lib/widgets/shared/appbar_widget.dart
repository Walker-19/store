import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  Widget _getLeftButton(BuildContext context) {
    return context.canPop()
        ? IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.arrow_back),
          )
        : IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu),
          );
  }

  @override
  Widget build(BuildContext context) {

    return AppBar(
      leading: _getLeftButton(context),
      title: const Text('My Store'),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () => context.pushNamed('cart'),
              icon: const Icon(Icons.shopping_cart),
            ),
          ],
        ),
        IconButton(onPressed: () {
          
          context.pushNamed('favorite');

        }, icon: Icon(Icons.favorite)),
        // IconButton(onPressed: () {}, icon: Icon(Icons.search)),

        IconButton(
          onPressed: () => context.replaceNamed('login'),
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
