import 'package:flutter/material.dart';

class FooterHoverProvider extends ChangeNotifier {
  bool _isHovered = false;

  bool get isHovered => _isHovered;

  void setHover(bool value) {
    if (_isHovered == value) return;

    _isHovered = value;
    notifyListeners();
  }
}