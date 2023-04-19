import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/shop_login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'state.dart';

class MainShopHandler extends Cubit<MainShopState> {
  MainShopHandler() : super(MainShopStateInitial()) {
    init();
  }
  void init() {
    isDark = CacheHelper.getData(key: 'isDark') ?? false;
    isRTL = CacheHelper.getData(key: 'isRTL') ?? false;
    isOnBoardingDone = CacheHelper.getData(key: 'isOnBoardingDone') ?? false;
    token = CacheHelper.getData(key: 'token');
    homeData = null;
    categoriesData = null;
    favoritesData = null;
    userModel = null;
    print(token);
    lang = CacheHelper.getData(key: 'lang') ?? 'en';
    if (isOnBoardingDone) {
      if (token != null)
        displayedWidget = ShopLayout();
      else
        displayedWidget = LoginScreen();
    } else {
      displayedWidget = OnBoardingScreen();
    }
    getHomeData();
    getCategories();
    getFavorites();
    getProfile();
  }

  bool isRTL;
  bool isDark;
  bool isOnBoardingDone;
  String token;
  Widget displayedWidget;
  int currentIndex = 0;
  HomeModel homeData;
  CategoriesModel categoriesData;
  FavoritesModel favoritesData;
  ShopLoginModel userModel;
  String lang;
  Map<int, bool> favorites = {};
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

  void getHomeData() {
    emit(MainShopStateProductsRetrieveLoading());
    DioHelper.getData(url: HOME, token: token, lang: lang).then((value) {
      homeData = HomeModel.fromJson(value.data);
      homeData.data.products.forEach((element) {
        favorites[element.id] = element.inFavorties;
      });
      emit(MainShopStateProductsRetrieveDone());
    }).catchError((error) {
      print(error.toString());
      emit(MainShopStateProductsRetrieveError(error.toString()));
    });
  }

  void getCategories() {
    emit(MainShopStateCategoriesRetrieveLoading());

    DioHelper.getData(url: GET_CATEGORIES, lang: lang).then(
      (value) {
        categoriesData = CategoriesModel.fromJson(value.data);
        emit(MainShopStateCategoriesRetrieveDone());
      },
    ).catchError((error) {
      print(error.toString());
      emit(MainShopStateCategoriesRetrieveError(error.toString()));
    });
  }

  void toggleProductFavorite(int productId) {
    favorites[productId] = !favorites[productId];
    emit(MainShopStateLocalProductFavoriteChange());
    DioHelper.postData(
            url: FAVORITES,
            data: {"product_id": productId},
            lang: lang,
            token: token)
        .then((value) {
      if (!value.data['status']) {
        favorites[productId] = !favorites[productId];
        showFlutterToast(value.data['message'], Colors.red, Toast.LENGTH_SHORT);
      } else {
        getFavorites();
      }
      emit(MainShopStateProductFavoriteChangeSuccess());
      print(value);
    }).catchError((error) {
      print(error.toString());
      emit(MainShopProductFavoriteChangeError(error.toString()));
    });
  }

  void getFavorites() {
    emit(MainShopStateFavoritesRetrieveLoading());

    DioHelper.getData(url: FAVORITES, lang: lang, token: token).then(
      (value) {
        favoritesData = FavoritesModel.fromJson(value.data);
        emit(MainShopStateFavoritesRetrieveDone());
      },
    ).catchError((error) {
      print(error.toString());
      emit(MainShopStateFavoritesRetrieveError(error.toString()));
    });
  }

  void getProfile() {
    DioHelper.getData(url: PROFILE, lang: lang, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(MainShopStateProfileRetrieveDone());
    }).catchError((error) {
      print(error.toString());
      emit(MainShopStateProfileRetrieveError(error.toString()));
    });
  }
}
