// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/logic/shop/handler.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainShopHandler, MainShopState>(
      builder: (context, state) {
        MainShopHandler mainShopHandler =
            BlocProvider.of<MainShopHandler>(context);
        return ConditionalBuilder(
            condition: mainShopHandler.userModel != null,
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
            builder: (context) {
              nameController.text = mainShopHandler.userModel.data.name;
              emailController.text = mainShopHandler.userModel.data.email;
              phoneController.text = mainShopHandler.userModel.data.phone;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            if (state is MainShopStateProfileUpdateLoading)
                              LinearProgressIndicator(),
                            defaultFormField(
                              context: context,
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Name cannot be null';
                                }
                                return null;
                              },
                              label: 'Name',
                              prefix: Icons.person_2_rounded,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              context: context,
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Email cannot be null';
                                }
                                return null;
                              },
                              label: 'Email',
                              prefix: Icons.email_outlined,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                              context: context,
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Phone cannot be null';
                                }
                                return null;
                              },
                              label: 'Phone',
                              prefix: Icons.phone,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            'Language',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          DropdownMenu(
                            enableSearch: false,
                            initialSelection: CacheHelper.getData(key: 'lang'),
                            dropdownMenuEntries: [
                              DropdownMenuEntry(value: 'ar', label: 'Arabic'),
                              DropdownMenuEntry(value: 'en', label: 'English')
                            ],
                            onSelected: (value) {
                              CacheHelper.putData(key: 'lang', value: value);
                            },
                            leadingIcon: Icon(Icons.language),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            mainShopHandler.updateProfile(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        child: Text("Update"),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          signOut(context);
                        },
                        child: Text("Sign Out"),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
