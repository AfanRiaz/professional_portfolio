import 'package:flutter/widgets.dart';

class SkillContainerProvider extends ChangeNotifier {
  bool isHovered = false;

  void setHovered(bool value) {
    isHovered = value;
    notifyListeners();
  }

  void toggleHovered() {
    isHovered = !isHovered;
    notifyListeners();
  }
}

class ProgressBarProvider extends ChangeNotifier {
  bool _startAnimation = false;

  bool get startAnimation => _startAnimation;

  void setStartAnimation(bool value) {
    if (_startAnimation == value) return;
    _startAnimation = value;
    notifyListeners();
  }
}
