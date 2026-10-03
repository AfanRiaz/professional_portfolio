import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/supabase/supabase_api.dart';
import 'package:provider/provider.dart';
import '../../provider/container_provider.dart';
import '../../themes/custom_themes/text_gradient.dart';
import '../about/about_main.dart';
import '../components/reusable_container.dart';
import '../components/tech_stack_container.dart';

class GetApp extends StatelessWidget {
  const GetApp({super.key});

  @override
  Widget build(BuildContext context) {
    final List<StatsModel> appStatsData = [
      const StatsModel(
        icon: Icon(
          Icons.phone_android_outlined,
          size: 20,
        ),
        number: "Interactive Home",
        title: "Glassmorphism UI, animated text & floating social icons",
      ),

      const StatsModel(
        icon: Icon(
          Icons.layers_outlined,
          size: 20,
        ),
        number: "Dynamic Showcase",
        title: "Auto-fetches projects & certificates from Supabase",
      ),



      const StatsModel(
        icon: Icon(
          Icons.email_outlined,
          size: 20,
        ),
        number: "Email Api Integration",
        title: "Sending mails to my self when the form is submitted",
      ),
      const StatsModel(
        icon: Icon(
          Icons.download_outlined,
          size: 20,
        ),
        number: "APK Distribution",
        title: "Download and install my Flutter application directly",
      ),
      const StatsModel(
        icon: Icon(
          Icons.send_outlined,
          size: 20,
        ),
        number: "Contact Integration",
        title: "Form saves inquiries directly to Supabase database",
      ),

      const StatsModel(
        icon: Icon(
          Icons.palette_outlined,
          size: 20,
        ),
        number: "Custom Theme",
        title: "Deep blue design system, centralized & consistent",
      ),
    ];
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
            text: "fluttertoast",
            icon: FaIcon(FontAwesomeIcons.bell),
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
          const SizedBox(height: 20),
          Center(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ChangeNotifierProvider(
                  create: (_) => ContainerProvider(),
                  child: NewContainer(
                    text: "Flutter",
                    icon: const FaIcon(
                      FontAwesomeIcons.flutter,
                      size: 11,
                    ),
                  ),
                ),

                ChangeNotifierProvider(
                  create: (_) => ContainerProvider(),
                  child: NewContainer(
                    text: "Open Source",
                    textColor: Colors.green,
                  ),
                ),

                ChangeNotifierProvider(
                  create: (_) => ContainerProvider(),
                  child: NewContainer(
                    text: "Multi-Platform",
                  ),
                ),
              ],
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

          LayoutBuilder(
            builder: (context, constraints) {
              double width;

              if (constraints.maxWidth < 500) {
                width = (constraints.maxWidth - 20) / 1;
              } else if (constraints.maxWidth < 800) {
                width = (constraints.maxWidth - 20) / 2;
              } else if (constraints.maxWidth < 1100) {
                width = (constraints.maxWidth - 50) / 3;
              } else {
                width = (constraints.maxWidth - 60) / 4;
              }

              return Wrap(
                spacing: 20,
                runSpacing: 20,
                crossAxisAlignment: WrapCrossAlignment.start,

                children: appStatsData.map((stat){
                  return SizedBox(
                    width: width,
                    child: ChangeNotifierProvider(create: (_) => ContainerProvider(),
                      child: ReusableContainer(
                          numberFontSize: 15, text: stat.title, icon: stat.icon, number: stat.number),),
                  );
                }).toList()
              );

            },
          ),
          const SizedBox(height: 40),
          DownloadApkButton(),
          const SizedBox(height: 10),
          Wrap(
            children: [
              FaIcon(
                FontAwesomeIcons.android,
                size: 16,
                color: isDarkMode ? Colors.blueGrey : Colors.blueGrey,
              ),
              Text(" Enable \"install from unknown resources\"",
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 11,
              ),
              ),
            ],
          )
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
    final screenWidth = MediaQuery.of(context).size.width;
    final double padding = screenWidth > 900
        ? 180.0
        : screenWidth > 600
            ? 80.0
            : 20.0;

    return SizedBox(
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: padding,
            right: padding,
            bottom: 0,
            child: Container(
              height: 2,
              color: const Color(0xFF59638D),
            ),
          ),
          Positioned(
            left: padding,
            bottom: 0,
            child: Container(
              width: 2,
              height: 50,
              color: const Color(0xFF59638D),
            ),
          ),
          Positioned(
            right: padding,
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


class NewContainer extends StatefulWidget {
  final String text;
  final Widget? icon;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;

  const NewContainer({
    super.key,
    required this.text,
    this.icon,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
  });

  @override
  State<NewContainer> createState() => _NewContainerState();
}

class _NewContainerState extends State<NewContainer> {


  @override
  Widget build(BuildContext context) {
    final isHovered = context.watch<ContainerProvider>();
    final isMobile = MediaQuery.sizeOf(context).width < 950;

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        if (!isMobile) isHovered.setHovered(true);
      },

      onExit: (_) {
        if (!isMobile) isHovered.setHovered(false);
      },

      child: GestureDetector(
        onTap: isMobile ? isHovered.toggleHovered : null,
        onTapDown: (_) {
          if (!isMobile) isHovered.setHovered(true);
        },

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,

          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(30),

            border: Border.all(
              color: widget.borderColor ??
                  const Color(0xFF5267D5),
            ),
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// OPTIONAL ICON
              if (widget.icon != null) ...[
                AnimatedScale(
                  scale: isHovered.isHovered ? 1.3 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,

                  child: widget.icon!,
                ),

                const SizedBox(width: 8),
              ],

              /// TEXT
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 10,
                  color: widget.textColor,
                  fontWeight: FontWeight.w900
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DownloadApkButton extends StatelessWidget {
  const DownloadApkButton({super.key});

  @override
  Widget build(BuildContext context) {
    final containerProvider = context.watch<ContainerProvider>();
    final isMobile = MediaQuery.sizeOf(context).width < 950;

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        if (!isMobile) {
          containerProvider.setHovered(true);
          containerProvider.setIconHovered(true);
        }
      },

      onExit: (_) {
        if (!isMobile) {
          containerProvider.setHovered(false);
          containerProvider.setIconHovered(false);
        }
      },

      child: GestureDetector(
        onTap: (){
          if (isMobile) {
            containerProvider.toggleHovered();
            containerProvider.setIconHovered(containerProvider.isHovered);
          }
          SupabaseApi().getApps();
        },
        onTapDown: (_) {
          if (!isMobile) {
            containerProvider.setHovered(true);
            containerProvider.setIconHovered(true);
          }
        },

        child: AnimatedScale(
          scale: containerProvider.isHovered ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,

          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,

            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),

              gradient: const LinearGradient(
                colors: [
                  Color(0xFFAEBCE0),
                  Color(0xFF9EADD3),
                ],
              ),

              boxShadow: containerProvider.isHovered
                  ? [
                BoxShadow(
                  color: const Color(0xFF9EADD3)
                      .withAlpha(80),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ]
                  : [],
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// DOWNLOAD ICON
                AnimatedScale(
                  scale:
                  containerProvider.isIconHovered ? 1.25 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,

                  child: const Icon(
                    Icons.download,
                    color: Colors.white,
                    size: 18,
                  ),
                ),

                const SizedBox(width: 14),

                const Text(
                  "Download APK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}