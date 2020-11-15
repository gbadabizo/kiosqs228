import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kiosqs228/screens/parutions_categorie.dart';

class CategorieTile extends StatelessWidget {
  final imageUrl, categorieName , categorieid;

  CategorieTile({this.imageUrl, this.categorieName, this.categorieid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ParutionsCategorie(categorieid: categorieid,categorieName: categorieName,)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 5
        ),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(imageUrl:
                imageUrl,
                width: 120,
                height: 70,
                fit: BoxFit.fitWidth,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black26,
              ),
              child: Text(
                categorieName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
