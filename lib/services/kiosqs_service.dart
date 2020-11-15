import 'dart:convert';

import 'package:kiosqs228/models/Abonnement.dart';
import 'package:kiosqs228/models/LecteurRequest.dart';
import 'package:kiosqs228/models/Parution.dart';
import 'package:http/http.dart' as http;
import 'package:kiosqs228/models/Reponse.dart';
import 'package:kiosqs228/models/abonnement_tile.dart';
import 'package:kiosqs228/models/agence.dart';
import 'package:kiosqs228/models/job.dart';
import 'package:kiosqs228/models/news.dart';

class KiosqsService{
final  BASE_URL='http://192.168.1.66:8080/mobile/';
final BASE_URL_IMAGE="http://192.168.1.66:8080/mobile/parution/image/";
final BASE_URL_PDF="http://192.168.1.66:8080/mobile/parution/pdf/";
//final BASE_URL='http://10.200.10.205:8080/mobile/';
//final BASE_URL_IMAGE="http://10.200.10.205:8080/mobile/parution/image/";
//final BASE_URL_PDF="http://10.200.10.205:8080/mobile/parution/pdf/";
//final BASE_URL='http://10.201.2.156:8080/mobile/';
//final BASE_URL_IMAGE="http://10.201.2.156:8080/mobile/parution/image/";
//final BASE_URL_PDF="http://10.201.2.156:8080/mobile/parution/pdf/";
  Future<List<Parution>>geAllParution() async{
    String url = BASE_URL+"parution/all";
    http.Response response = await http.get(url);
    if(response.statusCode==200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Parution> parutions = body.map((dynamic item)=>Parution.fromJson(item)).toList();
      print(parutions[0].code);
      return parutions;
    }
    return null;
  }
 Future<List<Agence>>geAllAgence() async{
   String url = BASE_URL+"parution/agences";
   http.Response response = await http.get(url);
   if(response.statusCode==200){
     List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
     List<Agence> agences = body.map((dynamic item)=>Agence.fromJson(item)).toList();
     print(agences[0].code);
     return agences;
   }
   return null;
 }
 Future<List<Parution>>geAllParutionByAgence(int idagence, int offset, int limit) async{
   String url = BASE_URL+"parution/all/"+idagence.toString()+"/"+offset.toString()+"/"+limit.toString();
   http.Response response = await http.get(url);
   if(response.statusCode==200){
     List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
     List<Parution> parutions = body.map((dynamic item)=>Parution.fromJson(item)).toList();
     print(parutions[0].code);
     return parutions;
   }
   return null;
 }
Future<List<Parution>>geAllParutionByCategorie(int idcategorie, int offset, int limit) async{
  String url = BASE_URL+"parution/categ/"+idcategorie.toString()+"/"+offset.toString()+"/"+limit.toString();
  http.Response response = await http.get(url);
  if(response.statusCode==200){
    List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
    List<Parution> parutions = body.map((dynamic item)=>Parution.fromJson(item)).toList();
    print(parutions[0].code);
    return parutions;
  }
  return null;
}
 Future<List<Parution>>geAllParutionWithLimit(int offset, int limit) async{
   String url = BASE_URL+"parution/all/"+offset.toString()+"/"+limit.toString();
   http.Response response = await http.get(url);
   if(response.statusCode==200){
     List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
     List<Parution> parutions = body.map((dynamic item)=>Parution.fromJson(item)).toList();
     print(parutions[0].code);
     return parutions;
   }
   return null;
 }
  Future<Reponse> subscribeLecteur({Map body})async{

  String  url=BASE_URL+"suscribe/lecteur/add";
    print("url:"+url);
    http.Response response = await http.post(url, headers: <String, String>{
      'Content-Type':'application/json; charset=UTF-8'
    },
        body: jsonEncode(body)
    );
    print(response.toString());
    if(response!=null){
      Reponse reponse = Reponse.fromJson(json.decode(response.body));
      return reponse ;
    }
    return null ;
  }
 Future<Reponse> getsms(String codeLecteur) async {
  String  url = BASE_URL+"suscribe/sendsms/" + codeLecteur;
   print(url);
   http.Response response = await http.get(url);
   if (response != null) {
     Reponse reponse = Reponse.fromJson(json.decode(response.body));
     print("reponse: " + reponse.toString());
     return reponse ;
   }
   return null;
 }
 Future<Reponse> confirmCode(String codeLecteur, String code) async {
   String url = BASE_URL+ "suscribe/confirm/" + codeLecteur + "/" + code;
   http.Response response = await http.get(url);
   if (response != null) {
     Reponse reponse = Reponse.fromJson(json.decode(response.body));
     print("reponse: " + reponse.toString());
     return reponse;
   }
   return null;
 }
 // verifie si le lecteur a deja payer la revue
 Future<Reponse>checkRevue(int idparution ,String codeLecteur ) async {
    String url = BASE_URL+"parution/Ckeck/" +idparution.toString()+"/"+codeLecteur ;
    http.Response response = await http.get(url);
    if (response != null) {
      Reponse reponse = Reponse.fromJson(json.decode(response.body));
      print("reponse: " + reponse.toString());
      return reponse;
    }
    return null;
 }
 // envoi de payement flooz send/{tel}/{idparution}/{codeLecteur}
 Future<Reponse>sendPay(String tel ,int idparution ,String codeLecteur ) async {
   String url = BASE_URL+"pay/send/"+tel+"/" +idparution.toString()+"/"+codeLecteur ;
   http.Response response = await http.get(url);
   if (response != null) {
     Reponse reponse = Reponse.fromJson(json.decode(response.body));
     print("reponse: " + reponse.toString());
     return reponse;
   }
   return null;
 }
  // envoi de payement  abonnement flooz "abonnement/{codeLecteur}/{idabn}/{tel}"
  Future<Reponse>sendPayAbn(String tel ,int idabn ,String codeLecteur ) async {
    String url = BASE_URL+"pay/abonnement/"+codeLecteur+"/" +idabn.toString()+"/"+tel ;
    http.Response response = await http.get(url);
    if (response != null) {
      Reponse reponse = Reponse.fromJson(json.decode(response.body));
      print("reponse: " + reponse.toString());
      return reponse;
    }
    return null;
  }
 Future<Reponse>checkPay(String codetrans ) async {
   String url = BASE_URL+"pay/check/"+codetrans ;
   http.Response response = await http.get(url);
   if (response != null) {
     Reponse reponse = Reponse.fromJson(json.decode(response.body));
     print("reponse: " + reponse.toString());
     return reponse;
   }
   return null;
 }
  Future<Reponse>checkPayAbn(String codetrans ) async {
    String url = BASE_URL+"pay/ckechpayabn/"+codetrans ;
    http.Response response = await http.get(url);
    if (response != null) {
      Reponse reponse = Reponse.fromJson(json.decode(response.body));
      print("reponse: " + reponse.toString());
      return reponse;
    }
    return null;
  }
 Future<LecteurRequest>getLecteur(String codeLecteur) async{
    print("code lecteur:-----"+codeLecteur);
   String url = BASE_URL+"suscribe/lecteur/"+codeLecteur ;
   print("url ----"+url);
   http.Response response = await http.get(url);
   print("response:sqdsdsd "+response.body);
   if (response != null) {
     LecteurRequest lecteur = LecteurRequest.fromJson(json.decode(response.body));
     print("lecteur: " + lecteur.nom);
     return lecteur;
   }
   return null;
 }
  Future<List<Abonnement>>getAllAbonnmentByAgence(int idagence) async{
    String url = BASE_URL+"pay/agence/"+idagence.toString();
    http.Response response = await http.get(url);
    if(response.statusCode==200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Abonnement> abonnements = body.map((dynamic item)=>Abonnement.fromJson(item)).toList();
      print(abonnements[0].code);
      return abonnements;
    }
    return null;
  }

