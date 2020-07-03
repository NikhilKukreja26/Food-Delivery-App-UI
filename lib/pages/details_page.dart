import 'package:flutter/material.dart';
import 'package:food_delivery_app/core/flutter_icons.dart';

import '../models/food_model.dart';
import '../core/consts.dart';

class DetailsPage extends StatefulWidget {
  final FoodModel foodModel;

  const DetailsPage({
    Key key,
    this.foodModel,
  }) : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: Column(
        children: <Widget>[
          const SizedBox(height: 25.0),
          _customAppBar,
          Container(
            height: 180.0,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                Center(child: Image.asset('assets/bg.png')),
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: widget.foodModel.imgPath,
                    child: Image.asset(widget.foodModel.imgPath),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(28.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${widget.foodModel.name}',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: <Widget>[
                      Text(
                        '\$${widget.foodModel.price.toInt()}',
                        style: TextStyle(
                          color: AppColors.redColor,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 30.0),
                      _buildCounter(),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildInfo(
                          'Weight', '${widget.foodModel.weight.toInt()}gm'),
                      _buildInfo(
                          'Calories', '${widget.foodModel.calory.toInt()}ccal'),
                      _buildInfo(
                          'Protien', '${widget.foodModel.protein.toInt()}gm'),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text('${widget.foodModel.item}'),
                  Expanded(child: SizedBox()),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          color: AppColors.greenColor,
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$title',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(
            color: AppColors.redColor,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  Widget get _customAppBar => Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                  FlutterIcons.left,
                  size: 12.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                FlutterIcons.shop,
                size: 12.0,
              ),
            ),
          ],
        ),
      );

  Widget _buildCounter() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greenColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Colors.black,
              size: 16.0,
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '1',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
              size: 16.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
