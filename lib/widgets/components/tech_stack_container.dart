import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/container_provider.dart';

class TechStackContainer extends StatelessWidget {
  final String title;
  final List<TechChip> techStackData;
  final double borderRadius;

  const TechStackContainer({
    super.key,
    this.borderRadius = 25,
    required this.title,
    required this.techStackData,
  });

  @override
  Widget build(BuildContext context) {
    final containerProvider = context.watch<ContainerProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    /// 🌙 THEME COLORS
    final containerColor = isDark 
        ? const Color.fromARGB(255, 38, 40, 71) 
        : const Color.fromARGB(255, 220, 255, 254);

    final normalBorderColor = isDark
        ? const Color(0xFF5267D5).withValues(alpha: 0.5)
        : const Color(0xFF8FA8FF);

    final hoverBorderColor = const Color(0xFF5267D5);

    return GestureDetector(
      onTapDown: (_) {
        containerProvider.setHovered(true);
      },
      onTapUp: (_) {
        containerProvider.setHovered(false);
      },
      onTapCancel: () {
        containerProvider.setHovered(false);
      },
      child: MouseRegion(
        onEnter: (_) => containerProvider.setHovered(true),
        onExit: (_) => containerProvider.setHovered(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(25),
          constraints: const BoxConstraints(
            minWidth: 150,
          ),
          transform: Matrix4.translationValues(
            0.0,
            containerProvider.isHovered ? -5.0 : 0.0,
            0.0,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 15),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: techStackData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TechChip extends StatelessWidget {
  final String text;
  final Widget icon;

  const TechChip({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContainerProvider(),
      child: _TechChipContent(text: text, icon: icon),
    );
  }
}

class _TechChipContent extends StatelessWidget {
  final String text;
  final Widget icon;

  const _TechChipContent({
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chipProvider = context.watch<ContainerProvider>();

    /// 🌙 THEME COLORS
    final containerColor = isDark
        ? const Color.fromARGB(255, 38, 40, 71)
        : const Color.fromARGB(255, 220, 255, 254);

    final normalBorderColor = isDark
        ? const Color(0xFF5267D5).withValues(alpha: 0.5)
        : const Color(0xFF8FA8FF);

    final hoverBorderColor = const Color(0xFF5267D5);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark 
            ? Colors.white.withValues(alpha: 0.05) 
            : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark 
              ? Colors.white.withValues(alpha: 0.1) 
              : Colors.black.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTapDown: (_) => chipProvider.setHovered(true),
            onTapUp: (_) => chipProvider.setHovered(false),
            onTapCancel: () => chipProvider.setHovered(false),
            child: MouseRegion(
              onEnter: (_) => chipProvider.setHovered(true),
              onExit: (_) => chipProvider.setHovered(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.all(5),
                transform: Matrix4.translationValues(
                  0.0,
                  chipProvider.isHovered ? -5.0 : 0.0,
                  0.0,
                ),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: chipProvider.isHovered
                        ? hoverBorderColor
                        : normalBorderColor,
                    width: 1.5,
                  ),
                ),
                child: IconTheme(
                  data: IconThemeData(
                    size: 10,
                    color: isDark ? Colors.blueAccent : Colors.blue,
                  ),
                  child: icon,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
