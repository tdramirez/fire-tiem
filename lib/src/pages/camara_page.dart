import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CamarPage extends StatefulWidget {
  @override
  _CamarPageState createState() => _CamarPageState();
}

class _CamarPageState extends State<CamarPage> {
  File foto;

  @override
  Widget build(BuildContext context) {
    return tomarFoto();

  }
  tomarFoto() async {
    foto = await ImagePicker.pickImage(
      source: ImageSource.camera 
    );
    File(foto.path);
    if (foto != null ){
      //limpiar
    }
    setState((){});
  }
}