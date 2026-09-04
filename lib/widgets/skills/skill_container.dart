import 'package:flutter/material.dart';

class SkillContainer extends StatelessWidget {
  const SkillContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        GestureDetector(
          child: MouseRegion(
            onEnter: (_){
            },
            onExit: (_){
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 750),
              curve: Curves.bounceInOut,
              decoration: BoxDecoration(
                borderRadius:
              ),
            ),
          ),
        )
      ],
    );
  }
}
