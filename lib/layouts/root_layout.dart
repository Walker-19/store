import 'package:flutter/material.dart';
import 'package:store/widgets/shared/appbar_widget.dart';
import 'package:store/widgets/shared/drawer_widget.dart';

class RootLayout extends StatelessWidget {
  final Widget screen;
  const RootLayout({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(child: screen),
    );
  }
}
