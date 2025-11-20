import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medium_weather_app/provider/nav/navigation_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NavigationProvider>();

  if (provider.errorMessage != null) {
    return Center(
      child: Text(
        provider.errorMessage!,
        style: const TextStyle(color: Colors.red, fontSize: 20),
      ),
    );
  }

  // if (provider.coordinates != null) {
  //   return Center(
  //     child: Text(
  //       "Currently\n${provider.coordinates!}",
  //       style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //       textAlign: TextAlign.center,
  //     ),
  //   );
  // }
    return Center(child: Text('Currently ${context.watch<NavigationProvider>().text}'),);

  }
}