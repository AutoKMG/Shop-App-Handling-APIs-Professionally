// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shop_app/models/boarding_model.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  List<BoardingModel> boarding = [
    BoardingModel('Title 1', 'Body 1', 'assets/images/shopping-bag.png'),
    BoardingModel('Title 2', 'Body 2', 'assets/images/basket.png'),
    BoardingModel('Title 3', 'Body 3', 'assets/images/groceries.png'),
  ];
  var boardController = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: Text(
              "SKIP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardController,
              itemCount: boarding.length,
              physics: new NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                print(value);
                if (value == boarding.length - 1) {
                  isLastPage = true;
                } else {
                  isLastPage = false;
                }
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: buildBoardingItem(boarding[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 15,
                    dotWidth: 15,
                    activeDotColor: defaultColor,
                    expansionFactor: 4,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  heroTag: "previous",
                  child: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    boardController.previousPage(
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                  heroTag: "next",
                  child: Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {
                    if (isLastPage) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 1000),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
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
