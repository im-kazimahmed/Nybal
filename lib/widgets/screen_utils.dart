import 'package:flutter/material.dart';

class ScreenUtil {
  static ScreenUtil instance = ScreenUtil();

  late double width;
  late double height;
  late bool allowFontScaling;

  static late MediaQueryData _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _pixelRatio;
  static late double _statusBarHeight;

  static late double _bottomBarHeight;

  static late double _textScaleFactor;

  ScreenUtil({
    this.width = 1080,
    this.height = 1920,
    this.allowFontScaling = false,
  });

  static ScreenUtil getInstance() {
    return instance;
  }

  void init(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    _mediaQueryData = mediaQuery;
    _pixelRatio = mediaQuery.devicePixelRatio;
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _statusBarHeight = mediaQuery.padding.top;
    _bottomBarHeight = _mediaQueryData.padding.bottom;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  static double get textScaleFactory => _textScaleFactor;

  static double get pixelRatio => _pixelRatio;

  static double get screenWidthDp => _screenWidth;

  static double get screenHeightDp => _screenHeight;

  static double get screenWidth => _screenWidth * _pixelRatio;

  static double get screenHeight => _screenHeight * _pixelRatio;

  static double get statusBarHeight => _statusBarHeight;

  static double get bottomBarHeight => _bottomBarHeight;

  get scaleWidth => _screenWidth / instance.width;

  get scaleHeight => _screenHeight / instance.height;

  setWidth(double width) => width * scaleWidth;

  setHeight(double height) => height * scaleHeight;

  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  setSp(double fontSize) => allowFontScaling
      ? setWidth(fontSize)
      : setWidth(fontSize) / _textScaleFactor;
}