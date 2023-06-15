class Bachelor{

  late String firstname;
  late String lastname;
  late Gender gender;
  late String avatar;
  late List<Gender> searchFor;
  late String job;
  late String description;
  late bool isFavorite;
  late bool isDisliked;

  Bachelor(String firstN, String lastN, Gender gend, String avat, List<Gender> searchF, String jb, String desc)
  {
    firstname = firstN;
    lastname = lastN;
    gender = gend;
    avatar = avat; 
    searchFor = searchF;
    job = jb; 
    description = desc; 
    isFavorite = false;
    isDisliked = false;
  }

}

enum Gender {male, female, both}

