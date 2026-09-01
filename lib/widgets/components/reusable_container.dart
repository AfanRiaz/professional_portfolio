import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theming_app/provider/container_provider.dart';

class ReusableContainer extends StatelessWidget {
  final double numberFontSize;
  final String text;
  final Widget icon;
  final String number;
  final double borderRadius;

  const ReusableContainer({
    super.key,
    required this.numberFontSize,
    required this.text,
    required this.icon,
    required this.number,
    this.borderRadius = 25,
  });

  @override
  Widget build(BuildContext context) {
    final containerProvider = context.watch<ContainerProvider>();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    /// 🌙 DARK THEME
    final darkColor = const Color.fromARGB(255, 38, 40, 71);

    /// ☀️ LIGHT THEME
    final lightColor = const Color.fromARGB(255, 220, 255, 254);

    final containerColor = isDark ? darkColor : lightColor;

    /// BOTTOM LINE COLOR
    final glowColor = isDark
        ? Colors.white
        : const Color.fromARGB(255, 45, 51, 107);

    /// BORDER COLORS
    final normalBorderColor = isDark
        ? const Color(0xFF5267D5).withAlpha(120)
        : const Color(0xFF8FA8FF);

    final hoverBorderColor = const Color(0xFF5267D5);

    return MouseRegion(
      onEnter: (_) {
        containerProvider.setHovered(true);
      },
      onExit: (_) {
        containerProvider.setHovered(false);
      },

      child: LayoutBuilder(
        builder: (context, constraints) {

          /// 📱 Responsive breakpoints
          final isVerySmall = constraints.maxWidth < 120;
          final isSmall = constraints.maxWidth < 180;

          /// Responsive padding
          final padding = isVerySmall
              ? 8.0
              : isSmall
              ? 12.0
              : 25.0;

          /// Responsive icon box
          final iconSize = isVerySmall
              ? 28.0
              : isSmall
              ? 34.0
              : 40.0;

          /// Responsive number font
          final responsiveNumberFont = isVerySmall
              ? numberFontSize * 0.65
              : isSmall
              ? numberFontSize * 0.8
              : numberFontSize;

          /// Responsive title font
          final textFontSize = isVerySmall
              ? 8.0
              : isSmall
              ? 10.0
              : 12.0;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,

            transform: Matrix4.identity()
              ..translate(
                0.0,
                containerProvider.isHovered ? -5.0 : 0.0,
              ),

            decoration: BoxDecoration(
              color: containerColor,

              borderRadius: BorderRadius.circular(borderRadius),

              border: Border.all(
                color: containerProvider.isHovered
                    ? hoverBorderColor
                    : normalBorderColor,
                width: 1.5,
              ),
            ),

            clipBehavior: Clip.antiAlias,

            child: Stack(
              children: [

                /// ============================
                /// 📦 MAIN CONTENT
                /// ============================
                Padding(
                  padding: EdgeInsets.all(padding),

                  child: SizedBox(
                    width: double.infinity,

                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        /// ICON
                        MouseRegion(
                          onEnter: (_) {
                            containerProvider.setIconHovered(true);
                          },
                          onExit: (_) {
                            containerProvider.setIconHovered(false);
                          },
                          cursor: SystemMouseCursors.click,

                          child: Container(
                            height: iconSize,
                            width: iconSize,
                            alignment: Alignment.center,

                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                255,
                                178,
                                178,
                                255,
                              ).withAlpha(50),
                              shape: BoxShape.circle,
                            ),

                            child: AnimatedScale(
                              scale: containerProvider.isIconHovered ? 1.2 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOutCubic,

                              child: TweenAnimationBuilder<Color?>(
                                duration: const Duration(milliseconds: 200),
                                tween: ColorTween(
                                  end: containerProvider.isIconHovered
                                      ? Colors.white
                                      : const Color.fromARGB(255, 169, 181, 223),
                                ),
                                builder: (context, color, child) {
                                  return IconTheme(
                                    data: IconThemeData(
                                      color: color,
                                      size: isVerySmall
                                          ? 14
                                          : isSmall
                                          ? 16
                                          : 20,
                                    ),
                                    child: icon,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: isSmall ? 10 : 20,
                        ),

                        /// NUMBER
                        Text(
                          number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                            fontSize: responsiveNumberFont,
                          ),
                        ),

                        SizedBox(
                          height: isSmall ? 5 : 10,
                        ),

                        /// TITLE
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: isSmall ? 3 : 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: textFontSize,
                          ),
                        ),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),

                /// ============================
                /// ✨ BOTTOM ANIMATED LINE
                /// ============================
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,

                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,

                      height: 3,

                      width: containerProvider.isHovered
                          ? constraints.maxWidth * 0.6
                          : 0,

                      decoration: BoxDecoration(
                        color: glowColor,

                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}