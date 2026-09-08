import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../provider/skill_container_provider.dart';

class SkillContainer extends StatelessWidget {
  final String title;
  final Widget icon;
  final String description;
  final double proficiency;
  final String id;
  const SkillContainer({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    required this.proficiency,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final darkMode = Theme.of(context).brightness == Brightness.dark;
    final Color iconColor = darkMode
        ? const Color.fromARGB(255, 169, 181, 223)
        : const Color.fromARGB(255, 82, 103, 213);

    final Color iconBoxColor = darkMode
        ? const Color.fromARGB(70, 82, 103, 213)
        : const Color.fromARGB(45, 82, 103, 213);

    final Color iconBoxHoverColor = darkMode
        ? const Color.fromARGB(255, 82, 103, 213)
        : const Color.fromARGB(255, 82, 103, 213);
    final containerState = context.watch<SkillContainerProvider>();
    return AnimatedScale(
        scale: containerState.isHovered ? 1.04 : 1.0,
        duration: Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),

            boxShadow: containerState.isHovered
                ? [
              BoxShadow(
                color: const Color(0xFF9EADD3)
                    .withAlpha(80),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
                  GestureDetector(
                    onTapDown: (_){
                      containerState.setHovered(true);
                    },
                    onTapUp: (_){
                      containerState.setHovered(false);
                    },
                    onTapCancel: (){
                      containerState.setHovered(false);
                    },
                    child: MouseRegion(
                      onEnter: (_){
                        containerState.setHovered(true);
                      },
                      onExit: (_){
                        containerState.setHovered(false);
                      },
                      child: Container(
                        color: darkMode ? const Color.fromARGB(255, 38, 40, 71) : Color.fromARGB(255, 220, 255, 254),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  width: 1,
                                  color: containerState.isHovered ? Colors.lightBlue : Colors.blueAccent
                              )
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: containerState.isHovered ? iconBoxHoverColor : iconBoxColor
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: IconTheme(
                                            data: IconThemeData(
                                              color: containerState.isHovered
                                                  ? Colors.white
                                                  : iconColor,
                                            ),
                                            child: icon,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(title,
                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 15,
                                              color: darkMode ? Colors.white : Colors.black
                                            ),
                                          ),
                                          const SizedBox(height: 2,),
                                          Text(description,
                                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                fontSize: 12,
                                                letterSpacing: 2,
                                                color: Color.fromARGB(255, 90, 110, 160),
                                              )
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: AnimatedProgressBar(proficiency: proficiency, id: id,),
                                    ),
                                    ),

                                    Text("${proficiency.round()}%",
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 11,
                                        color: Color.fromARGB(255, 90, 110, 160),
                                        fontWeight: FontWeight.w900
                                      ),)
                                  ],
                                )

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        height: containerState.isHovered ? 200 : 0,
                        width: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFF7A88C8),
                              Color(0xFFA7B3DE),
                            ],
                          ),
                        ),

                      )
                  )
                ],
              ),
            )

          )

      ),
    );

  }
}

class AnimatedProgressBar extends StatefulWidget {
  final double proficiency;
  final String id;

  const AnimatedProgressBar({
    super.key,
    required this.proficiency,
    required this.id
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
      key: Key('progress-${widget.id}'),

      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !startAnimation) {
          setState(() {
            startAnimation = true;
          });
        }
      },

      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(
          begin: 0,
          end: startAnimation ? widget.proficiency / 100 : 0,
        ),
        duration: const Duration(seconds: 2),
        curve: Curves.easeOutCubic,

        builder: (context, value, child) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 8,
              color: Colors.grey.withAlpha(20),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromARGB(255, 90, 110, 160),  // #4658A0
                        Color.fromARGB(255, 129, 204, 224), // #6678BB
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
