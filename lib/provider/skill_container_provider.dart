
import 'package:flutter/widgets.dart';

class SkillContainerProvider extends ChangeNotifier{
  bool isHovered = false;
  setHovered(bool value){
    isHovered = value;
    notifyListeners();
  }
}