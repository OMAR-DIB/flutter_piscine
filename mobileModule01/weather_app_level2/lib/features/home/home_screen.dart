import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_level2/provider/nav/navigation_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('first page ${context.watch<NavigationProvider>().text}'),);

  }
}