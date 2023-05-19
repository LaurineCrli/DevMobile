import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Casino'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  List<Item> itemList = [Item(), Item(), Item()];
  List<int> intList = [0, 0, 0];
  bool inGame = false;
  bool win = false;
  late String winText;

  void _incrementCounter() {

    setState(() {
      inGame = true;
      intList = randomizer();
      itemList = createItemList();
      
      for(int i = 0; i <= 4; i++){
        itemList[i].setImagPath(intList[i]);
      }
    });

    win = isWin(intList);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: win ? const Color.fromARGB(255, 236, 230, 176) : Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center (
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Row(
              children: [
                Flexible(child: Image.asset(itemList[0].imagePath)),
                Flexible(child: Image.asset(itemList[1].imagePath)),
                Flexible(child:Image.asset(itemList[2].imagePath)),
              ]
            ),
            Text(
              displayText(intList, inGame),
              style: const TextStyle(
                height: 5,
                fontSize: 30
              )
              ),
        ]
      )
      ),  

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Item{
  String imagePath = "";
  late int imageNumber;

  Item(){
    imageNumber = 0;
    setImagPath(imageNumber);
  }

  void setImagPath(int number){
    imageNumber = number;
    switch(imageNumber){
      case 0:
        imagePath = "assets/img/bar.png";
        break;
      case 1:
        imagePath = "assets/img/cerise.png";
        break;
      case 2:
        imagePath = "assets/img/cloche.png";
        break;
      case 3:
        imagePath = "assets/img/diamant.png";
        break;
      case 4:
        imagePath = "assets/img/fer.png";
        break;
      case 5:
        imagePath = "assets/img/pasteque.png";
        break;
      case 6:
        imagePath = "assets/img/sept.png";
        break;
    }
  }

}

List<int> randomizer(){
  List<int> list = <int>[];

  for(int i = 0; i <= 4; i++){
    int randomValue = Random().nextInt(7);
    list.add(randomValue);
  }
  return list;
}

List<Item> createItemList(){
  List<Item> list = <Item>[];

  for(int i = 0; i <= 4; i++){
    list.add(Item());
  }
  return list;
}

String displayText(List<int> intList, bool inGame){
  if(!inGame){

    return "Press button to start";
    
  } 
  else 
  {
    return  isWin(intList) ? "Jackpot" : "You loose, try again !";
  }
  

}

bool isWin(List<int> intList){

  return (intList[0] == intList[1] && intList[1] == intList[2]);
}






