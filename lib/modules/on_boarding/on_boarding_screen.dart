// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop_app/models/boarding_mode.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  List<BoardingModel> boarding = [
    BoardingModel('Title 1', 'Body 1', 'assets/images/shopping-bag.png'),
    BoardingModel('Title 2', 'Body 2', 'assets/images/basket.png'),
    BoardingModel('Title 3', 'Body 3', 'assets/images/groceries.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: boarding.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: buildBoardingItem(boarding[index]),
                );
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                Text("Test"),
                Spacer(),
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image.asset(model.image),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
