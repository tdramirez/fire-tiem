import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fire_team/src/data.dart';


class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  String tipoMapa = 'streets';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              if (tipoMapa == 'streets') {
                tipoMapa = 'dark';
              }else if (tipoMapa == 'dark') {
                tipoMapa = 'light';
              }else if (tipoMapa == 'light') {
                tipoMapa = 'outdoors';
              }else if (tipoMapa == 'outdoors') {
                tipoMapa = 'satellite';
              }else{
                tipoMapa = 'streets';
              }
              setState(() {});
            }
          ),
        ],
      ),
      body: _crearFlutterMap(context)
    );
  }

  Widget _crearFlutterMap(context) {
    return FlutterMap(
      options: MapOptions(
        center: cordenadas(),
        zoom: 10,
     ),
     layers: [
      _crearMapa(),
      _crearMarcadores(context),
      
     ],
    );
  }

  _crearMapa() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1Ijoia2xlcml0aCIsImEiOiJjanY2MjF4NGIwMG9nM3lvMnN3ZDM1dWE5In0.0SfmUpbW6UFj7ZnRdRyNAw',
        'id' : 'mapbox.$tipoMapa'
      }
    );
  }

  _crearMarcadores(context){
    return MarkerLayerOptions(
      markers: multiPuntero()
    );
  }

  LatLng cordenadas (){
    double lt;
    double ln;
    for (var lt_ln in items) {
      lt = double.parse(lt_ln[0]);
      ln = double.parse(lt_ln[1]);
      return LatLng(lt, ln);
    }
  }

  multiPuntero(){
    List<Marker> markers = [];
    double lt;
    double ln;
    for (var lt_ln in items) {
      lt = double.parse(lt_ln[0]);
      ln = double.parse(lt_ln[1]);
      markers.add(
        Marker(
          width: 100.0,
          height: 100.0,
          point: LatLng(lt, ln),
          builder: (context) =>Container(
            child: Image.asset(
              'assets/images/fire-icon.png',
              width: .5,
              height: .5,
            ),
          )
        )
      );
    }
    return markers;
  }
}