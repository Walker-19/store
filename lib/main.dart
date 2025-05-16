// main
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/providers/category_provider.dart';
import 'package:store/services/router_service.dart';
import 'package:store/theme/app_theme.dart';

void main() => runApp(
  // ajout des providers
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
    ],
    child: MyStore(),
  ),
);

// widget (classe) de l'application
class MyStore extends StatelessWidget {
  // constructeur
  const MyStore({super.key});

  // build permet d'afficher l'interface
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "My Store",
      theme: AppTheme().getTheme(),
      // utiliser le routeur
      routerConfig: RouterService().getRouter(),

      // home: RootLayout(screen: HomeScreen()),
    );
  }
}
