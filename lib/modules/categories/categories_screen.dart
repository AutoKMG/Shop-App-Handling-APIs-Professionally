import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainShopHandler, MainShopState>(
      builder: (context, state) {
        MainShopHandler mainShopHandler =
            BlocProvider.of<MainShopHandler>(context);
        return ConditionalBuilder(
          condition: mainShopHandler.categoriesData != null,
          builder: (context) {
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return categoryBuilder(
                    mainShopHandler.categoriesData.data.data[index]);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: mainShopHandler.categoriesData.data.data.length,
            );
          },
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Padding categoryBuilder(DataModel dataModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Image(
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            image: NetworkImage(dataModel.image),
          ),
          SizedBox(
            width: 20,
          ),
          Text(dataModel.name),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
