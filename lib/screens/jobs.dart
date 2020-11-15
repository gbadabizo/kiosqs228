import 'package:flutter/material.dart';
import 'package:kiosqs228/models/job.dart';
import 'package:kiosqs228/screens/job_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiosqs228/services/kiosqs_service.dart';
import 'package:kiosqs228/styleguide/colors.dart';
import 'package:intl/intl.dart';

class Jobs extends StatefulWidget {
  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  List<Job> jobs = []; //getJobs();
  KiosqsService kiosqsService = KiosqsService();
  Future<List<Job>> futureJob;
  bool _loading = true;
  int offset = 0;
  int limit = 10;
  ScrollController _scrollController = new ScrollController();
  Future<List<Job>> refreshJob() async {
    await Future.delayed(Duration(seconds: 2));
    return kiosqsService.geAllJobs(offset, limit);
  }

  Future<List<Job>> getJobs() async {
    futureJob = kiosqsService.geAllJobs(offset, limit);
    return futureJob;
  }

  @override
  void initState() {
    super.initState();
    getJobs();
    _scrollController.addListener(() {
      // print(_scrollController.position.pixels);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //   print(offset);
        limit += 1;
        getJobs();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Offres d'emplois",
          style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshJob,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              right: 10, left: 10, top: 8, bottom: 20),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    )),
                                icon: Icon(
                                  FontAwesomeIcons.search,
                                  size: 18,
                                  color: primaryColor,
                                ),
                                hintText: 'Rechercher par mot clé'),
                          )),
                      Divider(
                        height: 2,
                        color: primaryColor,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                        child: Text(
                          "Quelques propositions d'emploi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Container(
                        height: 150,
                        child: FutureBuilder(
                            future: futureJob,
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasData) {
                                jobs = snapshot.data;
                                return ListView(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: buildRecommendations());
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                      ),

                      // buildLastJobs(),

                      /*   Container(
                        height: 150,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: buildRecommendations(),
                        ),
                      ),*/
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                        child: Text(
                          "Les plus récentes",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(children: [
                          Container(
                            child: FutureBuilder(
                                future: futureJob,
                                builder: (BuildContext context, snapshot) {
                                  if (snapshot.hasData) {
                                    jobs = snapshot.data;
                                    return ListView(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        scrollDirection: Axis.vertical,
                                        children: jobs
                                            .map((Job j) => buildLastJob(j))
                                            .toList());
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ),
                        ]

                            // buildLastJobs(),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilterOption(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.clear,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRecommendations() {
    List<Widget> list = [];
    list.add(SizedBox(
      width: 10,
    ));
    for (var i = 0; i < jobs.length; i++) {
      list.add(buildRecommendation(jobs[i]));
    }
    list.add(SizedBox(
      width: 16,
    ));
    return list;
  }

  Widget buildRecommendation(Job job) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetail(job: job)),
        );
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: secondaryColor.withOpacity(0.8),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      kiosqsService.BASE_URL +
                          "parution/job/image/" +
                          job.idjobs.toString(),
                      height: 50,
                      width: 50,
                      fit: BoxFit.fitWidth,
                    )),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    child: Text(
                      job.pays,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    job.titre,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    job.typecontrat,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLastJob(Job job) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetail(job: job)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.7),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  kiosqsService.BASE_URL +
                      "parution/job/image/" +
                      job.idjobs.toString(),
                  height: 70,
                  width: 70,
                  fit: BoxFit.fitWidth,
                )),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    job.titre,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    job.pays,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    "Publié le " +
                        (new DateFormat("dd-MM-yyyy").format(job.dateannonce)),
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            )),
            Text(
              job.typecontrat,
              style: TextStyle(fontSize: 13, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
