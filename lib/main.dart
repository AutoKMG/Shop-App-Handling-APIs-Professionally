import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainShopHandler(),
      child: BlocBuilder<MainShopHandler, MainShopState>(
        builder: (context, state) {
          MainShopHandler mainShopHandler =
              BlocProvider.of<MainShopHandler>(context);
          return MaterialApp(
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            themeMode:
                mainShopHandler.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: appLightTheme,
            darkTheme: appDarkTheme,
            home: Directionality(
              textDirection:
                  mainShopHandler.isRTL ? TextDirection.rtl : TextDirection.ltr,
              child: mainShopHandler.displayedWidget,
            ),
          );
        },
      ),
    );
  }
}
