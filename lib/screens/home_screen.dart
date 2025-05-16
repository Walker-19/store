import 'package:flutter/material.dart';
import 'package:store/widgets/home/ad_widget.dart';
import 'package:store/widgets/home/categories_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(spacing: 20, children: [AdWidget(), CategoriesWidget()]);
  }
}
