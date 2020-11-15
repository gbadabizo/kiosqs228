class AbonnementTile{
int idsuscribeagence ;
  String  codeLecteur ;
  String  agence  ;
   String datedeb ;
  String datefin ;

AbonnementTile({this.idsuscribeagence, this.codeLecteur, this.agence,
    this.datedeb, this.datefin});
AbonnementTile.fromJson(Map<dynamic, dynamic> parseJson)

    : idsuscribeagence = parseJson['idsuscribeagence'],
      codeLecteur= parseJson['codeLecteur'],
      agence = parseJson['agence'],
      datedeb = parseJson['datedeb'],
      datefin = parseJson['datefin']
;


}