import 'package:flutter/cupertino.dart';

class Model_chat with ChangeNotifier{

  String _chatString = '';

  String get chatString => _chatString;

  set chatString(String value) {
    _chatString = value;
    notifyListeners();
  }
}