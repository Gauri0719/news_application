import 'package:flutter/material.dart';

class SciencePage extends StatelessWidget {
  const SciencePage({super.key, required Type category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("SciencePage ")),
    );
  }
}
