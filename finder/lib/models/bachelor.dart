class Bachelor{

  late String firstname;
  late String lastname;
  late Gender gender;
  late String avatar;
  late List<Gender> searchFor;
  late String job;
  late String description;

  Bachelor(String firstN, String lastN, Gender gend, String avat, List<Gender> searchF, String jb, String desc)
  {
    firstname = firstN;
    lastname = lastN;
    gender = gend;
    avatar = avat; 
    searchFor = searchF;
    job = jb; 
    description = desc; 
  }

}

enum Gender {male, female}

