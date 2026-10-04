import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../apis/url_opening.dart';
import '../../provider/hover_icon_provider.dart';
import '../../supabase/supabase_api.dart';
import '../../themes/custom_themes/text_gradient.dart';

class HomeMain extends StatefulWidget {
  final GlobalKey projectKey;
  const HomeMain({
    super.key,
    required this.projectKey,
  });

  @override
  State<HomeMain> createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      if (size.width >= 850) {
        return rowWidget(context, size);
      } else {
        return columnWidget(context, size);
      }
    });
  }

  Widget rowWidget(BuildContext context, Size size) {
    final imageUrl = Supabase.instance.client.storage
        .from('images')
        .getPublicUrl('my_pic.jpeg');
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi I'm",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: const Color.fromARGB(173, 93, 93, 178),
                      ),
                ),
                AfanGradientText(
                  text: "Afan Riaz",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 62,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const Text(
                  "Results-driven Mobile & Web Developer with 1+ years of experience, "
                  "passionate about building fast, scalable, and user-focused applications. "
                  "Leveraging modern technologies and AI-powered tools to write smarter code, "
                  "ship faster, and turn ideas into impactful digital experiences.",
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          final downloaded =
                              await SupabaseApi().downloadResume();
                          if (!context.mounted || downloaded) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Unable to download the resume.'),
                            ),
                          );
                        },
                        child: const Text("Download CV"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style:
                            Theme.of(context).textButtonTheme.style!.copyWith(
                                  shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  backgroundColor: WidgetStatePropertyAll(
                                    Colors.white.withValues(alpha: 0.05),
                                  ),
                                ),
                        onPressed: () {
                          scrollToSection(widget.projectKey);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("View my Work"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ChangeNotifierProvider(
                      create: (_) => HoverIconProvider(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HoverIconButton(
                          onPressed: () async {
                            await UrlOpening().gitHubUrl();
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.github,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => HoverIconProvider(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HoverIconButton(
                          onPressed: () async {
                            await UrlOpening().linkedInUrl();
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.linkedin,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => HoverIconProvider(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HoverIconButton(
                          onPressed: () async {
                            await UrlOpening().emailUrl();
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.envelopeOpen,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                width: double.infinity,
                height: size.height,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Theme.of(context)
                            .scaffoldBackgroundColor
                            .withAlpha(10),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget columnWidget(BuildContext context, Size size) {
    final imageUrl = Supabase.instance.client.storage
        .from('images')
        .getPublicUrl('my_pic.jpeg');
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.12,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // RECTANGULAR PROFILE IMAGE CONTAINER (DESKTOP STYLE FOR MOBILE)
          Container(
            height: size.height * 0.72,
            width: size.width * 0.62,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Theme.of(context).scaffoldBackgroundColor,
                            Theme.of(context)
                                .scaffoldBackgroundColor
                                .withAlpha(10),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),

          // GREETING
          Text(
            "Hi I'm",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: const Color.fromARGB(173, 93, 93, 178),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),

          // NAME
          AfanGradientText(
            text: "Afan Riaz",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 16),

          // BIO
          Text(
            "Results-driven Mobile & Web Developer with 1+ years of experience, "
            "passionate about building fast, scalable, and user-focused applications. "
            "Leveraging modern technologies and AI-powered tools to write smarter code, "
            "ship faster, and turn ideas into impactful digital experiences.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14,
                  height: 1.5,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.8),
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // BUTTONS (DOWNLOAD CV & VIEW MY WORK)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final downloaded = await SupabaseApi().downloadResume();
                  if (!context.mounted || downloaded) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Unable to download the resume.'),
                    ),
                  );
                },
                child: const Text("Download CV"),
              ),
              TextButton(
                style: Theme.of(context).textButtonTheme.style!.copyWith(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                onPressed: () {
                  scrollToSection(widget.projectKey);
                },
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                  child: Text("View my Work"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // SOCIAL ICONS
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChangeNotifierProvider(
                create: (_) => HoverIconProvider(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HoverIconButton(
                    onPressed: () async {
                      await UrlOpening().gitHubUrl();
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      size: 22,
                    ),
                  ),
                ),
              ),
              ChangeNotifierProvider(
                create: (_) => HoverIconProvider(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HoverIconButton(
                    onPressed: () async {
                      await UrlOpening().linkedInUrl();
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      size: 22,
                    ),
                  ),
                ),
              ),
              ChangeNotifierProvider(
                create: (_) => HoverIconProvider(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HoverIconButton(
                    onPressed: () async {
                      await UrlOpening().emailUrl();
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.envelopeOpen,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HoverIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;

  const HoverIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final hoverIconProvider = context.watch<HoverIconProvider>();
    return GestureDetector(
      onTap: () {
        hoverIconProvider.setHovered(!hoverIconProvider.isHovered);
        onPressed();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          hoverIconProvider.setHovered(true);
        },
        onExit: (_) {
          hoverIconProvider.setHovered(false);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: hoverIconProvider.isHovered ? 48 : 40,
          height: hoverIconProvider.isHovered ? 48 : 40,
          child: Transform.rotate(
            angle: hoverIconProvider.isHovered ? 0.08 : 0,
            child: IconButton(
              style: IconButton.styleFrom(
                fixedSize: Size(
                  hoverIconProvider.isHovered ? 48 : 40,
                  hoverIconProvider.isHovered ? 48 : 40,
                ),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                hoverIconProvider.setHovered(!hoverIconProvider.isHovered);
                onPressed();
              },
              icon: icon,
            ),
          ),
        ),
      ),
    );
  }
}
