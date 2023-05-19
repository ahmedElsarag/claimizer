import 'package:Cliamizer/app_widgets/claimizer_app_bar.dart';
import 'package:Cliamizer/app_widgets/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FullScreenImage extends StatelessWidget {
  final String image;

  const FullScreenImage({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 2.w),
              child: ClaimizerAppBar(
                title: "",
              ),
            ),
            Expanded(
              child: ImageLoader(imageUrl: image),
            ),
          ],
        ),
      ),
    );
  }
}