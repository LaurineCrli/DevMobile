

import 'package:finder/models/bachelor.dart';
import 'package:flutter/material.dart';
import 'models/bachelor_manager.dart';
import 'models/custom_search_delegate.dart';

void main() {
  runApp(const FinderApp());
}

class FinderApp extends StatelessWidget {
  const FinderApp({super.key});
 
  @override
  Widget build(BuildContext context){
    return MaterialApp(
    title: 'FinderApp',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.pink,
      ),
      home: const FinderHomePage(title: 'FinderApp', isFavorite: false),
      
    );
  }
}

class FinderHomePage extends StatefulWidget {

  const FinderHomePage({super.key, required this.title, required this.isFavorite});
  

  final String title;
  final bool isFavorite;
  

  @override
  State<FinderHomePage> createState() => _FinderHomePageState();

}

class _FinderHomePageState extends State<FinderHomePage>{

  BachelorManager bm = BachelorManager();
  late Bachelor currentBachelor;
  late bool isFavorite;
  late bool isDisliked = false;
  late List<Bachelor> bachelorList;
  late List<String> firstNamesToSearch;
  

  void onTap(bool isFavorite, Bachelor bachelor){
    setState(() {
      bachelor.isFavorite = isFavorite;
      bachelor.isDisliked = isDisliked;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = false;

  bm.bachelorsBuilder();
  bachelorList = sortBachelors(bm.bachelorList, bm);
  firstNamesToSearch = createFirstnamesList(bachelorList);
  

  return Scaffold(
    appBar: AppBar(
    title: Text(widget.title),
    
    actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate(firstNamesToSearch)
              );
            },
            icon: const Icon(Icons.search),
          )
        ]
    ),
    body: ListView.builder(
      itemCount: bachelorList.length,
      itemBuilder: (BuildContext context, int index){
        currentBachelor = bachelorList[index];
        return Container(
          height: 60, 
          color: bachelorList[index].isFavorite ? Colors.purple[100] : Colors.pink[100],
          child: Row(
            children: [
            GestureDetector(
            onTap: () => clickBachelor(bachelorList[index]),
            child: Row(
              children: [
                Image.asset(currentBachelor.avatar),
                Text(
                  "${currentBachelor.firstname} ${currentBachelor.lastname}",
                    style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white
                    ),
                  )
                ]
              ),
            ),
            IconButton(
                  icon: const Icon(Icons.person),
                  color: Colors.white,
                  onPressed: () =>clickBachelor(bachelorList[index]),
            ),
            IconButton(
                  icon: const Icon(Icons.favorite),
                  color: bachelorList[index].isFavorite ? Colors.pink : Colors.white,
                  onPressed: () => _addFavorites(bachelorList[index]),
                ),
            IconButton(
                  icon: const Icon(Icons.block),
                  color: Colors.black,
                  onPressed: () => _unlikeBachelor(bachelorList[index]),
            )
          ]
          )
          
          );
        }
      ),
      floatingActionButton: 
        Container(
          height: 50,
          width: 165,
          color: Colors.pink,
          child: 
            Row(
            children: [
              IconButton(
                    icon: const Icon(Icons.female),
                    color: Colors.white,
                    onPressed: () =>setSortBachelorsByGender(Gender.female, bm),
              ),
              IconButton(
                    icon: const Icon(Icons.male),
                    color: Colors.white,
                    onPressed: () =>setSortBachelorsByGender(Gender.male, bm),
              ),
              IconButton(
                    icon: const Icon(Icons.restore),
                    color: Colors.white,
                    onPressed: () =>setSortBachelorsByGender(Gender.both, bm),
              ),
              IconButton(
                    icon: const Icon(Icons.reply_all_sharp),
                    color: Colors.white,
                    onPressed: () => restoreAll(),
              ),

            ])
          
        )
        );
    
  }

  Bachelor clickBachelor(Bachelor bachelor){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => FinderDetailsPage(bachelor: bachelor, onTap: onTap))
    );
    return bachelor;
    
  }

  List<Bachelor> sortBachelors(List<Bachelor> bachelorsToSort, BachelorManager bm){
    List<Bachelor> listSorted = <Bachelor>[];
    
    for(int i = 0; i < bachelorsToSort.length; i++)
    {
      if(!bachelorsToSort[i].isDisliked){
        listSorted.add(bachelorsToSort[i]);
      }
    }
    if(bm.wannaSee != Gender.both){
      listSorted = sortBachelorsByGender(listSorted, bm);
    }
    return listSorted;
    
  }

  List<Bachelor> sortBachelorsByGender(List<Bachelor> bachelorsToSort, BachelorManager bm){
    List<Bachelor> listSorted = <Bachelor>[];
    
    for(int i = 0; i < bachelorsToSort.length; i++)
    {
        if(bm.wannaSee == bachelorsToSort[i].gender){
          listSorted.add(bachelorsToSort[i]);
        }
      }
    

    return listSorted;
  }

  void setSortBachelorsByGender(Gender gender, BachelorManager bm){
     setState(() {
      bm.wannaSee = gender;
     });
  }

  void restoreAll(){
    setState(() {
        bm.wannaSee = Gender.both;
        for(int i = 0; i < bm.bachelorList.length; i++)
        {
          if(bm.bachelorList[i].isDisliked){
            bm.bachelorList[i].isDisliked = false;
          }
        }
        bachelorList = bm.bachelorList;
        
      });
  }


  void _unlikeBachelor(Bachelor bachelor){
    setState(() {
    bachelor.isDisliked = !bachelor.isDisliked;
      
      if (bachelor.isDisliked) {
        const SnackBar snackBar = SnackBar(
          content: Text('Personne supprimée de votre liste'),
          backgroundColor: Colors.black,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      
    });
  }

   void _addFavorites(Bachelor bachelor){
    setState(() {

      bachelor.isFavorite = !bachelor.isFavorite;
      
      if (bachelor.isFavorite) {
        const SnackBar snackBar = SnackBar(
          content: Text('Personne ajoutée a vos favoris'),
          backgroundColor: Colors.pink,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const SnackBar snackBar = SnackBar(
          content: Text('Personne enlevée de vos favoris'),
          backgroundColor: Colors.pink,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      
    });
  }

  List<String> createFirstnamesList(List<Bachelor> bachelors){
    List<String> toReturn = <String>[];
    for(int i = 0; i < bm.bachelorList.length; i++){
      toReturn.add(bachelorList[i].firstname);
    }
    return toReturn;
  }

}
  

class FinderDetailsPage extends StatefulWidget{
  
  final Bachelor bachelor;
  final Function onTap;
  const FinderDetailsPage({Key? key, required this.bachelor, required this.onTap}) : super(key: key);

  @override
  State<FinderDetailsPage> createState() => _FinderDetailsPageState();

}

class _FinderDetailsPageState extends State<FinderDetailsPage>{
  late Bachelor bachelor;
  late Function onTap;

  @override
  Widget build(BuildContext context) {
   bachelor = widget.bachelor;
   onTap = widget.onTap;
   return Scaffold(
      appBar: AppBar(
        title: Text("${bachelor.firstname} ${bachelor.lastname}")
      ),
      body:
      Center(
        child: Column(
        children:[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset(
                bachelor.avatar,
                fit: BoxFit.contain,
                height: 150,
                alignment: Alignment.center,
              ),
              IconButton(
                  icon: const Icon(Icons.favorite),
                  color: bachelor.isFavorite ? Colors.pink : Colors.white,
                  onPressed: () => _changeFavColor(),
                )
              ]
            ),
          Text("${bachelor.firstname} ${bachelor.lastname}"),
          Text("Gender : ${printGender(bachelor.gender)}"),
          Text("Searching : ${printSearchFor(bachelor)}"),
          Text("Job : ${bachelor.job}"),
          Text("Description : ${bachelor.description.toString().replaceAll('[', ' ').replaceAll(']', ' ')}"),
          ]
        ),
      )
    );
  }

   String printSearchFor(Bachelor bachelor){
    String toReturn = "";
    int count = 0;
    for(int i = 0; i < bachelor.searchFor.length; i++){
      toReturn += printGender(bachelor.searchFor[i]);
      if(count != bachelor.searchFor.length - 1){
        toReturn += " | ";
      }
      
      count++;
    }

    return toReturn;
  }

  String printGender(Gender gender){
    if(gender == Gender.male){
      return "Male";}
    else {
      return  "Female";
    }
  }

  void _changeFavColor(){
    setState(() {

      
      bachelor.isFavorite = !bachelor.isFavorite;
      
      if (bachelor.isFavorite) {
        const SnackBar snackBar = SnackBar(
          content: Text('Personne ajoutée a vos favoris'),
          backgroundColor: Colors.pink,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        const SnackBar snackBar = SnackBar(
          content: Text('Personne enlevée de vos favoris'),
          backgroundColor: Colors.pink,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      onTap(bachelor.isFavorite, bachelor);
    });
  }

}











