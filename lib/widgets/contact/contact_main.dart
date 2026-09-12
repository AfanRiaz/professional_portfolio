import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/contact_provider.dart';

class ContactMain extends StatelessWidget {
  const ContactMain({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 850;

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 48,
            vertical: 40,
          ),
          child: isMobile
              ? const _MobileContactLayout()
              : const _DesktopContactLayout(),
        );
      },
    );
  }
}

class _DesktopContactLayout extends StatelessWidget {
  const _DesktopContactLayout();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT SIDE
        Expanded(
          flex: 4,
          child: _ContactInformation(),
        ),

        const SizedBox(width: 70),

        // RIGHT SIDE
        Expanded(
          flex: 7,
          child: _ContactForm(),
        ),
      ],
    );
  }
}

class _MobileContactLayout extends StatelessWidget {
  const _MobileContactLayout();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _ContactInformation(),

        const SizedBox(height: 35),

        const _ContactForm(),
      ],
    );
  }
}

class _ContactInformation extends StatelessWidget {
  const _ContactInformation();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HoverContactCard(
          icon: Icons.email_rounded,
          label: 'EMAIL',
          value: 'junaidkhanzada272@gmail.com',
          onTap: () {},
        ),

        const SizedBox(height: 20),

        _HoverContactCard(
          icon: Icons.phone_rounded,
          label: 'PHONE',
          value: '+92-370-0290153',
          onTap: () {},
        ),

        const SizedBox(height: 20),

        _HoverContactCard(
          icon: Icons.chat_rounded,
          label: 'WHATSAPP',
          value: 'Chat on WhatsApp →',
          isAccent: true,
          onTap: () {},
        ),

        const SizedBox(height: 20),

        _HoverContactCard(
          icon: Icons.location_on_rounded,
          label: 'LOCATION',
          value: 'Karachi, Pakistan',
          onTap: () {},
        ),

        const SizedBox(height: 28),

        const _SocialButtons(),
      ],
    );
  }
}

class _HoverContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isAccent;
  final VoidCallback? onTap;

  const _HoverContactCard({
    required this.icon,
    required this.label,
    required this.value,
    this.isAccent = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HoverProvider(),
      child: _HoverContactCardContent(
        icon: icon,
        label: label,
        value: value,
        isAccent: isAccent,
        onTap: onTap,
      ),
    );
  }
}

