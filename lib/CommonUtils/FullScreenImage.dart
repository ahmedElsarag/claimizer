import 'package:Cliamizer/app_widgets/claimizer_app_bar.dart';
import 'package:Cliamizer/app_widgets/image_loader.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final String image;

  const FullScreenImage({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClaimizerAppBar(
              title: "",
            ),
          ),
          Expanded(
            child: ImageLoader(imageUrl: image),
          ),
        ],
      ),
    );
  }
}