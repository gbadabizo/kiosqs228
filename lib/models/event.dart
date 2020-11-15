class Event {
  final String imagePath, title, description, location, duration, videoUrl, punchLine2;
  final List categoryIds, galleryImages;

  Event(
      {this.imagePath,
      this.title,
      this.description,
      this.location,
      this.duration,
      this.videoUrl,
      this.punchLine2,
      this.categoryIds,
      this.galleryImages});
}

final fiveKmRunEvent = Event(
    imagePath: "https://www.icilome.com/logonewsx/userfiles/2020/10/886690.jpg",
    title: "Togo - Gouvernement Dogbé : Qui sont ces femmes ministres ?",
    description: "Elles sont au total dix (10) femmes à faire partie du nouveau gouvernement. On retrouve un gouvernement élargi avec la création de nouveaux ministères, tandis que d'autres départements ministériels on...",
    location: "Pleasant Park",
    duration: "3h",
    videoUrl: "",
    punchLine2: "The latest fad in foodology, get the inside scoup.",
    galleryImages: [],
    categoryIds: [0, 1]);

final cookingEvent = Event(
    imagePath: "https://scontent.flfw2-1.fna.fbcdn.net/v/t1.0-9/120706413_759998954560930_5458390149716210329_o.jpg?_nc_cat=100&_nc_sid=730e14&_nc_ohc=71LoHeLduBAAX9tZAAg&_nc_ht=scontent.flfw2-1.fna&oh=19db549daeb7aa3677b52d3c97db14d8&oe=5FA00DA9",
    title: "TamTam Digital School en partenariat avec Google présente le #Hackathon #Competition.",
    description: "L'objectif est de créer une "
        "application mobile de géolocalisation,"
        " un site web ou une solution logicielle"
        " utilisant Google Plus Codes et API qui améliorera la vie quotidienne des Togolais."
   " Les personnes qui peuvent s'inscrire sont"
"-Étudiants"
"-Développeurs informatiques"
"-Les start-up"
"-Les personnes intéressées par le codage"
    "N'hésitez plus, inscrivez-vous sur le lien suivant : http://67.205.151.208/events/",
    location: "Food Court Avenue",
    duration: "4h",
    videoUrl: "",
    punchLine2: "The latest fad in foodology, get the inside scoup.",
    categoryIds: [0, 2],
    galleryImages: ["assets/event_images/cooking_1.jpeg", "assets/event_images/cooking_2.jpeg", "assets/event_images/cooking_3.jpeg"]);

final musicConcert = Event(
    imagePath: "assets/images/p3.jpg",
    title: "Arijit Music Concert",
    description: "Listen to Arijit's latest compositions. Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant remplacer le faux-texte dès qu'il est prêt ou que la mise en page est achevée. Généralement, on utilise un texte en faux latin, le Lorem ipsum ou Lipsum",
    location: "D.Y. Patil Stadium, Mumbai",
    duration: "5h",
    videoUrl: "",
    punchLine2: "The latest fad in foodology, get the inside scoup.",
    galleryImages: ["assets/event_images/cooking_1.jpeg", "assets/event_images/cooking_2.jpeg", "assets/event_images/cooking_3.jpeg"],
    categoryIds: [0, 1]);

final golfCompetition = Event(
    imagePath: "assets/images/p4.jpg",
    title: "Season 2 Golf Estate",
    description: "Le lorem ipsum est, en imprimerie, une suite de mots sans signification utilisée à titre provisoire pour calibrer une mise en page, le texte définitif venant remplacer le faux-texte dès qu'il est prêt ou que la mise en page est achevée. Généralement, on utilise un texte en faux latin, le Lorem ipsum ou Lipsum",
    location: "NSIC Ground, Okhla",
    duration: "1d",
    videoUrl: "",
    punchLine2: "The latest fad in foodology, get the inside scoup.",
    galleryImages: ["assets/event_images/cooking_1.jpeg", "assets/event_images/cooking_2.jpeg", "assets/event_images/cooking_3.jpeg"],
    categoryIds: [0, 3]);

final events = [
  fiveKmRunEvent,
  cookingEvent,
  musicConcert,
  golfCompetition,
];
