import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainShopHandler, MainShopState>(
      builder: (context, state) {
        MainShopHandler mainShopHandler =
            BlocProvider.of<MainShopHandler>(context);
        return ConditionalBuilder(
          condition: mainShopHandler.homeData != null,
          builder: (context) => productsBuilder(mainShopHandler.homeData),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget productsBuilder(HomeModel homeDate) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: homeDate.data.banners.map((e) {
              return Image(
                image: NetworkImage(e.image.split(' ').join('%20')),
                fit: BoxFit.cover,
              );
            }).toList(),
            disableGesture: true,
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(seconds: 1),
              initialPage: 0,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              scrollDirection: Axis.horizontal,
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.57,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              children: homeDate.data.products
                  .map((e) => gridProductBuilder(e))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridProductBuilder(ProductModel product) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product.image),
                width: 200,
                height: 200,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
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
                      IconButton(
                        icon: Icon(Icons.favorite_outline_rounded),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
