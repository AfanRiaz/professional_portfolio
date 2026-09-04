import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theming_app/provider/theme_provider.dart';
import 'package:theming_app/widgets/about/about_main.dart';
import 'package:theming_app/widgets/experience/experience_main.dart';
import 'package:theming_app/widgets/get_app/get_app.dart';
import 'package:theming_app/widgets/home/home_main.dart';
import 'package:theming_app/widgets/skills/skill_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  GlobalKey homeKey = GlobalKey();
  GlobalKey aboutKey = GlobalKey();
  GlobalKey experienceKey = GlobalKey();
  GlobalKey getAppKey = GlobalKey();
  GlobalKey skillKey = GlobalKey();


  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }
  final ScrollController scrollController = ScrollController();
  bool showBorder = false;


  ThemeMode themeMode = ThemeMode.light;
  @override
  void initState() {
    super.initState();


  }
  @override
  void dispose() {
    scrollController.dispose();
    showBorder = false;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,

            backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.27),

            shape: showBorder
                ? Border(
              bottom: BorderSide(
                color: Colors.blue.withOpacity(0.25),
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
            actions: [
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
                    scrollToSection(getAppKey);
                  },
                  child: const Text("Get App"),
                ),
              ),

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
                    scrollToSection(skillKey);
                  },
                  child: const Text("Skills"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  style: Theme.of(context).iconButtonTheme.style,
                  onPressed: themeProvider.toggleTheme,
                  icon: Icon(
                    themeProvider.themeMode == ThemeMode.light
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    size: 30,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Hire me"),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            key: homeKey,
            child: HomeMain(),
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
            key: experienceKey,
            child: ExperienceMain(),
          ),


        ],
      ),
    );
  }
}

