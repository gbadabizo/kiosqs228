import 'package:flutter/material.dart';
import 'package:kiosqs228/styleguide/colors.dart';


class OpaqueImage extends StatelessWidget {
  final imageUrl;

  OpaqueImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {

    return
      Stack(
          children: <Widget>[
            Image.asset(
              imageUrl,
              width: double.maxFinite,
              height: double.maxFinite,
              fit: BoxFit.fill,
            ),
            Container(
              color: tertiaryColor.withOpacity(0.85),
            )
          ],

      );
  }
}
