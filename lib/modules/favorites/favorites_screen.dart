// ignore_for_file: missing_return

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';

class FavrotiesScreen extends StatelessWidget {
  const FavrotiesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainShopHandler, MainShopState>(
        builder: (context, state) {
      MainShopHandler mainShopHandler =
          BlocProvider.of<MainShopHandler>(context);
      return ConditionalBuilder(
        condition: mainShopHandler.favoritesData != null &&
            mainShopHandler.homeData != null,
        builder: (context) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return gridProductBuilder(
                  mainShopHandler.favoritesData.data.data[index].model,
                  mainShopHandler);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: mainShopHandler.favoritesData.data.data.length,
          );
        },
        fallback: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    });
  }
}
