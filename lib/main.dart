import 'package:flutter/material.dart';
import 'package:my_portfolio/provider/container_provider.dart';
import 'package:my_portfolio/provider/hover_icon_provider.dart';
import 'package:my_portfolio/provider/skill_container_provider.dart';
import 'package:my_portfolio/provider/theme_provider.dart';
import 'package:my_portfolio/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://rhmtxunnybyhqgqofudj.supabase.co",
    publishableKey: "sb_publishable_A-hI0_zDYOZQUZef0dQFQA_bYamAvJX",
  );
  print("Supabase initialized successfully!");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HoverIconProvider()),
        ChangeNotifierProvider(create: (_) => ContainerProvider()),
        ChangeNotifierProvider(create: (_) => SkillContainerProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: "Afan's Portfolio",
      themeMode: themeProvider.themeMode,
      theme: AfanAppTheme.lightTheme,
      darkTheme: AfanAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
