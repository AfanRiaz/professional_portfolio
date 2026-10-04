import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../apis/email_service.dart';
import '../../apis/url_opening.dart';
import '../../provider/contact_provider.dart';
import '../../supabase/supabase_api.dart';
import '../components/toast_helper.dart';

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
          icon: const Icon(Icons.email_rounded),
          label: 'EMAIL',
          value: 'cadetafan202@gmail.com',
          onTap: () {
            UrlOpening().emailUrl();
          },
        ),

        const SizedBox(height: 20),

        _HoverContactCard(
          icon: const Icon(Icons.phone_rounded),
          label: 'PHONE',
          value: '+92-341-5035548',
          onTap: () {
            UrlOpening().phoneUrl();
          },
        ),

        const SizedBox(height: 20),

        _HoverContactCard(
          icon: const Center(
            child: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.lightGreen,
            ),
          ),
          label: 'WHATSAPP',
          value: 'Chat on WhatsApp →',
          isAccent: true,
          onTap: () {
            UrlOpening().whatsappUrl();
          },
        ),

        const SizedBox(height: 20),

        _HoverContactCard(
          icon: const Icon(Icons.location_on_rounded),
          label: 'LOCATION',
          value: 'Rawalpindi, Pakistan',
          onTap: () {},
        ),

        const SizedBox(height: 28),

        const _SocialButtons(),
      ],
    );
  }
}

class _HoverContactCard extends StatelessWidget {
  final Widget icon;
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
  final Widget icon;
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
    const darkColor = Color.fromARGB(255, 38, 40, 71);

    /// ☀️ LIGHT THEME
    const lightColor = Color.fromARGB(255, 220, 255, 254);
    final Size size = MediaQuery.of(context).size;

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
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.008,
            vertical: size.height * 0.02,
          ),
          decoration: BoxDecoration(
            color: isDark ? darkColor : lightColor,
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
                offset: Offset.zero,
              ),
            ],
          ),
          child: Row(
            children: [
              // ICON
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accentColor.withValues(
                    alpha: hoverProvider.isHovered ? 0.18 : 0.10,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: icon,
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
                        fontSize: 10,
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
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // COPY BUTTON FOR EMAIL / PHONE
              if (!isAccent && (label == 'EMAIL' || label == 'PHONE'))
                InkWell(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: value));
                    if (!context.mounted) return;
                    if (label == 'EMAIL') {
                      showCenteredToast(context, 'Email copied');
                    } else if (label == 'PHONE') {
                      showCenteredToast(context, 'Phone number copied');
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
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
    return Row(
      children: [
        Expanded(
          child: _SocialButton(
            title: 'GitHub',
            icon: const FaIcon(FontAwesomeIcons.github),
            onTap: () {
              UrlOpening().gitHubUrl();
            },
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _SocialButton(
            title: 'LinkedIn',
            icon: const FaIcon(FontAwesomeIcons.linkedin),
            onTap: () {
              UrlOpening().linkedInUrl();
            },
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String title;
  final Widget icon;
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
    const darkColor = Color.fromARGB(255, 38, 40, 71);

    /// ☀️ LIGHT THEME
    const lightColor = Color.fromARGB(255, 220, 255, 254);

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
              icon,
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
    return ChangeNotifierProvider(
      create: (_) => ContactFormProvider(),
      child: const _ContactFormContent(),
    );
  }
}

class _ContactFormContent extends StatelessWidget {
  const _ContactFormContent();

  Future<void> _handleSubmit(BuildContext context) async {
    final formProvider = context.read<ContactFormProvider>();
    final name = formProvider.nameController.text.trim();
    final email = formProvider.emailController.text.trim();
    final subject = formProvider.subjectController.text.trim();
    final message = formProvider.messageController.text.trim();

    if (name.isEmpty || email.isEmpty || subject.isEmpty || message.isEmpty) {
      showCenteredToast(
        context,
        'Please fill in all fields before sending.',
        isError: true,
      );
      return;
    }

    formProvider.setSubmitting(true);

    try {
      // 1. Upload to Supabase with 10s timeout
      final supabaseFuture = SupabaseApi().saveContactResponse(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );

      // 2. Send email via EmailJS with 10s timeout
      final emailJsFuture = EmailService().sendEmail(
        name: name,
        email: email,
        subject: subject,
        message: message,
      );

      final results = await Future.wait([supabaseFuture, emailJsFuture]);
      final supabaseSuccess = results[0];
      final emailJsSuccess = results[1];

      if (!context.mounted) return;

      formProvider.setSubmitting(false);

      if (supabaseSuccess || emailJsSuccess) {
        formProvider.clearFields();

        showCenteredToast(
          context,
          'Message sent successfully!',
          isError: false,
        );
      } else {
        showCenteredToast(
          context,
          'Failed to send message or request timed out. Please try again.',
          isError: true,
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      formProvider.setSubmitting(false);
      showCenteredToast(
        context,
        'An unexpected error occurred. Please try again.',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final formProvider = context.watch<ContactFormProvider>();
    final isSubmitting = formProvider.isSubmitting;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    /// 🌙 DARK THEME
    const darkColor = Color.fromARGB(255, 36, 39, 77);

    /// ☀️ LIGHT THEME
    const lightColor = Color.fromARGB(255, 220, 255, 254);

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
              fontSize: 18,
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
                      controller: formProvider.nameController,
                      label: 'Name',
                      hint: 'Afan Riaz',
                    ),
                    const SizedBox(height: 22),
                    _ContactTextField(
                      controller: formProvider.emailController,
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
                      controller: formProvider.nameController,
                      label: 'Name',
                      hint: 'Afan Riaz',
                    ),
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                    child: _ContactTextField(
                      controller: formProvider.emailController,
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
            controller: formProvider.subjectController,
            label: 'Subject',
            hint: 'Project discussion',
          ),

          const SizedBox(height: 25),

          _ContactTextField(
            controller: formProvider.messageController,
            label: 'Message',
            hint: 'Tell me about your project...',
            maxLines: 7,
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: isSubmitting ? null : () => _handleSubmit(context),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: colors.primary,
                disabledBackgroundColor: colors.primary.withValues(alpha: 0.7),
                foregroundColor: colors.onPrimary,
                disabledForegroundColor: colors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: isSubmitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
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
  final TextEditingController? controller;

  const _ContactTextField({
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.controller,
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
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: theme.textTheme.bodyLarge!.copyWith(fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: colors.primary.withValues(alpha: 0.6),
              fontSize: 14,
            ),
            filled: true,
            fillColor: colors.surfaceContainerHighest.withValues(alpha: 0.35),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 10,
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
