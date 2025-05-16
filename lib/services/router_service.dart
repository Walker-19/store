import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:store/layouts/root_layout.dart';
import 'package:store/screens/category_screen.dart';
import 'package:store/screens/home_screen.dart';
import 'package:store/screens/login_screen.dart';
import 'package:store/screens/product_screen.dart';

class RouterService {
  GoRouter getRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => RootLayout(screen: HomeScreen()),
        ),
        GoRoute(
          path: '/category',
          name: 'category',
          builder: (context, state) => RootLayout(screen: CategoryScreen()),
        ),
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => RootLayout(screen: LoginScreen()),
        ),
        GoRoute(
          path: '/product/:id',
          name: 'product',
          builder: (context, state) => RootLayout(
            screen: ProductScreen(
            productId: int.parse(state.pathParameters['id']!),
            ),
          ),
        ),
      
      ],
    );
  }
}
