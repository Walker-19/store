import 'package:go_router/go_router.dart';
import 'package:store/layouts/root_layout.dart';
import 'package:store/screens/category_screen.dart';
import 'package:store/screens/favoris_screen.dart';
import 'package:store/screens/home_screen.dart';
import 'package:store/screens/login_screen.dart';

class RouterService {
  // liste des routes de l'application
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
          path: '/favorite',
          name: 'favorite',
          builder: (context, state) => RootLayout(screen: FavorisScreen()),
          )
      ],
    );
  }
}
