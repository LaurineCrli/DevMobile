import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MuseumApp());
}

class MuseumApp extends StatelessWidget{
  const MuseumApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp
    (
      title : 'Museum',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const Artwork(),
    );
  }
}

class Artwork extends StatefulWidget{

  const Artwork({super.key});


  @override
  State<Artwork> createState() {
    return _ArtworkState();
  }
}

class _ArtworkState extends State<Artwork>{
  bool _isFavorite = false;
  bool _showDescription = true;
  @override
  Widget build(BuildContext context) {
      const descriptionText = "La Joconde, ou Portrait de Mona Lisa, est un tableau de l'artiste Léonard de Vinci,"
          "réalisé entre 1503 et 1506 ou entre 1513 et 15161,2, et peut-être jusqu'à 1517 (l'artiste étant mort "
          "le 2 mai 1519), qui représente un portrait mi-corps, probablement celui de la Florentine Lisa"
          "Gherardini, épouse de Francesco del Giocondo. Acquise par François Ier, cette peinture à"
          "l'huile sur panneau de bois de peuplier de 77 × 53 cm est exposée au musée du Louvre à"
          "Paris. La Joconde est l'un des rares tableaux attribués de façon certaine à Léonard de Vinci."
          "La Joconde est devenue un tableau éminemment célèbre car, depuis sa réalisation, nombre"
          "d'artistes l'ont pris comme référence. À l'époque romantique, les artistes ont été fascinés par"
          "ce tableau et ont contribué à développer le mythe qui l'entoure, en faisant de ce tableau"
          "l’une des œuvres d'art les plus célèbres du monde, si ce n'est la plus célèbre : elle est en tout"
          "cas considérée comme l'une des représentations d'un visage féminin les plus célèbres au"
          "monde. Au xxie siècle, elle est devenue l'objet d'art le plus visité au monde, devant le"
          "diamant Hope, avec 20 000 visiteurs qui viennent l'admirer et la photographier"
          "quotidiennement.";

      Widget descriptionWidget = Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(153, 255, 255, 255),
          borderRadius: BorderRadius.circular(5),
        ),
        height: 300,
        width: 300,
        child: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  descriptionText,
                ),
              ),
            ),
          ),
        ),
      );

      return Scaffold(
        appBar: AppBar(
          title: const Text('Museum'),
        ),

        body: Center(

          child: Column(
            // Column is also a layout widget.
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/img/Mona_Lisa.jpg',
                      fit: BoxFit.contain,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.65,
                      alignment: Alignment.center,
                    ),
                    IconButton(
                      icon: const Icon(
                          Icons.favorite,
                          size: 50),
                      color: _isFavorite ? Colors.pink : Colors.white,
                      alignment: Alignment.center,
                      onPressed: () => _changeFavColor(),
                    ),
                    Container(
                      width: 300,
                      height: 350,
                      color: _showDescription ? Colors.transparent : Colors.black45,
                      child : Text(
                        descriptionText,
                        style: TextStyle(
                          color: _showDescription ? Colors.transparent : Colors.white,
                            fontFamily: 'Merriweather',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                        ),
                      )
                    )
                  ]
              ),

              const Text(
                'Mona Lisa',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 30,
                    color: Colors.brown
                ),
              ),
              const Text(
                'Léonard de Vinci',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Merriweather',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.article),
                    color: Colors.brown,
                    onPressed: () => _displayDescription(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    color: _isFavorite ? Colors.pink : Colors.brown,
                    onPressed: () => _changeFavColor(),
                  )
                ],
              )
            ],
          ),
        ),

      );
    }
  void _changeFavColor() {
    setState(() {
      _isFavorite ? _isFavorite = false : _isFavorite = true;
      if (_isFavorite) {
        const SnackBar snackBar = SnackBar(
          content: Text('Oeuvre ajoutée a vos favoris'),
          backgroundColor: Colors.pink,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
  void _displayDescription() {
    setState(() {
      _showDescription ? _showDescription = false : _showDescription = true;
    });
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}