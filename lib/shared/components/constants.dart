import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

Color defaultColor = Colors.blue;

void signOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }), (route) => false);
    }
  });
}
