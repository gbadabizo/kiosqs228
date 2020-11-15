class Job {
  final int idjobs ;
  final String titre ;
  final String description ;
  final String profil;
  final String typecontrat;
  final String pays;
  final String adrjob ;
  final String urlImage ;//
  final DateTime dateannonce;
  final DateTime datecloture;
  final String urlFichier ;
  final int validated;
  final int categorie;
  final String source;
  final String libcategorie ;

  Job(
      this.idjobs,
      this.titre,
      this.description,
      this.profil,
      this.typecontrat,
      this.pays,
      this.adrjob,
      this.urlImage,
      this.dateannonce,
      this.datecloture,
      this.urlFichier,
      this.validated,
      this.categorie,
      this.source,
      this.libcategorie);
  Job.fromJson(Map<dynamic, dynamic> parseJson)
      : idjobs = parseJson['idjobs'],
        titre = parseJson['titre'],
       description = parseJson['description'],
       profil = parseJson['profil'],
        typecontrat = parseJson['typecontrat'],
        pays = parseJson['pays'],
        adrjob = parseJson['adrjob'],
        urlImage = parseJson['urlImage'],
        dateannonce = DateTime.parse(parseJson['dateannonce']),
        datecloture = DateTime.parse(parseJson['datecloture']),
        urlFichier = parseJson['urlFichier'],
        validated = parseJson['validated'],
        categorie = parseJson['categorie'],
        libcategorie = parseJson['libcategorie'] ,
        source = parseJson['source'];
}