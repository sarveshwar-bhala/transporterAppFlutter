import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveasy/constants/fontSize.dart';
import 'package:liveasy/constants/fontWeights.dart';
import 'package:liveasy/constants/radius.dart';
import 'package:liveasy/constants/spaces.dart';
import 'package:liveasy/widgets/buttons/okButton.dart';

class InvalidDateCondition extends StatefulWidget {
  @override
  _InvalidDateConditionState createState() => _InvalidDateConditionState();
}

class _InvalidDateConditionState extends State<InvalidDateCondition> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        left: space_4,
        right: space_4,
      ),
      title: Column(
        children: [
          Image(
              height: space_9 + 2,
              width: space_11,
              image: AssetImage("assets/icons/errorIcon.png")),
          SizedBox(
            height: space_5,
            width: MediaQuery.of(context).size.width,
          ),
          Text(
            "Invalid Date Condition",
            style: TextStyle(
              fontWeight: mediumBoldWeight,
              fontSize: size_9,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          SizedBox(
            height: space_6 - 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OkButton(),
            ],
          ),
          SizedBox(
            height: space_8,
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(radius_2 - 2)),
      ),
    );
  }
}