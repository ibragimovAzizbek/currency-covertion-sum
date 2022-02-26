import 'package:currency/core/components/size_config.dart';
import 'package:currency/core/constants/color.dart';
import 'package:currency/core/constants/font.dart';
import 'package:flutter/material.dart';

class MyTextStyle {
  static TextStyle totalBalance(context) {
    SizeConfig().init(context);
    return TextStyle(
        fontSize: getW(MyFont.kMediumFont),
        color: ColorConst.kPrimaryTextColor);
  }

  static TextStyle sumBalance(context) {
    SizeConfig().init(context);
    return TextStyle(
        fontSize: getW(MyFont.kLargeFont), color: ColorConst.kPrimaryTextColor);
  }

  static TextStyle buySellButton(context) {
    SizeConfig().init(context);
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: getW(MyFont.kLargeFont),
      color: ColorConst.kAvatarcha,
    );
  }

  static TextStyle textStyle(context) {
    SizeConfig().init(context);
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: getW(MyFont.kSmallFont),
      color: ColorConst.kBlack,
    );
  }

  static TextStyle priceTextStyle(context) {
    SizeConfig().init(context);
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: getW(MyFont.kExtraSmallFont),
      color: ColorConst.kBlack,
    );
  }

  static TextStyle monyNameTextStyle(context) {
    SizeConfig().init(context);
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: getW(MyFont.kMediumFont),
      color: ColorConst.kBlack,
    );
  }

  static TextStyle somTextStyle(context) {
    SizeConfig().init(context);
    return TextStyle(color: Colors.green, fontSize: MyFont.kSmallFont);
  }
}
