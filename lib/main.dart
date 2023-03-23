import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopHandler(),
      child: BlocConsumer<ShopHandler, ShopState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          ShopHandler shopHandler = BlocProvider.of<ShopHandler>(context);
          return MaterialApp(
            title: 'Shop App',
            debugShowCheckedModeBanner: false,
            themeMode: shopHandler.isDark ? ThemeMode.dark : ThemeMode.light,
            theme: appLightTheme,
            darkTheme: appDarkTheme,
            home: Directionality(
              textDirection:
                  shopHandler.isRTL ? TextDirection.rtl : TextDirection.ltr,
              child: Container(),
            ),
          );
        },
      ),
    );
  }
}
