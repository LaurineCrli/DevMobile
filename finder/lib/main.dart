import 'package:finder/models/bachelor.dart';
import 'package:flutter/material.dart';
import 'models/bachelor_manager.dart';

void main() {
  runApp(const FinderApp());
}

class FinderApp extends StatelessWidget {
  const FinderApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
    title: 'FinderApp',
    theme: ThemeData(
      primarySwatch: Colors.pink,
      ),
      home: const FinderHomePage(title: 'FinderApp'),
    );
  }
}

class FinderHomePage extends StatefulWidget {

  const FinderHomePage({super.key, required this.title});

  final String title;

  

  @override
  State<FinderHomePage> createState() => _FinderHomePageState();

}

class _FinderHomePageState extends State<FinderHomePage>{

  BachelorManager bm = BachelorManager();
  late Bachelor currentBachelor;


  @override
  Widget build(BuildContext context) {

  bm.bachelorsBuilder();
  List<Bachelor> bachelorList = bm.bachelorList;

  return Scaffold(
    appBar: AppBar(
    title: Text(widget.title),
    ),
    body: ListView.builder(
      itemCount: bachelorList.length,
      itemBuilder: (BuildContext context, int index){
        currentBachelor = bachelorList[index];
        return Container(
          height: 60, 
          color: Colors.pink[100],
          child: 
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
            )
          );
        }
      ),
    );
  }

  Bachelor clickBachelor(Bachelor bachelor){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => FinderDetailsPage(bachelor: bachelor))
    );
    return bachelor;
    
  }
  
}

class FinderDetailsPage extends StatefulWidget{
  
  final Bachelor bachelor;
  const FinderDetailsPage({Key? key, required this.bachelor}) : super(key: key);

  @override
  State<FinderDetailsPage> createState() => _FinderDetailsPageState();

}

class _FinderDetailsPageState extends State<FinderDetailsPage>{
  late Bachelor bachelor;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
   bachelor = widget.bachelor;
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
                  color: _isFavorite ? Colors.pink : Colors.white,
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

      _isFavorite = !_isFavorite;
      if (_isFavorite) {
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

}











