import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../CommonUtils/image_utils.dart';

class ImageLoader extends StatefulWidget {
 final String imageUrl;

  const ImageLoader({Key key, this.imageUrl}) : super(key: key);

  @override
  State<ImageLoader> createState() => ImageLoaderState();
}

class ImageLoaderState extends State<ImageLoader> with TickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> animation;

  initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,

    )..repeat(reverse:true);
    animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

   Widget loadDefault(
      {String url,
        BoxFit fit: BoxFit.cover,
        double height: double.infinity,
        double width: double.infinity}) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      height: height,
      width: width,

      fit: fit,
      placeholder: (context, url) => Container(
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(6.sp),
        child: FadeTransition(
          opacity: animation,
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
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
      ),
      child: loadDefault(),
    );
  }
}
