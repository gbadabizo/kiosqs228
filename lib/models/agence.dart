class Agence{
  final int idagence;
  final String code;
  final String nom;
  final String description;

  Agence({this.idagence, this.code, this.nom, this.description});
  Agence.fromJson(Map<dynamic, dynamic> parseJson)
      : idagence = parseJson['idagence'],
        code = parseJson['code'],
        nom = parseJson['nom'],
        description = parseJson['description']
       ;
}