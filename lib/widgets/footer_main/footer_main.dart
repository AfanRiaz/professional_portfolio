import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../apis/url_opening.dart';
import '../../supabase/supabase_api.dart';
import '../components/footer_hover.dart';

class FooterMain extends StatelessWidget {
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillKey;
  final GlobalKey projectKey;
  final GlobalKey experienceKey;
  final GlobalKey contactKey;

  const FooterMain({
    super.key,
    required this.homeKey,
    required this.aboutKey,
    required this.skillKey,
    required this.projectKey,
    required this.experienceKey,
    required this.contactKey,
  });

  void _scrollToSection(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 750;

        return Column(
          children: [
            // TOP DIVIDER
            Container(
              height: 2,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context)
                        .colorScheme
                        .primary
                        .withValues(alpha: 0.5),
                    Theme.of(context)
                        .colorScheme
                        .secondary
                        .withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(
                isMobile ? 25 : 70,
                isMobile ? 45 : 70,
                isMobile ? 25 : 70,
                25,
              ),
              child: isMobile
                  ? _MobileFooterContent(
                      homeKey: homeKey,
                      aboutKey: aboutKey,
                      skillKey: skillKey,
                      projectKey: projectKey,
                      experienceKey: experienceKey,
                      contactKey: contactKey,
                      scrollToSection: _scrollToSection,
                    )
                  : _DesktopFooterContent(
                      homeKey: homeKey,
                      aboutKey: aboutKey,
                      skillKey: skillKey,
                      projectKey: projectKey,
                      experienceKey: experienceKey,
                      contactKey: contactKey,
                      scrollToSection: _scrollToSection,
                    ),
            ),
          ],
        );
      },
    );
  }
}

class _DesktopFooterContent extends StatelessWidget {
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillKey;
  final GlobalKey projectKey;
  final GlobalKey experienceKey;
  final GlobalKey contactKey;
  final Function(GlobalKey) scrollToSection;

  const _DesktopFooterContent({
    required this.homeKey,
    required this.aboutKey,
    required this.skillKey,
    required this.projectKey,
    required this.experienceKey,
    required this.contactKey,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LOGO
            const Expanded(
              flex: 4,
              child: _FooterBrand(),
            ),

            const SizedBox(width: 60),

            // PAGES
            Expanded(
              flex: 3,
              child: _FooterPages(
                homeKey: homeKey,
                aboutKey: aboutKey,
                skillKey: skillKey,
                projectKey: projectKey,
                scrollToSection: scrollToSection,
              ),
            ),

            const SizedBox(width: 60),

            // MORE
            Expanded(
              flex: 3,
              child: _FooterMore(
                experienceKey: experienceKey,
                contactKey: contactKey,
                scrollToSection: scrollToSection,
              ),
            ),

            const SizedBox(width: 50),

            // SOCIALS
            const _SocialIcons(),
          ],
        ),

        const SizedBox(height: 75),

        const _FooterBottom(),
      ],
    );
  }
}

class _MobileFooterContent extends StatelessWidget {
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillKey;
  final GlobalKey projectKey;
  final GlobalKey experienceKey;
  final GlobalKey contactKey;
  final Function(GlobalKey) scrollToSection;

  const _MobileFooterContent({
    required this.homeKey,
    required this.aboutKey,
    required this.skillKey,
    required this.projectKey,
    required this.experienceKey,
    required this.contactKey,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _FooterBrand(),

        const SizedBox(height: 45),

        _FooterPages(
          homeKey: homeKey,
          aboutKey: aboutKey,
          skillKey: skillKey,
          projectKey: projectKey,
          scrollToSection: scrollToSection,
        ),

        const SizedBox(height: 40),

        _FooterMore(
          experienceKey: experienceKey,
          contactKey: contactKey,
          scrollToSection: scrollToSection,
        ),

        const SizedBox(height: 40),

        const _SocialIcons(),

        const SizedBox(height: 45),

        const _FooterBottom(),
      ],
    );
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AR',
          style: theme.textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: colors.primary,
            letterSpacing: -2,
          ),
        ),

        const SizedBox(height: 15),

        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 320,
          ),
          child: Text(
            'Building pixel-perfect experiences\n'
                'with Flutter.',
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.7,
              fontSize: 17,
              color: colors.primary.withValues(alpha: 0.7),
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterPages extends StatelessWidget {
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey skillKey;
  final GlobalKey projectKey;
  final Function(GlobalKey) scrollToSection;

  const _FooterPages({
    required this.homeKey,
    required this.aboutKey,
    required this.skillKey,
    required this.projectKey,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    return _FooterLinkColumn(
      title: 'PAGES',
      links: const [
        'Home',
        'About',
        'Skills',
        'Projects',
      ],
      onTaps: [
        () {
          scrollToSection(homeKey);
          SupabaseApi().getPdfs();
        },
        () => scrollToSection(aboutKey),
        () => scrollToSection(skillKey),
        () => scrollToSection(projectKey),
      ],
    );
  }
}

class _FooterMore extends StatelessWidget {
  final GlobalKey experienceKey;
  final GlobalKey contactKey;
  final Function(GlobalKey) scrollToSection;

  const _FooterMore({
    required this.experienceKey,
    required this.contactKey,
    required this.scrollToSection,
  });

  @override
  Widget build(BuildContext context) {
    return _FooterLinkColumn(
      title: 'MORE',
      links: const [
        'Certificates',
        'Experience',
        'Contact',
      ],
      onTaps: [
        () {}, // No certificates key available yet
        () => scrollToSection(experienceKey),
        () => scrollToSection(contactKey),
      ],
    );
  }
}

class _FooterLinkColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  final List<VoidCallback> onTaps;

  const _FooterLinkColumn({
    required this.title,
    required this.links,
    required this.onTaps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FooterSectionTitle(
          title: title,
        ),

        const SizedBox(height: 20),

        ...List.generate(links.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 13),
            child: _FooterTextButton(
              title: links[index],
              onTap: onTaps.length > index ? onTaps[index] : () {},
            ),
          );
        }),
      ],
    );
  }
}

