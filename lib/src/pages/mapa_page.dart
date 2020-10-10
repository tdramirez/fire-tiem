import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fire_team/src/data.dart';
import 'package:location/location.dart';


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
        backgroundColor: Color.fromARGB(225, 0, 0, 0),
        title: Text('Mapa'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.repeat_sharp),
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
      body: Stack(
        children: [
           _crearFlutterMap(context),
           _botonMyUbicacion(context)
        ],
      )
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

  

  LatLng cordenadas(){
    double lt;
    double ln;
    

    for (var lt_ln in items) {
      lt = double.parse(lt_ln[0]);
      ln = double.parse(lt_ln[1]);
    }
    return LatLng( lt ,ln);

    
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
          width: 50.0,
          height: 50.0,
          point: LatLng(lt, ln),
          builder: (context) =>Container(
            child: Image.asset('assets/images/llama.png'),
          )
        )
      );
    }
    return markers;
  }

  Widget _botonMyUbicacion(context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 10.0),
      child: Align(
       alignment: Alignment.bottomRight,
       child: FloatingActionButton(
         child: Icon(Icons.my_location),
         backgroundColor: Colors.deepOrangeAccent,
         onPressed: (){
         } 
       ),
     ),
    );
  }

  myUbicacion()async{
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }



    _locationData = await location.getLocation();
    List<double> ltln = [_locationData.latitude, _locationData.longitude];
    print(ltln);
  }
}