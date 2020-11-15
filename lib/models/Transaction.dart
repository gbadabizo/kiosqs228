class Transaction{
  final int idtransaction;
  final String codetransaction;
  final String operateur;
  final int idparution;
  final int statuspay;
  final  DateTime dateop;
  final  DateTime dateParution;
  final  String numParution;
  final String agence ;

  Transaction({this.idtransaction, this.codetransaction, this.operateur,
      this.idparution, this.statuspay, this.dateop, this.dateParution,
      this.numParution, this.agence});
  Transaction.fromJson(Map<dynamic, dynamic> parseJson)
      : idtransaction= parseJson['idtransaction'],
        codetransaction = parseJson['codetransaction'],
        operateur = parseJson['operateur'],
        idparution = parseJson['idparution'],
        statuspay = parseJson['statuspay'],
        dateop =  DateTime.parse(parseJson['dateop']),
         dateParution  = DateTime.parse(parseJson['dateParution']),
        numParution =  parseJson['numParution'],
        agence =  parseJson['agence'];



}