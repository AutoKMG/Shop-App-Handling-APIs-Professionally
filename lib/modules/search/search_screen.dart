import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/logic/search/handler.dart';
import 'package:shop_app/shared/logic/search/state.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: BlocProvider(
        create: (context) => SearchHandler(),
        child: BlocBuilder<SearchHandler, SearchStates>(
          builder: (context, state) {
            SearchHandler searchHandler = context.read();
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    context: context,
                    controller: searchController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter something to search about';
                      }
                      return null;
                    },
                    label: 'Search',
                    prefix: Icons.search,
                    onSubmit: searchHandler.searchProducts,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is SearchStatesLoading) LinearProgressIndicator(),
                  if (searchHandler.searchModel != null)
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return gridProductBuilder(
                              searchHandler.searchModel.data.productData[index],
                              BlocProvider.of<MainShopHandler>(context),
                              isOldPrice: false);
                        },
                        itemCount:
                            searchHandler.searchModel.data.productData.length,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
