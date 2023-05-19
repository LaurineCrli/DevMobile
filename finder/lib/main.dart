import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

