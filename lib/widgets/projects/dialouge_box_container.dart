import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/project_provider.dart';
import '../components/toast_helper.dart';

class DialogueBoxContainer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DialogueBoxProvider(),
      child: _DialogueBoxContent(
        title: title,
        images: images,
        actionText: actionText,
        platform: platform,
      ),
    );
  }
}

class _DialogueBoxContent extends StatelessWidget {
  final String title;
  final List<String> images;
  final String actionText;
  final String platform;

  _DialogueBoxContent({
    required this.title,
    required this.images,
    required this.actionText,
    required this.platform,
  });

  final CarouselSliderController _carouselController =
      CarouselSliderController();

  Future<void> _handleAction(BuildContext context) async {
    final bool isWeb = platform == "WEB" || actionText == "View Live";

    if (isWeb) {
      try {
        final url = Uri.parse('https://revora-web-ten.vercel.app/');
        final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
        if (launched) {
          if (!context.mounted) return;
          showCenteredToast(context, "Opening live preview...", isError: false);
        } else {
          if (!context.mounted) return;
          showCenteredToast(context, "Cannot open live preview", isError: true);
        }
      } catch (e) {
        if (!context.mounted) return;
        showCenteredToast(context, "Cannot open live preview", isError: true);
      }
    } else {
      showCenteredToast(context, "download unavailable");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final dialogueProvider = context.watch<DialogueBoxProvider>();
    final currentIndex = dialogueProvider.currentIndex;

    final bool isWeb = platform == "WEB" || actionText == "View Live";
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
                    // HEADER
                    _buildHeader(
                      context,
                      title: title,
                      isMobile: isMobile,
                    ),

                    // CAROUSEL
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
                                    itemCount: images.length,
                                    itemBuilder: (
                                      context,
                                      index,
                                      realIndex,
                                    ) {
                                      return _buildImage(
                                        context,
                                        images[index],
                                      );
                                    },
                                    options: CarouselOptions(
                                      height: carouselConstraints.maxHeight,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      enableInfiniteScroll:
                                          images.length > 1,
                                      autoPlay: false,
                                      onPageChanged: (
                                        index,
                                        reason,
                                      ) {
                                        context
                                            .read<DialogueBoxProvider>()
                                            .setCurrentIndex(index);
                                      },
                                    ),
                                  ),
                                ),

                                // LEFT BUTTON
                                if (images.length > 1)
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
                                if (images.length > 1)
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

                    // FOOTER
                    _buildFooter(
                      context,
                      isMobile: isMobile,
                      currentIndex: currentIndex,
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

  // HEADER
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

  // IMAGE
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

  // FOOTER
  Widget _buildFooter(
    BuildContext context, {
    required bool isMobile,
    required int currentIndex,
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
          if (images.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) {
                  final bool active = index == currentIndex;

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
            '${currentIndex + 1} / ${images.length}',
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

// CAROUSEL BUTTON
class _CarouselButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CarouselButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarouselButtonHoverProvider(),
      child: _CarouselButtonContent(
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}

class _CarouselButtonContent extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CarouselButtonContent({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final hoverProvider = context.watch<CarouselButtonHoverProvider>();
    final isHovered = hoverProvider.isHovered;

    return MouseRegion(
      onEnter: (_) {
        context.read<CarouselButtonHoverProvider>().setHovered(true);
      },
      onExit: (_) {
        context.read<CarouselButtonHoverProvider>().setHovered(false);
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
            onTap: onPressed,
            child: SizedBox(
              width: 54,
              height: 54,
              child: Icon(
                icon,
                color: colors.onSurface,
                size: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
