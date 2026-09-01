import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:theming_app/themes/custom_themes/text_gradient.dart';

import '../../apis/url_opening.dart';
import '../../provider/hover_icon_provider.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraints) {
      if(size.width >= 950){
        return rowWidget(context, size);
      }
      else {
        return columnWidget(context);
      }
    });
  }

  Widget rowWidget(BuildContext context,Size size){
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi I'm",style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.green),
                ),
                AfanGradientText(text: "Afan Riaz", style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 62,fontWeight: FontWeight.w900)),
                Text("Results-driven Mobile & Web Developer with 1+ years of experience,"
                    ""
                    " passionate about building fast, scalable, and user-focused applications."
                    " Leveraging modern technologies and AI-powered tools to write smarter code,"
                    " ship faster, and turn ideas into impactful digital experiences."),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        child: const Text("Download CV"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        style: Theme.of(context).textButtonTheme.style!.copyWith(
                          shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(30)
                              )
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                              Colors.white.withValues(alpha: 0.05)
                          )
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: const Text("View my Work"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ChangeNotifierProvider(create: (_) => HoverIconProvider(),
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
                    ChangeNotifierProvider(create: (_) => HoverIconProvider(),
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
                    ChangeNotifierProvider(create: (_) => HoverIconProvider(),
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
                Image.asset("assets/images/my_pic.png",
                  width: double.infinity,
                  height: size.height,

                  fit: BoxFit.cover,
                ),
                Positioned.fill(child: DecoratedBox(decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Theme.of(context).scaffoldBackgroundColor,
                          Theme.of(context).scaffoldBackgroundColor.withAlpha(10),
                          Colors.transparent
                        ])
                )))
              ],
            )),
      ],
    );
  }

  Widget columnWidget(BuildContext context){
    return Column(
      children: [

      ],
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
    return MouseRegion(
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
            onPressed: onPressed,
            icon: icon,
          ),
        ),
      ),
    );
  }
}
