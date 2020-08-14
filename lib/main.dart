import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tesseract_ocr/tesseract_ocr.dart';

void main() => runApp(MyApp());


class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}
  
 
class _MyAppState extends State<MyApp> {
  
  // ignore: override_on_non_overriding_member
  final picker = new ImagePicker();

  File _image;
  String _extractText = 'Unknown';
  
  Future pickimage() async {
    final  pickedFile = await picker.getImage(source: ImageSource.gallery);
  

    _image = File(pickedFile.path);
    final String _extrtxt = await TesseractOcr.extractText(pickedFile.path,language:"eng");

    // _extractText =
    //     await TesseractOcr.extractText(pickedFile.path, language: "eng");
        setState(() {
           _extractText = _extrtxt;
        });

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
              Text("Add Photo",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              // Center(
              //   child: _image == null
              //       ? Text('No image selected.')
              //       : Image.file(_image),
              // ),
              
              Center(child: Text(_extractText))
            ],
          ),
        ),
      ),
    );
  }

 
}
