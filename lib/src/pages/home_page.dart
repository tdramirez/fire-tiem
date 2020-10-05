import 'package:fire_team/src/pages/mapa_page.dart';
import 'package:flutter/material.dart';
import 'package:fire_team/src/pages/direcciones_page.dart';
import 'package:fire_team/src/pages/mapas_page.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _callPage(int paginaActual){
    switch (paginaActual){
      case 0 : return MapaPage();
      case 1 : return DireccionPage();
      
      default: return MapasPage();
    }
  }

  Widget _crearBottomNavigationBar(){
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[Colors.red,Colors.orange,Colors.yellow] ,
          begin: Alignment.bottomCenter,
          end: Alignment.bottomRight,
          
        )
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        currentIndex: currentIndex,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, color: Colors.white,),
            title: Text(
              'Incendio',
              style: TextStyle(
                color: Colors.white
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt, color: Colors.white,),
            title: Text(
              'Cámara',
              style: TextStyle(
                color: Colors.white
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.white,),
            title: Text(
              'Ajustes',
              style: TextStyle(
                color: Colors.white
              ),
            )
          ),
        ]
      ),
    );
  }
}