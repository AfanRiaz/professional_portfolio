import 'package:flutter/material.dart';

import '../../themes/custom_themes/text_gradient.dart';

class ExperienceMain extends StatelessWidget {
  const ExperienceMain({super.key});

  static const List<_ExperienceItem> _items = [
    _ExperienceItem(
      date: 'Feb 2024 – Present',
      type: 'WORK',
      icon: Icons.work_rounded,
      title: 'Mobile App Developer',
      company: 'dSMART Solutions',
      location: 'Karachi, Pakistan',
      description:
      'Building production Flutter & Ionic apps, Angular web platforms, '
          'and Figma-to-code UI implementations. Led key projects: Reyes, '
          'KleanKars, Portkey Express, JI Youth, Helpora.',
    ),
    _ExperienceItem(
      date: 'Aug 2025 – Present',
      type: 'EDUCATION',
      icon: Icons.school_rounded,
      title: 'ADP Software Engineering',
      company: 'Ilma University',
      location: 'Karachi',
      description:
      'Pursuing Associate Degree Program in Software Engineering, '
          'deepening knowledge in algorithms, system design, and full-stack '
          'development.',
    ),
    _ExperienceItem(
      date: '2023 – 2024',
      type: 'WORK',
      icon: Icons.work_rounded,
      title: 'Flutter Developer',
      company: 'Software Company',
      location: 'Pakistan',
      description:
      'Developed responsive mobile applications using Flutter, '
          'integrated REST APIs, and implemented modern UI designs.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 750;


          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: isMobile ? 20 : 50, right: isMobile ? 20 : 50, top: 50,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Experience",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: const Color.fromARGB(255, 79, 89, 145),
                      letterSpacing: 2,
                      fontWeight: FontWeight.normal,
                    ),
                  ),

                  /// HEADING
                  AfanGradientText(
                    text: "Experience",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 40, fontWeight: FontWeight.normal, letterSpacing: 0),
                  ),

                  const SizedBox(height: 10),

                  /// DESCRIPTION
                  Text(
                    "Work experience and Educational milestones.",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: const Color.fromARGB(255, 79, 89, 145),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),),
              Padding(
        padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 50,
        vertical: 50,),
        child: isMobile
            ? _MobileTimeline(items: _items)
            : _DesktopTimeline(items: _items),
        ),


            ],

        );
      },
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              DATA MODEL                                    */
/* -------------------------------------------------------------------------- */

class _ExperienceItem {
  final String date;
  final String type;
  final IconData icon;
  final String title;
  final String company;
  final String location;
  final String description;

  const _ExperienceItem({
    required this.date,
    required this.type,
    required this.icon,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
  });
}

/* -------------------------------------------------------------------------- */
/*                           DESKTOP TIMELINE                                 */
/* -------------------------------------------------------------------------- */

class _DesktopTimeline extends StatelessWidget {
  final List<_ExperienceItem> items;

  const _DesktopTimeline({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // LEFT GRADIENT TIMELINE
        // CENTER GRADIENT LINE
        Positioned.fill(
          child: IgnorePointer(
            child: Center(
              child: Container(
                width: 3,
                decoration: BoxDecoration(
                  gradient: _timelineGradient(context),
                ),
              ),
            ),
          ),
        ),

        Column(
          children: List.generate(
            items.length,
                (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: _DesktopTimelineRow(
                  item: items[index],
                  isLeft: index.isEven,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                         DESKTOP TIMELINE ROW                               */
/* -------------------------------------------------------------------------- */

class _DesktopTimelineRow extends StatelessWidget {
  final _ExperienceItem item;
  final bool isLeft;

  const _DesktopTimelineRow({
    required this.item,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: isLeft
              ? Align(
            alignment: Alignment.centerRight,
            child: _ExperienceCard(item: item),
          )
              : const SizedBox(),
        ),

        // CENTER NODE AREA
        SizedBox(
          width: 90,
          child: Center(
            child: _TimelineNode(),
          ),
        ),

        Expanded(
          child: !isLeft
              ? Align(
            alignment: Alignment.centerLeft,
            child: _ExperienceCard(item: item),
          )
              : const SizedBox(),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              EXPERIENCE CARD                               */
/* -------------------------------------------------------------------------- */

class _ExperienceCard extends StatelessWidget {
  final _ExperienceItem item;

  const _ExperienceCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    /// 🌙 DARK THEME
    final darkColor = const Color.fromARGB(255, 38, 40, 71);

    /// ☀️ LIGHT THEME
    final lightColor = const Color.fromARGB(255, 220, 255, 254);

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        maxWidth: 720,
        minHeight: 300,
      ),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: isDark ? darkColor : lightColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DATE + TYPE
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: _DateBadge(
                  date: item.date,
                ),
              ),

              const SizedBox(width: 15),

              _TypeBadge(
                type: item.type,
                icon: item.icon,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // TITLE
          Text(
            item.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 19,
            ),
          ),

          const SizedBox(height: 18),

          // COMPANY / LOCATION
          Wrap(
            spacing: 8,
            runSpacing: 5,
            alignment: WrapAlignment.end,
            children: [
              Text(
                item.location,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.primary.withValues(alpha: 0.65),
                  fontSize: 12
                ),
              ),
              Text(
                '·',
                style: theme.textTheme.bodyLarge,
              ),
              Text(
                item.company,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // DESCRIPTION
          Text(
            item.description,
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.75,
              fontSize: 14
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              DATE BADGE                                    */
/* -------------------------------------------------------------------------- */

class _DateBadge extends StatelessWidget {
  final String date;

  const _DateBadge({
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colorScheme.primary.withValues(alpha: 0.07),
        border: Border.all(
          color: colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Text(
        date,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: colorScheme.primary.withValues(alpha: 0.7),
          fontWeight: FontWeight.w500,
          fontSize: 10
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              TYPE BADGE                                    */
/* -------------------------------------------------------------------------- */

class _TypeBadge extends StatelessWidget {
  final String type;
  final IconData icon;

  const _TypeBadge({
    required this.type,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: colorScheme.primary.withValues(alpha: 0.13),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 7),
          Text(
            type,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
              fontSize: 11
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            TIMELINE NODE                                   */
/* -------------------------------------------------------------------------- */

class _TimelineNode extends StatelessWidget {
  const _TimelineNode();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 37,
      height: 37,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.surface,
        border: Border.all(
          width: 1,
          color: colorScheme.primary.withValues(alpha: 0.7),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: _timelineGradient(context),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                         MOBILE TIMELINE                                    */
/* -------------------------------------------------------------------------- */

class _MobileTimeline extends StatelessWidget {
  final List<_ExperienceItem> items;

  const _MobileTimeline({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // LEFT GRADIENT TIMELINE
        Positioned(
          left: 24,
          top: 25,
          bottom: 25,
          child: Container(
            width: 2,
            decoration: BoxDecoration(
              gradient: _timelineGradient(context),
            ),
          ),
        ),

        Column(
          children: List.generate(
            items.length,
                (index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 40,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CIRCLE
                    SizedBox(
                      width: 52,
                      child: _TimelineNode(),
                    ),

                    const SizedBox(width: 18),

                    // CARD
                    Expanded(
                      child: _ExperienceCard(
                        item: items[index],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                         TIMELINE GRADIENT                                  */
/* -------------------------------------------------------------------------- */

LinearGradient _timelineGradient(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      colorScheme.primary,
      colorScheme.secondary,
    ],
  );
}