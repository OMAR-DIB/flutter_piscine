import 'package:diary_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:diary_app/core/routes/app_routes.dart';
import 'package:diary_app/core/routes/routes_generator.dart';
import 'package:diary_app/core/themes/light_theme.dart';
import 'package:diary_app/provider/nav/navigation_provider.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // 👈 IMPORTANT
  );

  runApp(const DiaryApp());
}

class DiaryApp extends StatelessWidget {
  const DiaryApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'diary_app',
        theme: LightTheme.themeData,
        onGenerateRoute: RoutesGenerator.generateRoute,
        initialRoute: AppRoutes.redirect,
      ),
    );
  }
}