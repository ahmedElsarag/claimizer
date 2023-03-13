import 'package:flutter/material.dart';

abstract class IBaseView {
  BuildContext getContext();

  void showProgress();

  void closeProgress();

  void showToasts(String msg);

  void showWarningToasts(String msg);

  double sWidth(double w);
  double sHeight(double h);
  double sTextSize(double web, double tablet);
}
