import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shoppy")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            CacheHelper.removeData(key: 'token').then((value) {
              if (value) {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }), (route) => false);
              }
            });
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
