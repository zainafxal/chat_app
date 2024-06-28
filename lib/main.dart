
import 'package:chat_app/Configs/Themes/theme_provider.dart';
import 'package:chat_app/Configs/routes/routes.dart';
import 'package:chat_app/Configs/routes/routes_name.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(),
  child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: Provider.of<ThemeProvider>(context).themeData,

      // Routes

      initialRoute: RoutesName.authGate,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
