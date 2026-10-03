import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/widgets/skills/skill_container.dart';
import 'package:provider/provider.dart';
import '../../provider/skill_container_provider.dart';
import '../../themes/custom_themes/text_gradient.dart';

class SkillMain extends StatelessWidget {
  const SkillMain({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 750;
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    final Color iconColor = darkMode
        ? const Color.fromARGB(255, 169, 181, 223)
        : const Color.fromARGB(255, 82, 103, 213);

    final List<SkillContainer> skillsList = [
      SkillContainer(
        title: "Flutter",
        icon: FaIcon(
          FontAwesomeIcons.flutter,
          color: iconColor,
        ),
        description: "EXPERT",
        proficiency: 100.0,
        id: "1",
      ),
      SkillContainer(
        title: "Dart",
        icon: FaIcon(
          FontAwesomeIcons.dartLang,
          color: iconColor,
        ),
        description: "EXPERT",
        proficiency: 100.0,
        id: "2",
      ),
      SkillContainer(
        title: "REST APIs",
        icon: const Icon(Icons.storage),
        description: "EXPERT",
        proficiency: 100.0,
        id: "3",
      ),
      SkillContainer(
        title: "MongoDB",
        icon: const FaIcon(
          FontAwesomeIcons.database,
        ),
        description: "INTERMEDIATE",
        proficiency: 60.0,
        id: "4",
      ),
      SkillContainer(
        title: "Google Maps",
        icon: const FaIcon(
          FontAwesomeIcons.locationDot,
        ),
        description: "EXPERT",
        proficiency: 100.0,
        id: "5",
      ),
      SkillContainer(
        title: "Figma",
        icon: const FaIcon(
          FontAwesomeIcons.figma,
        ),
        description: "INTERMEDIATE",
        proficiency: 70.0,
        id: "6",
      ),
      SkillContainer(
        title: "Firebase",
        icon: const FaIcon(
          FontAwesomeIcons.fire,
        ),
        description: "INTERMEDIATE",
        proficiency: 100.0,
        id: "7",
      ),
      SkillContainer(
        title: "Supabase",
        icon: const FaIcon(
          FontAwesomeIcons.boltLightning,
        ),
        description: "INTERMEDIATE",
        proficiency: 80.0,
        id: "8",
      ),
      SkillContainer(
        title: "Claude (Anthropic)",
        icon: const FaIcon(
          FontAwesomeIcons.claude,
        ),
        description: "EXPERT",
        proficiency: 100.0,
        id: "9",
      ),
      SkillContainer(
        title: "ChatGPT",
        icon: const FaIcon(
          FontAwesomeIcons.openai,
        ),
        description: "EXPERT",
        proficiency: 100.0,
        id: "10",
      ),
      SkillContainer(
        title: "Gemini",
        icon: const Icon(Icons.auto_awesome),
        description: "ADVANCED",
        proficiency: 100.0,
        id: "11",
      ),
      SkillContainer(
        title: "Grok",
        icon: const Icon(Icons.smart_toy),
        description: "ADVANCED",
        proficiency: 80.0,
        id: "12",
      ),
      SkillContainer(
        title: "Prompt Engineering",
        icon: const FaIcon(
          FontAwesomeIcons.terminal,
        ),
        description: "EXPERT",
        proficiency: 100.0,
        id: "16",
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : size.width * 0.07,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Skills",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color.fromARGB(255, 79, 89, 145),
                  fontWeight: FontWeight.normal,
                ),
          ),

          /// HEADING
          AfanGradientText(
            text: "My Technical Expertise",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.normal,
                letterSpacing: 0),
          ),

          const SizedBox(height: 10),

          /// DESCRIPTION
          Text(
            "Technology I use to build great Products",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color.fromARGB(255, 79, 89, 145),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
          ),
          const SizedBox(height: 15),
          LayoutBuilder(
            builder: (context, constraints) {
              int columns;

              if (constraints.maxWidth < 500) {
                columns = 1;
              } else if (constraints.maxWidth < 800) {
                columns = 2;
              } else if (constraints.maxWidth < 1100) {
                columns = 3;
              } else {
                columns = 4;
              }

              const spacing = 20.0;
              final cardWidth =
                  (constraints.maxWidth - (columns - 1) * spacing) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: skillsList.map((skill) {
                  return SizedBox(
                    width: cardWidth,
                    child: ChangeNotifierProvider(
                      create: (_) => SkillContainerProvider(),
                      child: skill,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
