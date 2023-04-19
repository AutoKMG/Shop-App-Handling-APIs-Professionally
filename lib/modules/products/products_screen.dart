import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
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
          condition: mainShopHandler.homeData != null &&
              mainShopHandler.categoriesData != null,
          builder: (context) => builderWidget(mainShopHandler),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget builderWidget(MainShopHandler mainShopHandler) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
            items: mainShopHandler.homeData.data.banners.map((e) {
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
              scrollPhysics: NeverScrollableScrollPhysics(),
              enableInfiniteScroll: true,
              scrollDirection: Axis.horizontal,
              autoPlayCurve: Curves.fastOutSlowIn,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sectionTitle('Categories'),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return categoryBuilder(
                          mainShopHandler.categoriesData.data.data[index]);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: mainShopHandler.categoriesData.data.data.length,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                sectionTitle('New Products'),
              ],
            ),
          ),
          SizedBox(
            width: 10,
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
              children: mainShopHandler.homeData.data.products
                  .map((e) => gridProductBuilder(e, mainShopHandler))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Text sectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget categoryBuilder(DataModel dataModel) {
    return Container(
      alignment: AlignmentDirectional.bottomCenter,
      width: 100,
      height: 100,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(dataModel.image),
            fit: BoxFit.cover,
          ),
          Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              dataModel.name,
              style: TextStyle(color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget gridProductBuilder(
      ProductModel product, MainShopHandler mainShopHandler) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  image: NetworkImage(product.image),
                  width: 175,
                  height: 175,
                ),
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
          ),
        ],
      ),
    );
  }
}
