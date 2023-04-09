// ignore_for_file: missing_return

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/constants.dart';
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
        condition: state is! MainShopStateFavoritesRetrieveLoading,
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

  Widget gridProductBuilder(
      FavoriteProductModel product, MainShopHandler mainShopHandler) {
    return Container(
      color: Colors.white,
      child: Container(
        height: 175,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(product.image),
                  width: 175,
                  height: 175,
                ),
                if (product.discount != 0)
                  Container(
                      color: Colors.red,
                      child: Text(
                        'DISCOUNT ${product.discount}%',
                        style: TextStyle(color: Colors.white),
                      )),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${product.price}",
                          style: TextStyle(fontSize: 16, color: defaultColor)),
                      SizedBox(
                        width: 10,
                      ),
                      if (product.discount != 0)
                        Text(
                          "${product.oldPrice}",
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      Spacer(),
                      CircleAvatar(
                        backgroundColor: mainShopHandler.favorites[product.id]
                            ? defaultColor
                            : Colors.grey,
                        child: IconButton(
                          icon: Icon(
                            mainShopHandler.favorites[product.id]
                                ? Icons.favorite
                                : Icons.favorite_outline_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            mainShopHandler.toggleProductFavorite(product.id);
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
