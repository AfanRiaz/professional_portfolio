import 'dart:ui';
import 'package:flutter/material.dart';

import 'dialouge_box_container.dart';

class ProjectData {
  final String title;
  final String image;
  final String screenshotCount;
  final String platform;
  final String technology;
  final String screenshotFolder;
  final List<String> screenshots;
  final String actionText;

  const ProjectData({
    required this.title,
    required this.image,
    required this.screenshotCount,
    required this.platform,
    required this.technology,
    required this.screenshotFolder,
    this.screenshots = const [],
    this.actionText = "View Project",
  });

  ProjectData copyWithScreenshots(List<String> images) {
    final bool hasImages = images.isNotEmpty;
    final List<String> finalImages =
        hasImages ? images : const ["NO_IMAGE"];
    final String primaryImage = finalImages.first;

    return ProjectData(
      title: title,
      image: primaryImage,
      screenshotCount:
          hasImages ? '${images.length} screenshots' : '0 screenshots',
      platform: platform,
      technology: technology,
      screenshotFolder: screenshotFolder,
      screenshots: finalImages,
      actionText: actionText,
    );
  }
}

class ProjectContainer extends StatefulWidget {
  final ProjectData project;

  const ProjectContainer({
    super.key,
    required this.project,
  });

  @override
  State<ProjectContainer> createState() => _ProjectContainerState();
}

class _ProjectContainerState extends State<ProjectContainer> {
  bool isHovered = false;

  Widget _buildCardImage(BuildContext context, String displayImage) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (displayImage == "NO_IMAGE" || displayImage.isEmpty) {
      return Container(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.65),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_not_supported_outlined,
                size: 40,
                color: colors.primary.withValues(alpha: 0.75),
              ),
              const SizedBox(height: 8),
              Text(
                "No Images Available",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Image(
      image: displayImage.startsWith('http')
          ? NetworkImage(displayImage)
          : AssetImage(displayImage) as ImageProvider,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: colors.surfaceContainerHighest.withValues(alpha: 0.65),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.image_not_supported_outlined,
                  size: 40,
                  color: colors.primary.withValues(alpha: 0.75),
                ),
                const SizedBox(height: 8),
                Text(
                  "No Images Available",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.project.screenshots.isNotEmpty
        ? widget.project.screenshots
        : [widget.project.image];
    final displayImage = images.first;

    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final project = widget.project;

    return GestureDetector(
      onTap: () async {
        return showDialog(
          context: context,
          barrierColor:
              Theme.of(context).colorScheme.scrim.withValues(alpha: 0.65),
          builder: (context) {
            return DialogueBoxContainer(
              title: project.title,
              images: images,
              platform: project.platform,
            );
          },
        );
      },
      onTapCancel: () => setState(() => isHovered = false),
      child: MouseRegion(
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isHovered ? colors.primary : colors.outline,
              width: 1,
            ),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: colors.primary.withValues(alpha: 45 / 255),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Column(
              children: [
                // ─────────────────────────────
                // IMAGE SECTION
                // ─────────────────────────────
                AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Project image
                      ClipRect(
                        child: AnimatedScale(
                          scale: isHovered ? 1.03 : 1.0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutCubic,
                          child: _buildCardImage(context, displayImage),
                        ),
                      ),

                      // Hover dark overlay
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: isHovered ? 1 : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                colors.primary.withValues(alpha: 35 / 255),
                                colors.scrim.withValues(alpha: 185 / 255),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Platform badge
                      Positioned(
                        top: 18,
                        left: 18,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: isHovered
                                ? colors.primary
                                : colors.surfaceContainerHighest
                                    .withValues(alpha: 220 / 255),
                          ),
                          child: Text(
                            project.platform,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: isHovered
                                  ? colors.onPrimary
                                  : colors.onSurface,
                              fontWeight: FontWeight.w800,
                              fontSize: 10,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),

                      // View Project button
                      Center(
                        child: AnimatedScale(
                          scale: isHovered ? 1 : 0.8,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutBack,
                          child: AnimatedOpacity(
                            opacity: isHovered ? 1 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 2,
                                  sigmaY: 0,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 14,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: colors.surface.withValues(
                                      alpha: 0.35,
                                    ),
                                    border: Border.all(
                                      color: colors.onPrimary.withValues(
                                        alpha: 0.05,
                                      ),
                                      width: 1.2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colors.scrim.withValues(
                                          alpha: 0.20,
                                        ),
                                        blurRadius: 20,
                                        spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    project.actionText,
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ─────────────────────────────
                // INFORMATION SECTION
                // ─────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    26,
                    20,
                    26,
                    20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        project.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: colors.onSurface,
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Screenshot count + platform
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              project.screenshotCount,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: colors.primary,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color:
                                  colors.primary.withValues(alpha: 25 / 255),
                              border: Border.all(
                                color:
                                    colors.primary.withValues(alpha: 90 / 255),
                              ),
                            ),
                            child: Text(
                              project.platform,
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: colors.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
