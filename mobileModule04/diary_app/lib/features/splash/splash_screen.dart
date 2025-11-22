
import 'package:diary_app/core/routes/app_routes.dart';
import 'package:diary_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/green_leaves.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(onPressed: ()  {
              Navigator.of(context).pushNamed(AppRoutes.login);
            }, child: Text('Login')),
        ),
      ),
    );
  }
}