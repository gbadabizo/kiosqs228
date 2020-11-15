import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kiosqs228/models/slide.dart';
import 'package:kiosqs228/widgets/slide_dots.dart';
import 'package:kiosqs228/widgets/slide_item.dart';

class PublicitePage extends StatefulWidget {
  @override
  _PublicitePageState createState() => _PublicitePageState();
}

class _PublicitePageState extends State<PublicitePage> {
  int _currentPage = 0;

  PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if(_pageController.hasClients){
        _pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 10), curve: Curves.easeIn);
      }
    });
    Timer(Duration(seconds: 15),
        () => Navigator.pushReplacementNamed(context, '/home'));
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final slideList = [
    Slide(
        imageUrl: 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.ipnetuniversity.com%2F&psig=AOvVaw1LsvsU7EcWi9q4uSyXTCcC&ust=1604829523915000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIjvjoKW8OwCFQAAAAAdAAAAABAD',//'assets/images/p2.jpg',
        title: ' A cool way to get start',
        description: 'Lorem ipsum dolor'),
    Slide(
        imageUrl: 'https://scontent.flfw2-1.fna.fbcdn.net/v/t1.0-9/123543217_3603243096409406_8270872119378908604_o.jpg?_nc_cat=101&ccb=2&_nc_sid=730e14&_nc_ohc=BvsSJqofdfwAX_raMMz&_nc_ht=scontent.flfw2-1.fna&oh=fcbb774bbce505330b732ff46672a741&oe=5FCDA7C8',
        title: ' A cool way to get start',
        description: 'Lorem ipsum dolor'),
    Slide(
        imageUrl: 'https://scontent.flfw2-1.fna.fbcdn.net/v/t1.0-9/123141317_1513767765460599_8168601901397773715_o.jpg?_nc_cat=101&cb=846ca55b-ee17756f&ccb=2&_nc_sid=730e14&_nc_ohc=xAJUAaD2aXoAX_xO5-H&_nc_ht=scontent.flfw2-1.fna&oh=abad79e1f16d278d8c545c961f70c41c&oe=5FCD2F88',
        title: ' A cool way to get start',
        description: 'Lorem ipsum dolor'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        label:Text("Continuer", style: TextStyle(color: Colors.white),),
        icon: Icon(Icons.arrow_right_alt_outlined, color: Colors.white,size: 15,),
        backgroundColor: Colors.green,

      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Bienvenue sur 228Kiosqs',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
            Container(
                child:  PageView.builder(
                    scrollDirection: Axis.horizontal,
                    onPageChanged: _onPageChanged,
                    controller: _pageController,
                    itemCount: slideList.length,
                    itemBuilder: (context, i) => SlideItem(i),
                  ),
              ),

         /*   Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < slideList.length; i++)
                        if (i == _currentPage)
                          SlideDots(true)
                        else
                          SlideDots(false)
                    ],
                  ),
                )
              ],
            ),*/


        // ),

    );
  }
}
