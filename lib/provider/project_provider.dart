import 'package:flutter/material.dart';

class ProjectHoverProvider extends ChangeNotifier {
  bool _isHovered = false;

  bool get isHovered => _isHovered;

  void setHovered(bool value) {
    if (_isHovered == value) return;
    _isHovered = value;
    notifyListeners();
  }
}

class DialogueBoxProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}

class CarouselButtonHoverProvider extends ChangeNotifier {
  bool _isHovered = false;

  bool get isHovered => _isHovered;

  void setHovered(bool value) {
    if (_isHovered == value) return;
    _isHovered = value;
    notifyListeners();
  }
}
