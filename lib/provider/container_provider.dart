import 'package:flutter/material.dart';

class ContainerProvider extends ChangeNotifier {
  bool isHovered = false;
  bool isIconHovered = false;

  void setHovered(bool value) {
    isHovered = value;
    notifyListeners();
  }

  void toggleHovered() {
    isHovered = !isHovered;
    notifyListeners();
  }

  void setIconHovered(bool value) {
    isIconHovered = value;
    notifyListeners();
  }
}