import 'package:ex00/view/my_home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ex00',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}