class _HoverContactCardContent extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isAccent;
  final VoidCallback? onTap;

  const _HoverContactCardContent({
    required this.icon,
    required this.label,
    required this.value,
    required this.isAccent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hoverProvider = context.watch<HoverProvider>();
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final Color accentColor =
    isAccent ? colors.secondary : colors.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    /// 🌙 DARK THEME
    final darkColor = const Color.fromARGB(255, 38, 40, 71);

    /// ☀️ LIGHT THEME
    final lightColor = const Color.fromARGB(255, 220, 255, 254);

    return MouseRegion(
      cursor: SystemMouseCursors.click,

      onEnter: (_) {
        context.read<HoverProvider>().setHover(true);
      },

      onExit: (_) {
        context.read<HoverProvider>().setHover(false);
      },

      child: GestureDetector(
        onTap: onTap,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,

          transform: Matrix4.translationValues(
            0,
            hoverProvider.isHovered ? -6 : 0,
            0,
          ),

          padding: const EdgeInsets.all(28),

          decoration: BoxDecoration(
            color: isDark
                ? darkColor
                : lightColor,

            borderRadius: BorderRadius.circular(22),

            border: Border.all(
              color: hoverProvider.isHovered
                  ? accentColor.withValues(alpha: 0.5)
                  : colors.outline.withValues(alpha: 0.15),
            ),

            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(
                  alpha: hoverProvider.isHovered ? 0.18 : 0.04,
                ),
                blurRadius: hoverProvider.isHovered ? 28 : 8,
                spreadRadius: hoverProvider.isHovered ? 2 : 0,
                offset: Offset.zero
              ),
            ],
          ),

          child: Row(
            children: [
              // ICON
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),

                width: 64,
                height: 64,

                decoration: BoxDecoration(
                  color: accentColor.withValues(
                    alpha: hoverProvider.isHovered ? 0.18 : 0.10,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Icon(
                  icon,
                  size: 31,
                  color: accentColor,
                ),
              ),

              const SizedBox(width: 22),

              // TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: accentColor.withValues(alpha: 0.7),
                        letterSpacing: 2.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      value,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // COPY BUTTON FOR EMAIL / PHONE
              if (!isAccent &&
                  (label == 'EMAIL' || label == 'PHONE'))
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: colors.outline.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Icon(
                    Icons.content_copy_rounded,
                    size: 20,
                    color: colors.primary.withValues(alpha: 0.7),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: _SocialButton(
            title: 'GitHub',
            icon: Icons.code_rounded,
            onTap: () {},
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: _SocialButton(
            title: 'LinkedIn',
            icon: Icons.business_center_rounded,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    /// 🌙 DARK THEME
    final darkColor = const Color.fromARGB(255, 38, 40, 71);

    /// ☀️ LIGHT THEME
    final lightColor = const Color.fromARGB(255, 220, 255, 254);


    return Material(
      color: isDark ? darkColor : lightColor,
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),

        child: Container(
          height: 68,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colors.outline.withValues(alpha: 0.15),
            ),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: colors.primary,
              ),

              const SizedBox(width: 10),

              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactForm extends StatelessWidget {
  const _ContactForm();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    /// 🌙 DARK THEME
    final darkColor = const Color.fromARGB(255, 36, 39, 77);

    /// ☀️ LIGHT THEME
    final lightColor = const Color.fromARGB(255, 220, 255, 254);

    return Container(
      padding: const EdgeInsets.all(40),

      decoration: BoxDecoration(
        color: isDark ? darkColor : lightColor,

        borderRadius: BorderRadius.circular(28),

        border: Border.all(
          color: colors.outline.withValues(alpha: 0.15),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send a Message',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 35),

          // NAME + EMAIL
          LayoutBuilder(
            builder: (context, constraints) {
              final bool small = constraints.maxWidth < 600;

              if (small) {
                return Column(
                  children: [
                    _ContactTextField(
                      label: 'Name',
                      hint: 'Junaid Khan',
                    ),

                    const SizedBox(height: 22),

                    _ContactTextField(
                      label: 'Email',
                      hint: 'you@example.com',
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _ContactTextField(
                      label: 'Name',
                      hint: 'Junaid Khan',
                    ),
                  ),

                  const SizedBox(width: 30),

                  Expanded(
                    child: _ContactTextField(
                      label: 'Email',
                      hint: 'you@example.com',
                    ),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 25),

          _ContactTextField(
            label: 'Subject',
            hint: 'Project discussion',
          ),

          const SizedBox(height: 25),

          _ContactTextField(
            label: 'Message',
            hint: 'Tell me about your project...',
            maxLines: 7,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 72,

            child: ElevatedButton(
              onPressed: () {},

              style: ElevatedButton.styleFrom(
                elevation: 0,

                backgroundColor: colors.primary,

                foregroundColor: colors.onPrimary,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),

              child: Text(
                'Send Message →',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;

  const _ContactTextField({
    required this.label,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 10),

        TextField(
          maxLines: maxLines,

          style: theme.textTheme.bodyLarge,

          decoration: InputDecoration(
            hintText: hint,

            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: colors.primary.withValues(alpha: 0.6),
            ),

            filled: true,

            fillColor: colors.surfaceContainerHighest
                .withValues(alpha: 0.35),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: colors.outline.withValues(alpha: 0.12),
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: colors.outline.withValues(alpha: 0.12),
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: colors.primary.withValues(alpha: 0.7),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}