  Future<List<AbonnementTile>>getAllAbonofLecteur(String codeLecteur) async{
    String url = BASE_URL+"pay/suscribe/"+codeLecteur;
    http.Response response = await http.get(url);
    if(response.statusCode==200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<AbonnementTile> abonnementTiles = body.map((dynamic item)=>AbonnementTile.fromJson(item)).toList();
      print(abonnementTiles[0].agence);
      return abonnementTiles;
    }
    return null;
  }
Future<List<Job>>geAllJobs(int offset, int limit) async{
  String url = BASE_URL+"parution/job/"+offset.toString()+"/"+limit.toString();
print(url);
  http.Response response = await http.get(url);
  print(response.statusCode);
  if(response.statusCode==200){
    List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
    print(body);
    List<Job> jobs = body.map((dynamic item)=>Job.fromJson(item)).toList();
    print("---------"+ jobs[0].titre);
    return jobs;
  }
  return null;
}
  Future<List<News>>getAllNews(int offset, int limit) async{
    String url = BASE_URL+"parution/news/"+offset.toString()+"/"+limit.toString();
    print(url);
    http.Response response = await http.get(url);
    print(response.statusCode);
    if(response.statusCode==200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      print(body);
      List<News> ns = body.map((dynamic item)=>News.fromJson(item)).toList();
      print("---------"+ ns[0].titre);
      return ns;
    }
    return null;
  }
}