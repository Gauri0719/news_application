import 'package:flutter/material.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key, required Type category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("HealthPage ")),
    );
  }
}
