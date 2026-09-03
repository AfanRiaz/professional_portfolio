import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:theming_app/themes/custom_themes/text_gradient.dart';
import '../../provider/container_provider.dart';
import '../components/tech_stack_container.dart';

class GetApp extends StatelessWidget {
  const GetApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TechStackModel> techStacks = [
      TechStackModel(
        title: "Core Stack",
        techStackData: [
          const TechChip(
            text: "Flutter",
            icon: FaIcon(FontAwesomeIcons.flutter),
          ),
          const TechChip(
            text: "Dart",
            icon: FaIcon(FontAwesomeIcons.dartLang),
          ),
          const TechChip(
            text: "Supabase",
            icon: FaIcon(FontAwesomeIcons.boltLightning),
          ),
        ],
      ),
      TechStackModel(
        title: "Key Packages",
        techStackData: [
          const TechChip(
            text: "Dio",
            icon: FaIcon(FontAwesomeIcons.wifi),
          ),
          const TechChip(
            text: "Provider",
            icon: FaIcon(FontAwesomeIcons.water),
          ),
          const TechChip(
            text: "http",
            icon: FaIcon(FontAwesomeIcons.internetExplorer),
          ),
        ],
      ),
      TechStackModel(
        title: "Platforms",
        techStackData: [
          const TechChip(
            text: "Android",
            icon: FaIcon(FontAwesomeIcons.android),
          ),
          const TechChip(
            text: "Web",
            icon: FaIcon(FontAwesomeIcons.webflow),
          ),
          const TechChip(
            text: "ios",
            icon: FaIcon(FontAwesomeIcons.apple),
          ),
          const TechChip(
            text: "windows",
            icon: FaIcon(FontAwesomeIcons.windows),
          ),
        ],
      ),
    ];

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Container(
      color: isDarkMode
          ? const Color(0xFF0D1B3D) // Dark blue
          : const Color(0xFFF0F5FF), // Very light blue
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: size.width > 900 ? size.width * 0.1 : 20,
      ),
      child: Column(
        children: [
          Text(
            "FEATURED APP",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  letterSpacing: 3,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  color: Colors.blueAccent,
                ),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                "My Flutter",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: size.width > 600 ? 40 : 28,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2,
                    ),
              ),
              AfanGradientText(
                darkRequired: false,
                text: " Portfolio App",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: size.width > 600 ? 40 : 28,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              "A premium multi-platform Flutter app connected to Supabase — browse projects, view certificates, download resume, and reach out with a smooth native experience.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
            ),
          ),
          const SizedBox(height: 40),
          const TechTimeline(),
          const SizedBox(height: 40),
          Wrap(
            spacing: 40,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: techStacks.map((stack) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: size.width > 900 
                      ? (size.width * 0.8 - 40) / 3 
                      : double.infinity,
                ),
                child: ChangeNotifierProvider(
                  create: (_) => ContainerProvider(),
                  child: TechStackContainer(
                    title: stack.title,
                    techStackData: stack.techStackData,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 40),

        ],
      ),
    );
  }
}

class TechStackModel {
  final String title;
  final List<TechChip> techStackData;

  const TechStackModel({
    required this.title,
    required this.techStackData,
  });
}

class TechTimeline extends StatelessWidget {
  const TechTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 30,
            right: 30,
            bottom: 0,
            child: Container(
              height: 2,
              color: const Color(0xFF59638D),
            ),
          ),

          Positioned(
            left: 20,
            bottom: 0,
            child: Container(
              width: 2,
              height: 50,
              color: const Color(0xFF59638D),
            ),
          ),

          Positioned(
            right: 20,
            bottom: 0,
            child: Container(
              width: 2,
              height: 50,
              color: const Color(0xFF59638D),
            ),
          ),

          Positioned(
            bottom: 0,
            child: Container(
              width: 3,
              height: 60,
              color: const Color(0xFF7C89B0),
            ),
          ),
        ],
      ),
    );
  }
}