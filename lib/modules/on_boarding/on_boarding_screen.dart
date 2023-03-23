// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop_app/models/boarding_mode.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  List<BoardingModel> boarding = [
    BoardingModel('Title 1', 'Body 1', 'assets/images/shopping-bag.png'),
    BoardingModel('Title 2', 'Body 2', 'assets/images/shopping-bag.png'),
    BoardingModel('Title 3', 'Body 3', 'assets/images/shopping-bag.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }
}
