import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

part 'state.dart';

class MainShopHandler extends Cubit<ShopState> {
  MainShopHandler() : super(ShopStateInitial()) {
    isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;
    isRTL = CacheHelper.getBoolean(key: 'isRTL') ?? false;
  }
  bool isRTL;
  bool isDark;

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeDirection() {
    isRTL = !isRTL;
    CacheHelper.putBoolean(key: 'isRTL', value: isRTL).then((_) {
      emit(ShopStateToggleDirectionality());
    });
  }

  void toggleDarkTheme() {
    isDark = !isDark;
    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((_) {
      emit(ShopStateToggleDarkTheme());
    });
  }
}
