import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:Cliamizer/res/colors.dart';
import 'package:Cliamizer/route/fluro_navigator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';

import '../../CommonUtils/utils.dart';
import '../presenter/base_presenter.dart';
import 'i_base_view.dart';

abstract class BaseState<T extends StatefulWidget, P extends BasePresenter>
    extends State<T> implements IBaseView {
  P mPresenter;

  BaseState() {
    mPresenter = createPresenter();
    mPresenter.view = this;
  }

  P createPresenter();

  @override
  BuildContext getContext() {
    return context;
  }

  @override
  showProgress({bool isDismiss = true}) {
    if (mounted && !_isShowDialog) {
      _isShowDialog = true;
      try {
        showDialog(
          context: context,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Container(
                height: 30.h,
                alignment: Alignment.center,
                child: Lottie.asset('assets/images/png/loading.json', width: 10.w),
              ),
            );
          },
        );
      } catch (e) {
        print(e);
      }
    }
  }


  bool _isShowDialog = false;
  @override
  void closeProgress() {
    if (mounted && _isShowDialog) {
      _isShowDialog = false;
      NavigatorUtils.goBack(context);
      print('*************** closed');
    }
  }

  String formatDateTime(String date) {
    return DateFormat.yMMMd().format(DateTime.parse(date));
  }


  @override
  void showToasts(String msg, String status) {
    showToast(msg,position: ToastPosition.bottom);
  }


  void showSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 2000),
      content: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.sp),
            child: Container(
              height: 5.h,
              color: MColors.black.withOpacity(0.8),
            ),
          ),
          Container(
            height: 5.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.sp)),
            child: Center(
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: MColors.white),
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  @override
  double sWidth(double w){
    return MediaQuery.of(context).size.width*(w/100);
  }

  @override
  double sHeight(double h){
    return MediaQuery.of(context).size.height*(h/100);
  }
  @override
  double sTextSize(double w, double t){
    return kIsWeb?w:t.sp;
  }

  @override
  void initState() {
    super.initState();
    mPresenter.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mPresenter.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    mPresenter?.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    mPresenter.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  void didUpdateWidgets<W>(W oldWidget) {
    mPresenter?.didUpdateWidget<W>(oldWidget);
  }
}
