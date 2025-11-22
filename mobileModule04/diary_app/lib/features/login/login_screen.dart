import 'package:diary_app/core/routes/app_routes.dart';
import 'package:diary_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Sign In")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.g_mobiledata),
            onPressed: () async {
  final user = await auth.signInWithGoogle();
  print('[user] $user');

  if (user != null) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.redirect);
  }
},
            label: const Text("Sign in with Google"),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.code),
            onPressed: () async {
  final user = await auth.signInWithGitHub();
  if (user != null) {
    Navigator.of(context).pushReplacementNamed(AppRoutes.redirect);
  }
},
            label: const Text("Sign in with GitHub"),
          ),
        ]),
      ),
    );
  }
}
