import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final picker = new ImagePicker();

  File _image;
  String _extractText = 'Unknown';
  Future pickimage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    _image = File(pickedFile.path);

    _extractText =
        await TesseractOcr.extractText(pickedFile.path, language: "eng");

    log(_image.path);
    log(_extractText);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
            title: Text('1Press SRM GPA Calculator'),
            backgroundColor: Colors.amber),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Material(
                  color: Colors.amber, // button color
                  child: InkWell(
                    splashColor: Colors.black, // inkwell color
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Icon(Icons.photo_camera, size: 60),
                    ),

                    onTap: () {
                      pickimage();
                    },
                  ),
                ),
              ),
              Text(_image?.path == null ? "Add Photo" : _image?.path,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              Center(
                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
