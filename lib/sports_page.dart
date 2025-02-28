import 'package:flutter/material.dart';

class SportsPage extends StatelessWidget {
  const SportsPage({super.key, required Type category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("SportsPage ")),
    );
  }
}
