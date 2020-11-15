
import 'package:kiosqs228/models/categorie.dart';

List<Categorie> getCategories(){
  List<Categorie> categories = new List<Categorie>();
  Categorie categorie = new Categorie();
  categorie.idcategorie=7;
  categorie.name= "Politique";
  categorie.imageUrl="https://images.unsplash.com/photo-1507679799987-c73779587ccf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80";
  categories.add(categorie);


  //3
  categorie = new Categorie();
  categorie.idcategorie=1;
  categorie.name = "General";
  categorie.imageUrl = "https://images.unsplash.com/photo-1523995462485-3d171b5c8fa9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80";

  categories.add(categorie);

  //4
  categorie = new Categorie();
  categorie.idcategorie=4;
  categorie.name = "Santé";
  categorie.imageUrl ="https://images.unsplash.com/photo-1536064479547-7ee40b74b807?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80";
  categories.add(categorie);

  //5
  categorie = new Categorie();
  categorie.idcategorie=2;
  categorie.name = "Sports";
  categorie.imageUrl = "https://images.unsplash.com/photo-1473075109809-7a17d327bdf6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80";

  categories.add(categorie);

  //2
  categorie = new Categorie();
  categorie.idcategorie=5;
  categorie.name = "Féminin";
  categorie.imageUrl ="https://images.unsplash.com/photo-1573497491765-dccce02b29df?ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";

  categories.add(categorie);
  //5
  categorie = new Categorie();
  categorie.idcategorie=3;
  categorie.name = "Technologies";
  categorie.imageUrl ="https://images.unsplash.com/photo-1498050108023-c5249f4df085?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1352&q=80";

  categories.add(categorie);
  //5
  categorie = new Categorie();
  categorie.idcategorie=8;
  categorie.name = "Humour";
  categorie.imageUrl ="https://images.unsplash.com/photo-1545559301-f96a342cd104?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2134&q=80";

  categorie = new Categorie();
  categorie.idcategorie=9;
  categorie.name = "Show-Biz";
  categorie.imageUrl ="https://images.unsplash.com/photo-1593698054590-a5b3a19565a3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=3334&q=80";
  categories.add(categorie);
  return categories ;

}