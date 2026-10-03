import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../supabase/supabase_api.dart';
import '../components/toast_helper.dart';

class DialogueBoxContainer extends StatefulWidget {
  final String title;
  final List<String> images;
  final String actionText;
  final String platform;

  const DialogueBoxContainer({
    super.key,
    required this.title,
    required this.images,
    this.actionText = "View",
    this.platform = "APP",
  });

  @override
  State<DialogueBoxContainer> createState() =>
      _DialogueBoxContainerState();
}

class _DialogueBoxContainerState extends State<DialogueBoxContainer> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  int _currentIndex = 0;

  Future<void> _handleAction(BuildContext context) async {
    final bool isWeb = widget.platform == "WEB" || widget.actionText == "View Live";

    if (isWeb) {
      try {
        final url = Uri.parse('https://revora-web-ten.vercel.app/');
        final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
        if (launched) {
          if (!mounted) return;
          showCenteredToast(context, "Opening live preview...", isError: false);
        } else {
          if (!mounted) return;
          showCenteredToast(context, "Cannot open live preview", isError: true);
        }
      } catch (e) {
        if (!mounted) return;
        showCenteredToast(context, "Cannot open live preview", isError: true);
      }
    } else {
      showCenteredToast(context, "download unavailable");
      // try {
      //   final downloaded = await SupabaseApi().downloadResume();
      //   if (downloaded) {
      //     if (!mounted) return;
      //     showCenteredToast(context, "Download started", isError: false);
      //   } else {
      //     if (!mounted) return;
      //     showCenteredToast(context, "Cannot download", isError: true);
      //   }
      // } catch (e) {
      //   if (!mounted) return;
      //   showCenteredToast(context, "Cannot download", isError: true);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final bool isWeb = widget.platform == "WEB" || widget.actionText == "View Live";
    final String buttonLabel = isWeb ? "View Live" : "Download";

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = MediaQuery.sizeOf(context).width;

          final bool isMobile = screenWidth < 650;

          final double dialogWidth =
              isMobile ? size.width * 0.88 : size.width * 0.6;

          final double dialogHeight = size.height * 0.85;

          return Center(
            child: Container(
              width: dialogWidth,
              height: dialogHeight,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(
                  isMobile ? 24 : 32,
                ),
                border: Border.all(
                  color: colors.outlineVariant.withValues(
                    alpha: 0.5,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors.shadow.withValues(
                      alpha: 0.30,
                    ),
                    blurRadius: 50,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  isMobile ? 24 : 32,
                ),
                child: Column(
                  children: [
                    // ─────────────────────────────
                    // HEADER
                    // ─────────────────────────────
                    _buildHeader(
                      context,
                      title: widget.title,
                      isMobile: isMobile,
                    ),

                    // ─────────────────────────────
                    // CAROUSEL
                    // ─────────────────────────────
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 12 : 28,
                          vertical: isMobile ? 8 : 12,
                        ),
                        child: LayoutBuilder(
                          builder: (context, carouselConstraints) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                // IMAGE CAROUSEL
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    isMobile ? 18 : 24,
                                  ),
                                  child: CarouselSlider.builder(
                                    carouselController: _carouselController,
                                    itemCount: widget.images.length,
                                    itemBuilder: (
                                      context,
                                      index,
                                      realIndex,
                                    ) {
                                      return _buildImage(
                                        context,
                                        widget.images[index],
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: carouselConstraints.maxHeight,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      enableInfiniteScroll:
                                          widget.images.length > 1,
                                      autoPlay: false,
                                      onPageChanged: (
                                        index,
                                        reason,
                                      ) {
                                        setState(() {
                                          _currentIndex = index;
                                        });
                                      },
                                    ),
                                  ),
                                ),

                                // LEFT BUTTON
                                if (widget.images.length > 1)
                                  Positioned(
                                    left: isMobile ? 8 : 16,
                                    child: _CarouselButton(
                                      icon: Icons.chevron_left_rounded,
                                      onPressed: () {
                                        _carouselController.previousPage(
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          curve: Curves.easeOutCubic,
                                        );
                                      },
                                    ),
                                  ),

                                // RIGHT BUTTON
                                if (widget.images.length > 1)
                                  Positioned(
                                    right: isMobile ? 8 : 16,
                                    child: _CarouselButton(
                                      icon: Icons.chevron_right_rounded,
                                      onPressed: () {
                                        _carouselController.nextPage(
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          curve: Curves.easeOutCubic,
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),

                    // ─────────────────────────────
                    // FOOTER
                    // ─────────────────────────────
                    _buildFooter(
                      context,
                      isMobile: isMobile,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          foregroundColor: colors.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () => _handleAction(context),
                        child: Text(
                          buttonLabel,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(
    BuildContext context, {
    required String title,
    required bool isMobile,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        isMobile ? 20 : 32,
        isMobile ? 18 : 28,
        isMobile ? 12 : 24,
        isMobile ? 8 : 16,
      ),
      child: Row(
        children: [
          // TITLE
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontSize: isMobile ? 18 : 28,
                fontWeight: FontWeight.w800,
                color: colors.onSurface,
                letterSpacing: -0.5,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // CLOSE BUTTON
          Material(
            color: colors.surfaceContainerHighest.withValues(
              alpha: 0.7,
            ),
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: isMobile ? 42 : 54,
                height: isMobile ? 42 : 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: colors.outlineVariant.withValues(
                      alpha: 0.6,
                    ),
                  ),
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: isMobile ? 22 : 27,
                  color: colors.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // IMAGE
  // ============================================================

  Widget _buildImage(
    BuildContext context,
    String imagePath,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (imagePath == "NO_IMAGE" || imagePath.isEmpty) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: colors.surfaceContainerHighest,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                size: 54,
                color: colors.primary.withValues(alpha: 0.75),
              ),
              const SizedBox(height: 12),
              Text(
                'No Images Available',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: colors.surfaceContainerHighest,
      child: Image(
        image: imagePath.startsWith('http')
            ? NetworkImage(imagePath)
            : AssetImage(imagePath) as ImageProvider,
        fit: BoxFit.contain,
        errorBuilder: (
          context,
          error,
          stackTrace,
        ) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.image_not_supported_outlined,
                  size: 54,
                  color: colors.primary.withValues(alpha: 0.75),
                ),
                const SizedBox(height: 12),
                Text(
                  'No Images Available',
                  style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // FOOTER
  // ============================================================

  Widget _buildFooter(
    BuildContext context, {
    required bool isMobile,
  }) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        4,
        20,
        isMobile ? 12 : 20,
      ),
      child: Column(
        children: [
          // DOT INDICATORS
          if (widget.images.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (index) {
                  final bool active = index == _currentIndex;

                  return AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: active ? 18 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: active
                          ? colors.primary
                          : colors.onSurfaceVariant.withValues(alpha: 0.25),
                    ),
                  );
                },
              ),
            ),

          const SizedBox(height: 8),

          // PAGE NUMBER
          Text(
            '${_currentIndex + 1} / ${widget.images.length}',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// CAROUSEL BUTTON
// ================================================================

class _CarouselButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CarouselButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_CarouselButton> createState() => _CarouselButtonState();
}

class _CarouselButtonState extends State<_CarouselButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedScale(
        scale: isHovered ? 1.08 : 1,
        duration: const Duration(
          milliseconds: 180,
        ),
        child: Material(
          color: colors.surfaceContainerHighest.withValues(alpha: 0.85),
          elevation: isHovered ? 8 : 3,
          shadowColor: colors.shadow.withValues(
            alpha: 0.25,
          ),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: widget.onPressed,
            child: SizedBox(
              width: 54,
              height: 54,
              child: Icon(
                widget.icon,
                size: 30,
                color: colors.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
