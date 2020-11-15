import 'dart:convert';

import 'package:flutter/material.dart';

class DetailPhoto extends StatelessWidget {
  String url;

  DetailPhoto(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
              tag: 'image',
              child: Image.network(this.url, width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,)
              ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
