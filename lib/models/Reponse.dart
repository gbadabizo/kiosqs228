

class Reponse{
  final String code ;
  final String message ;
  final bool status;
  final Object datas ;

  Reponse({this.code, this.message, this.status, this.datas});

  @override
  String toString() {
    return 'Reponse{code: $code, message: $message, status: $status, datas: $datas}';
  }

  factory Reponse.fromJson(Map<String, dynamic>json){
    return Reponse(
      code: json['code'],
      message: json['message'],
      //status: json['status'],
        datas: json['datas'],
    );
  }

}