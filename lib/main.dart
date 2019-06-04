import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'registration/inputPhoneNumber.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return runApp(CupertinoApp(
      home: InputPhoneNumber(),
    ));
}
