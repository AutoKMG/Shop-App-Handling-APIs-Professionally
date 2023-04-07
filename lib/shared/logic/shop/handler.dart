import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

part 'state.dart';

class MainShopHandler extends Cubit<ShopState> {
  MainShopHandler() : super(ShopStateInitial()) {
    isDark = CacheHelper.getData(key: 'isDark') ?? false;
    isRTL = CacheHelper.getData(key: 'isRTL') ?? false;
    isBoardingDone = CacheHelper.getData(key: 'isBoardingDone');
    token = CacheHelper.getData(key: 'token');
  }
  bool isRTL;
  bool isDark;
  bool isBoardingDone;
  String token;

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
