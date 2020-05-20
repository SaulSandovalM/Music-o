import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'cards_section_draggable.dart';
import 'package:music_finder/models/state.dart';
import 'package:music_finder/util/state_widget.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  StateModel appState;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appState = StateWidget.of(context).state;
    final firstName = appState?.user?.firstName ?? '';

    final head = Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            width: MediaQuery.of(context).size.width * 0.4,
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: "NOMBRE \n",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0, letterSpacing: 1.5),
                  children: [
                    TextSpan(
                      text: firstName + "\n",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24.0,
                        height: 1.5,
                      ),
                    ),
                    WidgetSpan(
                      child: Icon(Icons.star, size: 16, color: Colors.white),
                    ),
                    TextSpan(
                      text: ' 23',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        height: 3
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 200,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  image: AssetImage('assets/perfil.jpg')
                )
              ),
            ),
          ),
        ],
      ),
    );


    final info = Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, top: 10.0),
        child: Text(
          'DESCRIPCION',
          style: TextStyle(color: Colors.grey, fontSize: 12.0, letterSpacing: 1.5),
        ),
      )
    );

    final infoBio = Container(
      child: Padding(
        padding: EdgeInsets.only(left: 20.0, top: 10),
        child: Text(
          'Hello World! Soy Saúl, fan de las películas y los videojuegos, idealista, hacker, y este es mi hogar.',
          style: TextStyle(color: Colors.white, fontSize: 16.0, letterSpacing: 1.5, fontWeight: FontWeight.bold),
        ),
      )
    );

    final infoData = Container(
      padding: EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: "ESTADO \n",
              style: TextStyle(color: Colors.grey, fontSize: 12.0, letterSpacing: 1.5, height: 3),
              children: [
                TextSpan(
                  text: 'Hidalgo',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.7
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: "INSTRUMENTOS \n",
              style: TextStyle(color: Colors.grey, fontSize: 12.0, letterSpacing: 1.5, height: 3),
              children: [
                TextSpan(
                  text: 'Guitarra, Bateria, Piano',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.7
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: "GENEROS MUSICALES \n",
              style: TextStyle(color: Colors.grey, fontSize: 12.0, letterSpacing: 1.5, height: 3),
              children: [
                TextSpan(
                  text: 'Rock, Cumbia, Clasica',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.7
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: "AÑOS DE EXPERIENCIA \n",
              style: TextStyle(color: Colors.grey, fontSize: 12.0, letterSpacing: 1.5, height: 3),
              children: [
                TextSpan(
                  text: '5',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.7
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: "INSTRUMENTO PROPIO \n",
              style: TextStyle(color: Colors.grey, fontSize: 12.0, letterSpacing: 1.5, height: 3),
              children: [
                TextSpan(
                  text: 'Si',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0,
                      height: 1.7
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(
          children: <Widget>[
            head,
            info,
            infoBio,
            infoData,
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
        },
        child: Icon(Icons.edit, color: Colors.black),
      ));
  }
}

