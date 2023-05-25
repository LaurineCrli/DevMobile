import 'dart:math';

import 'package:faker/faker.dart';
import 'package:finder/models/bachelor.dart';

main(){

// BachelorManager bm = BachelorManager();
// List<Bachelor> bachelorList = bm.BachelorsBuilder();

//   for(int i = 0; i < 30; i++){
//     print(bachelorList[i].avatar);
//   }

}

class BachelorManager{

  var faker = Faker();
  bool isFemale = false;
  List<Bachelor> bachelorList = <Bachelor>[];
  late Gender currentGender;
  List<Gender> searchFor = [Gender.female, Gender.male];
  List<String> maleNames = 
  [
    "Ilyan", 
    "Georges", 
    "Nolhan", 
    "Gérard",
    "Pierre", 
    "Baptiste",
    "Gilbert", 
    "Pedro", 
    "Hervé", 
    "Maxence", 
    "Florian", 
    "Jordan", 
    "Ludo", 
    "Luigi", 
    "Galaad"
  ];
  List<String> femaleNames = 
  [
    "Josette", 
    "Arlette", 
    "Cyprine",
    "Yolaine", 
    "Carole", 
    "Simone", 
    "Bernadette", 
    "Marcelle", 
    "Eléonore", 
    "Hortense", 
    "Simone",
    "Angèle", 
    "Josette", 
    "Daniella",
    "Francine"
  ];
  
   
  void bachelorsBuilder(){

    for(int i = 0; i < 30; i++)
    {
      int randomValue = Random().nextInt(15);
      isFemale = isFemale ? false : true; 
      String firstName = isFemale ? femaleNames[randomValue] : maleNames[randomValue];
      currentGender = isFemale ? Gender.female : Gender.male;
      String imagePath = "assets/img/";
      imagePath += isFemale ? "woman" : "man";
      imagePath += "-";
      if(i + 1 > 15){
        imagePath += (i + 1 - 15).toString();
      } 
      else {
        imagePath += ( i + 1 ).toString();
      }
      imagePath += ".png";

      Bachelor current = Bachelor(firstName, faker.person.lastName(), currentGender, imagePath, searchFor, faker.job.title(), faker.lorem.sentences(4).toString());
      bachelorList.add(current);
    }
  }
  
}