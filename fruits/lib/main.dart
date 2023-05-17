import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruits',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Fruits'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<ListItem>fruits = <ListItem>[];
  late ListItem _currentListItem ;

  void _incrementCounter() {

    setState(() {
      _counter++;
      fruits.add(ListItem());
    });
    
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        
        title: Text(displayDynamicTitle(fruits, _counter)),
      ),
      body: 
      ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (BuildContext context, int index){
          _currentListItem = fruits[index];
          _currentListItem.CheckNumber(index + 1);
          return Container(
            height: 60, 
            color: _currentListItem._isEven ? Colors.cyan : Colors.indigo,
            child: Row(
              children: [
                
                Image.asset(_currentListItem._imageLink),
                Text(
                  "${index + 1}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white
                   ),
                )
              ]
            )
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter
        )
       
     
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

String displayDynamicTitle(List<ListItem> list, int counter){
 
  if(list.isEmpty){
    return "Click on the button to display fruits ! ";
  } else {
    ListItem currentItem = list[list.length - 1];
    currentItem.CheckNumber(list.length);
    return "$counter : ${currentItem._numberType} Number ";
  }
}

class ListItem{

  String _itemName = "" ; 
  late String _imageLink;
  late bool _isEven;
  late String _numberType;
  
  void CheckNumber(number)
  {
    if(number == 1){
      _itemName = "Apple";
      _imageLink = 'assets/img/pomme.png';
      _numberType = "Odd";
    }
    else if(isPrime(number)){
      _itemName = "Pineapple";
      _imageLink = 'assets/img/ananas.png';
      _numberType = "Prime";
    }
    else if(isEven(number)){
      _itemName = "Pear";
      _imageLink = 'assets/img/poire.png';
      _numberType = "Even";
    }
    else{
      _itemName = "Apple";
      _imageLink = 'assets/img/pomme.png';
      _numberType = "Odd";
    }
    _isEven = isEven(number);
  }


  bool isPrime(N) {
      for (var i = 2; i <= N / i; ++i) {
        if (N % i == 0) {
          return false;
        }
      }
      return true;
  }

  bool isEven(N){
    if (N%2 == 0){
      return true;
    } 
    else {
      return false;
    }
  }

}




