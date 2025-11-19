import 'package:flutter/material.dart';

class SecondPageScreen extends StatelessWidget {
  const SecondPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hello'),
      ),
      body: Center(child: Text('second page'),),
    );
  }
}