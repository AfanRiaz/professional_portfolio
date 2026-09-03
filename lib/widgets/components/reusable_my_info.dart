import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theming_app/provider/container_provider.dart';

class ReusableMyInfo extends StatelessWidget {
  final Widget icon;
  final String heading;
  final Widget content;

  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double headingFontSize;

  const ReusableMyInfo({
    super.key,
    required this.icon,
    required this.heading,
    required this.content,
    this.borderRadius = 15,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
    this.headingFontSize = 8,
  });

  @override
  Widget build(BuildContext context) {
    final containerProvider = context.watch<ContainerProvider>();

    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    /// MAIN CONTAINER COLOR
    final containerColor = isDark
        ? const Color.fromARGB(255, 38, 40, 71)
        : const Color.fromARGB(255, 220, 255, 254);

    /// MAIN CONTAINER BORDER
    final normalBorderColor = isDark
        ? const Color(0xFF5267D5).withAlpha(120)
        : const Color(0xFF8FA8FF);

    final hoverBorderColor = isDark
        ? const Color(0xFF8FA8FF)
        : const Color(0xFF5267D5);

    /// ICON BOX COLORS
    final normalIconBoxColor = isDark
        ? const Color.fromARGB(255, 67, 73, 110)
        : const Color.fromARGB(255, 200, 215, 255);

    final hoverIconBoxColor = const Color(0xFF5267D5);

    /// ICON COLORS
    final normalIconColor = isDark
        ? const Color.fromARGB(255, 169, 181, 223)
        : const Color(0xFF5267D5);

    return GestureDetector(
      onTapDown: (_) {
        containerProvider.setHovered(true);
        containerProvider.setIconHovered(true);
      },
      onTapUp: (_) {
        containerProvider.setHovered(false);
        containerProvider.setIconHovered(false);
      },
      onTapCancel: () {
        containerProvider.setHovered(false);
        containerProvider.setIconHovered(false);
      },
      child: MouseRegion(
        onEnter: (_) {
          containerProvider.setHovered(true);
        },
        onExit: (_) {
          containerProvider.setHovered(false);
        },
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,

        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(borderRadius),

          border: Border.all(
            color: containerProvider.isHovered
                ? hoverBorderColor
                : normalBorderColor,

            width:  1,
          ),
        ),

        child: Padding(
          padding: padding,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              /// 🔵 ICON RECTANGLE
              MouseRegion(
                onEnter: (_) {
                  containerProvider.setIconHovered(true);
                },
                onExit: (_) {
                  containerProvider.setIconHovered(false);
                },
                cursor: SystemMouseCursors.click,

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,

                  width: 40,
                  height: 40,

                  decoration: BoxDecoration(
                    color: containerProvider.isIconHovered
                        ? hoverIconBoxColor
                        : normalIconBoxColor,

                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Center(
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,

                      scale: containerProvider.isIconHovered
                          ? 1.25
                          : 1.0,

                      child: TweenAnimationBuilder<Color?>(
                        duration: const Duration(milliseconds: 200),

                        tween: ColorTween(
                          end: containerProvider.isIconHovered
                              ? Colors.white
                              : normalIconColor,
                        ),

                        builder: (context, color, child) {
                          return IconTheme(
                            data: IconThemeData(
                              color: color,
                            ),
                            child: icon,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 18),

              /// 📝 HEADING + CONTENT
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// HEADING
                    Text(
                      heading.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                        fontSize: headingFontSize,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 2.5,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// CONTENT
                    content,
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