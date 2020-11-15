class Parution {
  final int idparution;
  final String code;
  final DateTime dateParution;
  final String numParution;

  final String premierTitre;
  final String descPremierTitre;
  final String secondTitre;
  final String descSecondTitre;
  final int idagence;
  final String libelleAgence;
  final double prixUnit;

  Parution(
      {this.idparution,
      this.code,
      this.dateParution,
      this.numParution,
      this.premierTitre,
      this.descPremierTitre,
      this.secondTitre,
      this.descSecondTitre,
      this.idagence,
      this.libelleAgence,
      this.prixUnit});

  Parution.fromJson(Map<dynamic, dynamic> parseJson)
      : idparution = parseJson['idparution'],
        code = parseJson['code'],
        dateParution = DateTime.parse(parseJson['dateParution']),
        numParution = parseJson['numParution'],
        premierTitre = parseJson['premierTitre'],
        descPremierTitre = parseJson['descPremierTitre'],
        secondTitre = parseJson['secondTitre'],
        descSecondTitre = parseJson['descSecondTitre'],
        idagence = parseJson['idagence'],
        libelleAgence = parseJson['libelleAgence'],
        prixUnit = parseJson['prixUnit'];
}
