import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

part 'state.dart';

class MainShopHandler extends Cubit<MainShopState> {
  MainShopHandler() : super(MainShopStateInitial()) {
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
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavrotiesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeDirection() {
    isRTL = !isRTL;
    CacheHelper.putData(key: 'isRTL', value: isRTL).then((_) {
      emit(MainShopStateToggleDirectionality());
    });
  }

  void toggleDarkTheme() {
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((_) {
      emit(MainShopStateToggleDarkTheme());
    });
  }

  void changeCurrentBottomNavIndex(int index) {
    currentIndex = index;
    emit(MainShopStateBottomNavBarIndexChanged());
  }
}
