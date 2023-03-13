import 'package:flutter/cupertino.dart';
import 'package:Cliamizer/CommonUtils/image_utils.dart';

class ContainerShape extends StatelessWidget {
  const ContainerShape({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [
        Transform.translate(
          // e.g: vertical negative margin
            offset: const Offset(0, -20),
            child: Image.asset(
              ImageUtils.getImagePath('shape'),
              width: double.maxFinite,
              fit: BoxFit.fitWidth,
            )),
        child
      ],
    );
  }
}

