import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/projects/project_card.dart';
import '../../supabase/supabase_api.dart';
import '../../themes/custom_themes/text_gradient.dart';

class ProjectMain extends StatelessWidget {
  const ProjectMain({super.key});

  static const List<ProjectData> projectDefinitions = [
    ProjectData(
      title: "Solara Rcm",
      image: "assets/images/logo.png",
      screenshotCount: "Screenshots",
      platform: "WEB",
      actionText: "View",
      technology: "Flutter",
      screenshotFolder: "revora",
    ),
    ProjectData(
      title: "Chatto",
      image: "assets/images/logo.png",
      screenshotCount: "Screenshots",
      platform: "APP",
      actionText: "View",
      technology: "Flutter",
      screenshotFolder: "chatto",
    ),
    ProjectData(
      title: "Weather App",
      image: "assets/images/logo.png",
      screenshotCount: "Screenshots",
      platform: "APP",
      actionText: "View",
      technology: "Flutter",
      screenshotFolder: "weather",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FutureBuilder<Map<String, List<String>>>(
      future: SupabaseApi().getProjectScreenshots(),
      builder: (context, snapshot) {
        final screenshots = snapshot.data ?? const <String, List<String>>{};
        final projects = projectDefinitions.map((project) {
          return project.copyWithScreenshots(
            screenshots[project.screenshotFolder] ?? const [],
          );
        }).toList();

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
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0,
                    ),
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
                  final bool isMobile = constraints.maxWidth < 600;

                  if (isMobile) {
                    cardWidth = constraints.maxWidth * 0.82;
                  } else if (constraints.maxWidth < 900) {
                    cardWidth = (constraints.maxWidth - 24) / 2;
                  } else if (constraints.maxWidth < 1200) {
                    cardWidth = (constraints.maxWidth - 48) / 3;
                  } else {
                    cardWidth = (constraints.maxWidth - 72) / 4;
                  }

                  return Align(
                    alignment: isMobile ? Alignment.center : Alignment.centerLeft,
                    child: Wrap(
                      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
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
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
