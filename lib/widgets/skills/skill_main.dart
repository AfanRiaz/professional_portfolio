import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../themes/custom_themes/text_gradient.dart';

class SkillMain extends StatelessWidget {
  const SkillMain({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Skills",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: const Color.fromARGB(255, 79, 89, 145),
              fontWeight: FontWeight.normal,
            ),
          ),

          /// HEADING
          AfanGradientText(
            text: "My Technical Expertise",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.normal,
                letterSpacing: 0
            ),
          ),

          const SizedBox(height: 10),

          /// DESCRIPTION
          Text(
            "Technology I use to build great Products",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: const Color.fromARGB(255, 79, 89, 145),
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),


        ],
      ),
    );
  }
}





// class HoverLineContainer extends StatefulWidget {
//   final Widget child;
//
//   const HoverLineContainer({
//     super.key,
//     required this.child,
//   });
//
//   @override
//   State<HoverLineContainer> createState() => _HoverLineContainerState();
// }
//
// class _HoverLineContainerState extends State<HoverLineContainer>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//
//   @override
//   void initState() {
//     super.initState();
//
//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) {
//         controller.forward();
//       },
//       onExit: (_) {
//         controller.reverse();
//       },
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           AnimatedBuilder(
//             animation: controller,
//             builder: (context, child) {
//               return Positioned.fill(
//                 left: -20,
//                 child: IgnorePointer(
//                   child: CustomPaint(
//                     painter: LeftAnimatedLinePainter(
//                       progress: controller.value,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//
//           Container(
//             decoration: BoxDecoration(
//               color: const Color(0xFF252A4A),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: widget.child,
//           ),
//         ],
//       ),
//     );
//   }
// }
class LeftAnimatedLinePainter extends CustomPainter {
  final double progress;

  LeftAnimatedLinePainter({
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF9AA9D6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Start from top-left corner
    path.moveTo(20, 0);

    // Come outside the container
    path.lineTo(0, 20);

    // Move down
    path.lineTo(0, size.height - 20);

    // Enter bottom-left corner
    path.lineTo(20, size.height);

    // Animate the path
    final pathMetric = path.computeMetrics().first;

    final animatedPath = pathMetric.extractPath(
      0,
      pathMetric.length * progress,
    );

    canvas.drawPath(animatedPath, paint);
  }

  @override
  bool shouldRepaint(covariant LeftAnimatedLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}


class AnimatedProgressBar extends StatefulWidget {
  final double progress;

  const AnimatedProgressBar({
    super.key,
    required this.progress,
  });

  @override
  State<AnimatedProgressBar> createState() =>
      _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar> {
  bool startAnimation = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('progress-bar'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !startAnimation) {
          setState(() {
            startAnimation = true;
          });
        }
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: startAnimation ? widget.progress : 0,
        ),
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation(
                Color(0xFFAAB7E0),
              ),
            ),
          );
        },
      ),
    );
  }
}