import 'package:flutter/material.dart';
import 'package:theming_app/themes/custom_themes/text_gradient.dart';

class GetApp extends StatelessWidget {
  const GetApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDarkMode ? const Color(0xFF0D1B3D) // Dark blue
          : const Color(0xFFF0F5FF), // Very light blue
      height: 1000,
      width: double.infinity,
      child: Center(
        child: Column(
          children: [
            Text("Featured App",style: Theme.of(context).textTheme.titleSmall!.copyWith(
              letterSpacing: 3,
              fontWeight: FontWeight.w900,
              fontSize: 12
            ),),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "My Flutter",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 2
                    ),
                  ),

                  WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: AfanGradientText(
                      darkRequired: false,
                      text: " Portfolio App",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ]
              )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 180),
              child: Center(child: Text("A premium multi-platform Flutter app connected to Supabase — browse projects, view certificates, download resume, and reach out with a smooth native experience.",textAlign: TextAlign.center,)),
            ),
            SizedBox(height: 20,),
            TechStackSection()
          ],
        ),
      )
    );
  }
}



class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  static const Color backgroundColor = Color(0xFF303557);
  static const Color cardColor = Color(0xFF363B60);
  static const Color borderColor = Color(0xFF464D78);
  static const Color textColor = Color(0xFFD6D3D2);
  static const Color mutedColor = Color(0xFF8E9ABD);
  static const Color greenColor = Color(0xFF4BCB7A);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 50,
      ),
      child: Column(
        children: [
          const TechTimeline(),

          const SizedBox(height: 35),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 700;

              return isMobile
                  ? Column(
                children: const [
                  StackCard(
                    title: 'CORE STACK',
                    chips: [
                      TechChip(
                        label: 'Flutter',
                        icon: Icons.flutter_dash,
                      ),
                      TechChip(
                        label: 'Dart',
                        icon: Icons.change_history_outlined,
                      ),
                      TechChip(
                        label: 'Supabase',
                        icon: Icons.bolt,
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  StackCard(
                    title: 'KEY PACKAGES',
                    chips: [
                      TechChip(
                        label: 'Dio',
                        icon: Icons.wifi,
                      ),
                      TechChip(
                        label: 'Syncfusion PDF',
                        icon: Icons.picture_as_pdf_outlined,
                      ),
                      TechChip(
                        label: 'Loading Anim',
                        icon: Icons.auto_awesome,
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  StackCard(
                    title: 'PLATFORMS',
                    chips: [
                      TechChip(
                        label: 'Android',
                        icon: Icons.android,
                        color: greenColor,
                      ),
                      TechChip(
                        label: 'iOS',
                        icon: Icons.apple,
                      ),
                      TechChip(
                        label: 'Web',
                        icon: Icons.language,
                      ),
                      TechChip(
                        label: 'Desktop',
                        icon: Icons.desktop_windows_outlined,
                      ),
                    ],
                  ),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    child: StackCard(
                      title: 'CORE STACK',
                      chips: [
                        TechChip(
                          label: 'Flutter',
                          icon: Icons.flutter_dash,
                        ),
                        TechChip(
                          label: 'Dart',
                          icon: Icons.change_history_outlined,
                        ),
                        TechChip(
                          label: 'Supabase',
                          icon: Icons.bolt,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 28),

                  Expanded(
                    child: StackCard(
                      title: 'KEY PACKAGES',
                      chips: [
                        TechChip(
                          label: 'Dio',
                          icon: Icons.wifi,
                        ),
                        TechChip(
                          label: 'Syncfusion PDF',
                          icon: Icons.picture_as_pdf_outlined,
                        ),
                        TechChip(
                          label: 'Loading Anim',
                          icon: Icons.auto_awesome,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 28),

                  Expanded(
                    child: StackCard(
                      title: 'PLATFORMS',
                      chips: [
                        TechChip(
                          label: 'Android',
                          icon: Icons.android,
                          color: greenColor,
                        ),
                        TechChip(
                          label: 'iOS',
                          icon: Icons.apple,
                        ),
                        TechChip(
                          label: 'Web',
                          icon: Icons.language,
                        ),
                        TechChip(
                          label: 'Desktop',
                          icon: Icons.desktop_windows_outlined,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class StackCard extends StatelessWidget {
  final String title;
  final List<TechChip> chips;

  const StackCard({
    super.key,
    required this.title,
    required this.chips,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 180,
      ),
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xFF363B60),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF464D78),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: Color(0xFF6070A8),
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 12),

              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFD6D3D2),
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: chips,
          ),
        ],
      ),
    );
  }
}

class TechChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;

  const TechChip({
    super.key,
    required this.label,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = color ?? const Color(0xFF9AA6C9);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF3B4066),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: const Color(0xFF4A507A),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 19,
            color: chipColor,
          ),

          const SizedBox(width: 8),

          Text(
            label,
            style: TextStyle(
              color: chipColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
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
            left: 15,
            right: 15,
            bottom: 0,
            child: Container(
              height: 2,
              color: const Color(0xFF59638D),
            ),
          ),

          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: 2,
              height: 50,
              color: const Color(0xFF59638D),
            ),
          ),

          Positioned(
            right: 0,
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