import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

part 'state.dart';

class MainShopHandler extends Cubit<ShopState> {
  MainShopHandler() : super(ShopStateInitial()) {
    isDark = CacheHelper.getData(key: 'isDark') ?? false;
    isRTL = CacheHelper.getData(key: 'isRTL') ?? false;
    isOnBoardingDone = CacheHelper.getData(key: 'isOnBoardingDone') ?? false;
    token = CacheHelper.getData(key: 'token');
    if (isOnBoardingDone) {
      if (token != null)
        displayedWidget = ShopLayout();
      else
        displayedWidget = LoginScreen();
    } else {
      displayedWidget = OnBoardingScreen();
    }
  }
  bool isRTL;
  bool isDark;
  bool isOnBoardingDone;
  String token;
  Widget displayedWidget;

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeDirection() {
    isRTL = !isRTL;
    CacheHelper.putData(key: 'isRTL', value: isRTL).then((_) {
      emit(ShopStateToggleDirectionality());
    });
  }

  void toggleDarkTheme() {
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((_) {
      emit(ShopStateToggleDarkTheme());
    });
  }
}
