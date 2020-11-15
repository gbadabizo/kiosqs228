class News {
  final int idnews;
  final String code;
  final DateTime datePublication;
  final String urlSource;
  final String urlvideo;
  final String urlImage1;
  final String urlImage2;
  final String urlImage3;
  final String urlImage4;
  final String urlImage; // image de garde
  final String titre;
  final String contenu;
  final String urlFichier;
  News(
      this.idnews,
      this.code,
      this.datePublication,
      this.urlSource,
      this.urlvideo,
      this.urlImage1,
      this.urlImage2,
      this.urlImage3,
      this.urlImage4,
      this.urlImage,
      this.titre,
      this.contenu,
      this.urlFichier);
  News.fromJson(Map<dynamic, dynamic> parseJson)
      : idnews = parseJson['idnews'],
        titre = parseJson['titre'],
        code = parseJson['code'],
        contenu = parseJson['contenu'],
        urlImage = parseJson['urlImage'],
        urlSource = parseJson['urlSource'],
        urlvideo = parseJson['urlvideo'],
        datePublication = DateTime.parse(parseJson['datePublication']),
        urlFichier = parseJson['urlFichier'],
        urlImage1 = parseJson['urlImage1'],
        urlImage2 = parseJson['urlImage2'],
        urlImage3 = parseJson['urlImage3'],
        urlImage4 = parseJson['urlImage4'];
}
