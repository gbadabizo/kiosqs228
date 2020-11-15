import 'package:flutter/material.dart';
import 'package:kiosqs228/models/job.dart';
import 'package:intl/intl.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_share/flutter_share.dart';
class JobDetail extends StatelessWidget {
  KiosqsService kiosqsService = KiosqsService();
  final Job job;

  JobDetail({@required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          job.libcategorie,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
          actions: <Widget>[
      IconButton(
      icon: Icon(FontAwesomeIcons.share, color: Colors.white),
      onPressed: () {
        share(job.titre, job.source);
      },
    ),
      ]),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )),
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        kiosqsService.BASE_URL +
                            "parution/job/image/" +
                            job.idjobs.toString(),
                        height: MediaQuery.of(context).size.height / 5,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                      )),
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child: Text(
                    job.titre,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Text(
                    job.typecontrat,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: tertiaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Date de cloture: " +
                                (new DateFormat("dd-MM-yyyy")
                                    .format(job.datecloture)),
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Html(data: job.description),
                /*Text(
                  job.description,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),*/

                SizedBox(
                  height: 16,
                ),

                /*       Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: buildRequirements(),
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
/*
  List<Widget> buildRequirements(){
    List<Widget> list = [];
    for (var i = 0; i < getJobsRequirements().length; i++) {
      list.add(buildRequirement(getJobsRequirements()[i]));
    }
    return list;
  }*/
  Future<void> share( titre, content) async {
    print(content);
    await FlutterShare.share(
        title: titre,
        text:   content,
        linkUrl: "",
        chooserTitle: 'Partager cette offre');
  }

  Widget buildRequirement(String requirement) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Flexible(
            child: Text(
              requirement,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
