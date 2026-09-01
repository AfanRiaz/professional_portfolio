import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theming_app/home_screen.dart';
import 'package:theming_app/provider/container_provider.dart';
import 'package:theming_app/provider/hover_icon_provider.dart';
import 'package:theming_app/provider/theme_provider.dart';
import 'package:theming_app/themes/theme.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider(),
      ),
      ChangeNotifierProvider(create: (_) => HoverIconProvider(),
      ),
      ChangeNotifierProvider(create: (_) => ContainerProvider(),
      ),
    ],
        child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: AfanAppTheme.lightTheme,
      darkTheme: AfanAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
