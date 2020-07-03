import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../core/consts.dart';
import '../core/flutter_icons.dart';
import '../models/food_model.dart';
import '../widgets/app_clipper.dart';
import '../pages/details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodModel> foodList = FoodModel.list;
  PageController pageController = PageController(
    viewportFraction: 0.85,
  );

  var paddingLeft = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: _buildRightSection(),
            ),
            Container(
              color: AppColors.greenColor,
              height: MediaQuery.of(context).size.height,
              width: 60.0,
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 40.0,
                    height: 40.0,
                    margin: const EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: ExactAssetImage('assets/profile.jpg'),
                      ),
                    ),
                  ),
                  Container(
                    width: 40.0,
                    height: 40.0,
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(FlutterIcons.menu),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Transform.rotate(
                angle: -math.pi / 2,
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _buildMenu('Vegetables', 0),
                        _buildMenu('South Indian', 1),
                        _buildMenu('Thai', 2),
                        _buildMenu('Chicken', 3),
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: EdgeInsets.only(left: paddingLeft),
                      width: 150.0,
                      height: 70.0,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: ClipPath(
                              clipper: AppClipper(),
                              child: Container(
                                width: 150.0,
                                height: 60.0,
                                color: AppColors.greenColor,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Transform.rotate(
                              angle: math.pi / 2,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Icon(
                                  FlutterIcons.arrow,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMenu(String menu, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          paddingLeft = index * 120.0;
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 16.0),
        width: 120.0,
        child: Center(
          child: Text(
            menu,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRightSection() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        children: <Widget>[
          _customAppBar,
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 350.0,
                  child: PageView.builder(
                    controller: pageController,
                    physics: BouncingScrollPhysics(),
                    itemCount: foodList.length,
                    itemBuilder: (context, int index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              foodModel: foodList[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: Stack(
                          children: <Widget>[
                            _buildBackGround(index),
                            Align(
                              alignment: Alignment.topRight,
                              child: Transform.rotate(
                                angle: math.pi / 3,
                                child: Hero(
                                  tag: foodList[index].imgPath,
                                  child: Image.asset(
                                    foodList[index].imgPath,
                                    width: 180.0,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0.0,
                              right: 30.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: AppColors.redColor,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text(
                                  '\$${foodList[index].price.toInt()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Popular',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildPopluarList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackGround(int index) {
    return Container(
      margin: const EdgeInsets.only(
        top: 50.0,
        bottom: 20.0,
        right: 40.0,
      ),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.greenColor,
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: SizedBox()),
          Row(
            children: <Widget>[
              RatingBar(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 10.0,
                unratedColor: Colors.black12,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(width: 10.0),
              Text(
                '120 Reviews',
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
          Text(
            '${foodList[index].name}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopluarList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 20.0, bottom: 16.0, top: 20.0),
      physics: ClampingScrollPhysics(),
      itemCount: foodList.length,
      itemBuilder: (context, int index) {
        return Container(
          padding: EdgeInsets.all(10.0),
          margin: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Image.asset(
                foodList[index].imgPath,
                width: 100.0,
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${foodList[index].name}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: <Widget>[
                      Text(
                        '\$${foodList[index].price.toInt()}',
                        style: TextStyle(
                          color: AppColors.redColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '(${foodList[index].weight.toInt()}gm Weight)',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget get _customAppBar => Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: 'Hello\n',
                style: TextStyle(
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Shailee Weedly',
                    style: TextStyle(
                      color: AppColors.greenColor,
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: AppColors.greenLightColor,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search',
                        ),
                      ),
                    ),
                    const Icon(
                      FlutterIcons.search,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: const Icon(
                  FlutterIcons.shop,
                  size: 16.0,
                ),
              ),
            ),
          ],
        ),
      );
}
