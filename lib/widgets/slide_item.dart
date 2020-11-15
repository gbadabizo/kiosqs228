import 'package:flutter/material.dart';
import 'package:kiosqs228/helpers/code_zone.dart';
import 'package:kiosqs228/models/slide.dart';
import 'package:cached_network_image/cached_network_image.dart';


class SlideItem extends StatelessWidget {

  final int index;
  final slideList = [
    Slide(
        imageUrl: zoneCode.BASE_URL_IMAGE_pub +zoneCode.zone1,
        title: ' A cool way to get start',
        description: 'Lorem ipsum dolor'),
    Slide(
        imageUrl: zoneCode.BASE_URL_IMAGE_pub +zoneCode.zone2 ,
        title: ' A cool way to get start',
        description: 'Lorem ipsum dolor'),
    Slide(
        imageUrl: zoneCode.BASE_URL_IMAGE_pub +zoneCode.zone3,

        title: ' A cool way to get start',
        description: 'Lorem ipsum dolor'),
  ];
  SlideItem(this.index);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: 
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onLongPress: () {
                print("on tap");
              },
              child:
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Hero(
                    tag: 'image',
                    child: CachedNetworkImage(
                      imageUrl: slideList[index].imageUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                              //colorFilter:ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                            ),
                        ),
                      ),
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>    Container(
                         // width: 100.0,
                        //  height: 100.0,
                          decoration: new BoxDecoration(
                           // shape: BoxShape.circle,
                            image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage('assets/images/c1.jpg'),
                                )
                          )),
                    ),


                  ),
              ),
            ),
            /* SizedBox(height:2,),
            Text(
              slideList[index].title,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black45
              ),
              textAlign: TextAlign.start,
            ),*/
          /*  SizedBox(height:3,),
            Text(
              slideList[index].description,
              textAlign: TextAlign.center,
            )*/
          ],
        ),
      ),
    );
  }
}
