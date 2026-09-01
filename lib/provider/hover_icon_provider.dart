import 'package:flutter/cupertino.dart';

class HoverIconProvider extends ChangeNotifier{
  bool _isHovered = false;

  bool get isHovered => _isHovered;
  void setHovered(bool value){
    if(_isHovered == value) return;
    _isHovered = value;
    notifyListeners();
  }
}