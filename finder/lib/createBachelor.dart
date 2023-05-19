
import 'package:faker/faker.dart';
import 'package:finder/models/bachelor.dart';

main(){

  var faker = Faker();
  bool isFemale = false;
  List<Bachelor> bachelorList = <Bachelor>[];
  Gender currentGender;
  List<Gender> searchFor = [Gender.female, Gender.male];
  

  for(int i = 0; i < 30; i++)
  {
    isFemale = isFemale ? false : true; 
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

    Bachelor current = Bachelor(faker.person.firstName(), faker.person.lastName(), currentGender, imagePath, searchFor, faker.job.title(), faker.lorem.sentences(4).toString());
    bachelorList.add(current);
  }

  // for(int i = 0; i < 30; i++){
  //   print(bachelorList[i].avatar);
  // }

  
}