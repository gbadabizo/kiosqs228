class Abonnement{
  final int idagabn ;
  final String code ;
  final int montant ;
  final  int montantext ;
  final int  idagence;
  final int  idabonnement ;
  final  String libabonnement ;
  final String nomagence ;

  Abonnement({ this.idagabn,this.code, this.montant, this.montantext, this.idagence,
      this.idabonnement, this.libabonnement, this.nomagence});
  Abonnement.fromJson(Map<dynamic, dynamic> parseJson)

      : code = parseJson['code'],
        idagabn= parseJson['idagabn'],
        montant = parseJson['montant'],
        montantext = parseJson['montantext'],
        idagence = parseJson['idagence'],
        idabonnement = parseJson['idabonnement'],
        libabonnement = parseJson['libabonnement'],
        nomagence = parseJson['nomagence']

  ;

}