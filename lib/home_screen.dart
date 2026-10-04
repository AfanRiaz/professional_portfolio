import 'package:flutter/material.dart';
import 'package:my_portfolio/provider/theme_provider.dart';
import 'package:my_portfolio/widgets/about/about_main.dart';
import 'package:my_portfolio/widgets/contact/contact_main.dart';
import 'package:my_portfolio/widgets/experience/experience_main.dart';
import 'package:my_portfolio/widgets/footer_main/footer_main.dart';
import 'package:my_portfolio/widgets/get_app/get_app.dart';
import 'package:my_portfolio/widgets/home/home_main.dart';
import 'package:my_portfolio/widgets/projects/project_main.dart';
import 'package:my_portfolio/widgets/skills/skill_main.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey getAppKey = GlobalKey();
  final GlobalKey skillKey = GlobalKey();
  final GlobalKey projectKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  final bool showBorder = false;

  Widget _buildDrawerItem(BuildContext context, String title, GlobalKey key) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        scrollToSection(key);
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.blue.withAlpha(25),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Text(
                        "AR",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Positioned(
                        top: -3,
                        right: -15,
                        child: Text(
                          "•",
                          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                children: [
                  _buildDrawerItem(context, "Home", homeKey),
                  _buildDrawerItem(context, "About", aboutKey),
                  _buildDrawerItem(context, "Skills", skillKey),
                  _buildDrawerItem(context, "Projects", projectKey),
                  _buildDrawerItem(context, "Experience", experienceKey),
                  _buildDrawerItem(context, "Get App", getAppKey),
                  _buildDrawerItem(context, "Contact", contactKey),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        scrollToSection(contactKey);
                      },
                      child: const Text("Hire me"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final bool isSmallScreen = MediaQuery.of(context).size.width < 1000;

    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: isSmallScreen ? _buildDrawer(context) : null,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withAlpha(27),
            shape: showBorder
                ? Border(
                    bottom: BorderSide(
                      color: Colors.blue.withAlpha(25),
                      width: 1,
                    ),
                  )
                : null,
            title: Stack(
              clipBehavior: Clip.none,
              children: [
                Text(
                  "AR",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Positioned(
                  top: -3,
                  right: -15,
                  child: Text(
                    "•",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            actions: isSmallScreen
                ? [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        style: Theme.of(context).iconButtonTheme.style,
                        onPressed: themeProvider.toggleTheme,
                        icon: Icon(
                          themeProvider.themeMode == ThemeMode.light
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          size: 30,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => IconButton(
                        style: Theme.of(context).iconButtonTheme.style,
                        icon: const Icon(Icons.menu, size: 30),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                  ]
                : [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    scrollToSection(homeKey);
                  },
                  child: const Text("Home"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    scrollToSection(aboutKey);
                  },
                  child: const Text("About"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    scrollToSection(getAppKey);
                  },
                  child: const Text("Get App"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    scrollToSection(skillKey);
                  },
                  child: const Text("Skills"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    scrollToSection(projectKey);
                  },
                  child: const Text("Projects"),
                ),
              ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          scrollToSection(experienceKey);
                        },
                        child: const Text("Experience"),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          scrollToSection(contactKey);
                        },
                        child: const Text("Contact"),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        style: Theme.of(context).iconButtonTheme.style,
                        onPressed: themeProvider.toggleTheme,
                        icon: Icon(
                          themeProvider.themeMode == ThemeMode.light
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          scrollToSection(contactKey);
                        },
                        child: const Text("Hire me"),
                      ),
                    ),
                  ],
          ),
          SliverToBoxAdapter(
            key: homeKey,
            child: HomeMain(
              projectKey: projectKey,
            ),
          ),
          SliverToBoxAdapter(
            key: aboutKey,
            child: AboutMain(),
          ),
          SliverToBoxAdapter(
            key: getAppKey,
            child: GetApp(),
          ),
          SliverToBoxAdapter(
            key: skillKey,
            child: SkillMain(),
          ),
          SliverToBoxAdapter(
            key: projectKey,
            child: const ProjectMain(),
          ),
          SliverToBoxAdapter(
            key: experienceKey,
            child: ExperienceMain(),
          ),
          SliverToBoxAdapter(
            key: contactKey,
            child: ContactMain(),
          ),
          SliverToBoxAdapter(
            child: FooterMain(
              homeKey: homeKey,
              aboutKey: aboutKey,
              skillKey: skillKey,
              projectKey: projectKey,
              experienceKey: experienceKey,
              contactKey: contactKey,
            ),
          ),
        ],
      ),
    );
  }
}
