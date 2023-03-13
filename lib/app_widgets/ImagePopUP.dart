import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../CommonUtils/image_utils.dart';

class ImagePopUp extends StatefulWidget {
 final String imageUrl;

  const ImagePopUp({Key key, this.imageUrl})
      : super(key: key);

  @override
  State<ImagePopUp> createState() => _ImagePopUpState();
}

class _ImagePopUpState extends State<ImagePopUp> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.sp) ,
        child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            height: 90.w,
            width: 90.w,
            fit: BoxFit.fill,
            placeholder: (context, url) => FadeTransition(
              child: Padding(
                padding: EdgeInsets.all(6.sp),
                child: Image.asset(
                  ImageUtils.getImagePath("logo"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              padding: EdgeInsets.all(4.sp),
              color: Theme.of(context).primaryColor,
              child: Image.asset(
                ImageUtils.getImagePath("logo"),
                fit: BoxFit.contain,
              ),
            )
        ),
      ),
    );
  }
}
