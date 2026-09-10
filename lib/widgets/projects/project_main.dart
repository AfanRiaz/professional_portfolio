import 'package:flutter/material.dart';
import 'package:theming_app/widgets/projects/project_card.dart';
import '../../themes/custom_themes/text_gradient.dart';

class ProjectMain extends StatelessWidget {
  const ProjectMain({super.key});

  static const List<ProjectData> projects = [
    ProjectData(
      title: "Dukaan Manager Desktop Python",
      image: "assets/images/my_pic.png",
      screenshotCount: "6 screenshots",
      platform: "EXE",
      technology: "Python",
    ),
    ProjectData(
      title: "Multical App Flutter",
      image: "assets/images/my_pic.png",
      screenshotCount: "5 screenshots",
      platform: "APK",
      technology: "Flutter",
    ),
    ProjectData(
      title: "Portfolio Website",
      image: "assets/images/my_pic.png",
      screenshotCount: "4 screenshots",
      platform: "WEB",
      technology: "Flutter",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Portfolio",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color.fromARGB(255, 79, 89, 145),
                  fontWeight: FontWeight.normal,
                ),
          ),

          /// HEADING
          AfanGradientText(
            text: "My Portfolio",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 40, fontWeight: FontWeight.normal, letterSpacing: 0),
          ),

          const SizedBox(height: 10),

          /// DESCRIPTION
          Text(
            "Real Screenshots fetched Live from Supabase Storage.",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: const Color.fromARGB(255, 79, 89, 145),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
          ),
          const SizedBox(height: 15),
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth;

              if (constraints.maxWidth < 600) {
                cardWidth = constraints.maxWidth;
              } else if (constraints.maxWidth < 900) {
                cardWidth = (constraints.maxWidth - 24) / 2;
              } else if (constraints.maxWidth < 1200) {
                cardWidth = (constraints.maxWidth - 48) / 3;
              } else {
                cardWidth = (constraints.maxWidth - 72) / 4;
              }

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: projects.map((project) {
                  return SizedBox(
                    width: cardWidth,
                    child: ProjectContainer(
                      project: project,
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