class _FooterSectionTitle extends StatelessWidget {
  final String title;

  const _FooterSectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Text(
      title,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: colors.primary,
        fontWeight: FontWeight.w800,
        fontSize: 12,
        letterSpacing: 2.5,
      ),
    );
  }
}

class _FooterTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FooterTextButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FooterHoverProvider>(
      create: (_) => FooterHoverProvider(),
      child: _FooterTextButtonContent(
        title: title,
        onTap: onTap,
      ),
    );
  }
}

class _FooterTextButtonContent extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _FooterTextButtonContent({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hover = context.watch<FooterHoverProvider>();
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        context.read<FooterHoverProvider>().setHover(true);
      },

      onExit: (_) {
        context.read<FooterHoverProvider>().setHover(false);
      },

      child: GestureDetector(
        onTap: onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,

          transform: Matrix4.translationValues(
            hover.isHovered ? 8 : 0,
            0,
            0,
          ),

          padding: const EdgeInsets.symmetric(
            vertical: 2,
          ),

          child: Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: hover.isHovered
                  ? colors.secondary
                  : colors.primary.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
              fontSize: 14
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcons extends StatelessWidget {
  const _SocialIcons();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 750;

    return Flex(
      direction: isMobile ? Axis.horizontal : Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterIconButton(
          icon: FontAwesomeIcons.github,
          onTap: () {
            UrlOpening().gitHubUrl();
          },
        ),

        SizedBox(
          width: isMobile ? 12 : 0,
          height: isMobile ? 0 : 12,
        ),

        _FooterIconButton(
          icon: FontAwesomeIcons.linkedinIn,
          onTap: () {
            UrlOpening().linkedInUrl();
          },
        ),

        SizedBox(
          width: isMobile ? 12 : 0,
          height: isMobile ? 0 : 12,
        ),

        _FooterIconButton(
          icon: FontAwesomeIcons.envelope,
          onTap: () {
            UrlOpening().emailUrl();
          },
        ),
      ],
    );
  }
}

class _FooterIconButton extends StatelessWidget {
  final FaIconData icon;
  final VoidCallback onTap;

  const _FooterIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FooterHoverProvider>(
      create: (context) => FooterHoverProvider(),
      child: _FooterIconButtonContent(
        icon: icon,
        onTap: onTap,
      ),
    );
  }
}

class _FooterIconButtonContent extends StatelessWidget {
  final FaIconData icon;
  final VoidCallback onTap;

  const _FooterIconButtonContent({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hover = context.watch<FooterHoverProvider>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        context.read<FooterHoverProvider>().setHover(true);
      },

      onExit: (_) {
        context.read<FooterHoverProvider>().setHover(false);
      },

      child: GestureDetector(
        onTap: onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,

          width: 40,
          height: 40,

          transform: Matrix4.translationValues(
            0,
            hover.isHovered ? -4 : 0,
            0,
          ),

          decoration: BoxDecoration(
            color: hover.isHovered
                ? colors.primary.withValues(alpha: 0.14)
                : colors.surface.withValues(alpha: 0.35),

            borderRadius: BorderRadius.circular(13),

            border: Border.all(
              color: hover.isHovered
                  ? colors.primary.withValues(alpha: 0.5)
                  : colors.outline.withValues(alpha: 0.15),
            ),

            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(
                  alpha: hover.isHovered ? 0.20 : 0,
                ),
                blurRadius: hover.isHovered ? 18 : 0,
                spreadRadius: hover.isHovered ? 2 : 0,
              ),
            ],
          ),

          child: Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 180),
              scale: hover.isHovered ? 1.08 : 1,

              child: FaIcon(
                icon,
                size: 18,
                color: hover.isHovered
                    ? colors.secondary
                    : colors.primary.withValues(alpha: 0.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterBottom extends StatelessWidget {
  const _FooterBottom();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      children: [
        Container(
          height: 1,
          width: double.infinity,
          color: colors.outline.withValues(alpha: 0.12),
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                '© 2026 Afan Riaz. All rights reserved.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.primary.withValues(alpha: 0.7),
                  fontSize: 12
                ),
              ),
            ),

          ],
        ),
      ],
    );
  }
}
