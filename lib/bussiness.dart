import 'package:flutter/material.dart';

class Business extends StatelessWidget {
  const Business({super.key, required Type category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("BUSINESS ")),
    );
  }
}
