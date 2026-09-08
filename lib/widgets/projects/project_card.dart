import 'package:flutter/material.dart';

class ProjectData {
  final String title;
  final String image;
  final String screenshotCount;
  final String platform;
  final String technology;
  final String actionText;

  const ProjectData({
    required this.title,
    required this.image,
    required this.screenshotCount,
    required this.platform,
    required this.technology,
    this.actionText = "View Project",
  });
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final project = widget.project;

    return MouseRegion(
      cursor: SystemMouseCursors.click,

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
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,

        decoration: BoxDecoration(
          color: colors.surface,

          borderRadius: BorderRadius.circular(20),

          border: Border.all(
            color: isHovered
                ? colors.primary
                : colors.outline.withValues(alpha: 0.25),
            width: 1,
          ),

          boxShadow: [
            BoxShadow(
              color: colors.shadow.withValues(
                alpha: isHovered ? 0.25 : 0.10,
              ),
              blurRadius: isHovered ? 25 : 15,
              spreadRadius: isHovered ? 2 : 0,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              // ============================================================
              // IMAGE AREA
              // ============================================================

              AspectRatio(
                aspectRatio: 1.55,

                child: Stack(
                  fit: StackFit.expand,

                  children: [

                    // ------------------------------------------------------
                    // PROJECT IMAGE
                    // ------------------------------------------------------

                    Image.asset(
                      project.image,
                      fit: BoxFit.cover,
                    ),

                    // ------------------------------------------------------
                    // DARK HOVER OVERLAY
                    // ------------------------------------------------------

                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 250),
                      opacity: isHovered ? 1.0 : 0.0,

                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,

                            colors: [
                              colors.scrim.withValues(alpha: 0.15),
                              colors.scrim.withValues(alpha: 0.75),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // ------------------------------------------------------
                    // PLATFORM BADGE
                    // ------------------------------------------------------

                    Positioned(
                      top: 14,
                      right: 14,

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),

                        padding: const EdgeInsets.symmetric(
                          horizontal: 11,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: isHovered
                              ? colors.primary
                              : colors.surface.withValues(alpha: 0.90),

                          borderRadius: BorderRadius.circular(20),

                          border: Border.all(
                            color: colors.outline.withValues(alpha: 0.20),
                          ),
                        ),

                        child: Text(
                          project.platform,

                          style: theme.textTheme.labelMedium?.copyWith(
                            color: isHovered
                                ? colors.onPrimary
                                : colors.onSurface,

                            fontWeight: FontWeight.w700,

                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),

                    // ------------------------------------------------------
                    // VIEW PROJECT BUTTON
                    // ------------------------------------------------------

                    Center(
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: isHovered ? 1.0 : 0.0,

                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 250),

                          scale: isHovered ? 1.0 : 0.85,

                          child: Material(
                            color: Colors.transparent,

                            child: InkWell(
                              borderRadius: BorderRadius.circular(30),

                              onTap: () {
                                // Add your project navigation here.
                              },

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 11,
                                ),

                                decoration: BoxDecoration(
                                  color: colors.primary,

                                  borderRadius: BorderRadius.circular(30),

                                  boxShadow: [
                                    BoxShadow(
                                      color: colors.shadow.withValues(
                                        alpha: 0.25,
                                      ),
                                      blurRadius: 15,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),

                                child: Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [

                                    Icon(
                                      Icons.visibility_outlined,
                                      size: 18,
                                      color: colors.onPrimary,
                                    ),

                                    const SizedBox(width: 8),

                                    Text(
                                      project.actionText,

                                      style: theme.textTheme.labelLarge
                                          ?.copyWith(
                                        color: colors.onPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
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

              // ============================================================
              // PROJECT INFORMATION
              // ============================================================

              Padding(
                padding: const EdgeInsets.all(18),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    // ------------------------------------------------------
                    // TITLE
                    // ------------------------------------------------------

                    Text(
                      project.title,

                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,

                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colors.onSurface,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ------------------------------------------------------
                    // PROJECT META
                    // ------------------------------------------------------

                    Row(
                      children: [

                        Icon(
                          Icons.photo_library_outlined,
                          size: 16,
                          color: colors.onSurfaceVariant,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          project.screenshotCount,

                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.onSurfaceVariant,
                          ),
                        ),

                        const Spacer(),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),

                          decoration: BoxDecoration(
                            color: colors.primaryContainer,

                            borderRadius: BorderRadius.circular(8),
                          ),

                          child: Text(
                            project.technology,

                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colors.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ------------------------------------------------------
                    // BOTTOM LINE
                    // ------------------------------------------------------

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),

                      height: 2,

                      width: isHovered ? 55 : 30,

                      decoration: BoxDecoration(
                        color: colors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}