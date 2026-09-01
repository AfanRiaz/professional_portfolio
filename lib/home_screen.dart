import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theming_app/provider/theme_provider.dart';
import 'package:theming_app/widgets/about/about_main.dart';
import 'package:theming_app/widgets/experience/experience_main.dart';
import 'package:theming_app/widgets/home/home_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  GlobalKey homeKey = GlobalKey();
  GlobalKey aboutKey = GlobalKey();
  GlobalKey experienceKey = GlobalKey();

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

    scrollController.addListener(() {
      setState(() {
        showBorder = scrollController.offset > 0;
      });
    });
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
            Theme.of(context).scaffoldBackgroundColor.withAlpha(70),

            shape: showBorder
                ? Border(
              bottom: BorderSide(
                color: Colors.blue.withValues(alpha: 0.25),
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
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                Positioned(
                  top: -8,
                  right: -12,
                  child: Text(
                    "•",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 35,
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
            key: experienceKey,
            child: ExperienceMain(),
          ),

        ],
      ),
    );
  }
}

