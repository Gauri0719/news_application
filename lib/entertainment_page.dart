import 'package:flutter/material.dart';

class EntertainmentPage extends StatelessWidget {
  const EntertainmentPage({super.key, required Type category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("EntertainmentPage ")),
    );
  }
}
