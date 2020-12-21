import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jansuvidha/sign_in.dart';
import 'package:tflite/tflite.dart';
import 'package:carousel_pro/carousel_pro.dart';
//import 'drawer.dart';

import 'package:jansuvidha/scratchcard.dart';

class Ml extends StatefulWidget {
  @override
  _Ml createState() => _Ml();
}

class _Ml extends State<Ml> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  int currentPage = 0;
  Widget imageCarousel = new Container(
    height: 240.0,
    child: new Carousel(
      boxFit: BoxFit.cover,
      images: [
        NetworkImage(
            'https://st3.depositphotos.com/1005979/18633/i/600/depositphotos_186339762-stock-photo-pothole-tire-wheel-damage-road.jpg'),
        NetworkImage(
            'https://image.shutterstock.com/image-vector/car-wheel-fell-into-pit-260nw-1491691268.jpg'),
        NetworkImage(
            'https://i.pinimg.com/originals/60/b3/7d/60b37daaedeaf89b6c886cc294ff1634.jpg'),
      ],
      showIndicator: false,
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(milliseconds: 1000),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          imageCarousel,
          SizedBox(height: 10),
          Container(
            decoration: new BoxDecoration(
              border: Border.all(color: Colors.black, width: 4),
              color: Colors.purple,
              gradient: new LinearGradient(
                colors: [Colors.blue, Colors.redAccent],
              ),
              boxShadow: [
                new BoxShadow(
                  color: Color(0xff514a9d),
                  offset: new Offset(20.0, 30.0),
                  blurRadius: 40.0,
                )
              ],
            ),
            height: 250,
            width: 350,
            child: new InkWell(
              onTap: pickImage,
              child: Card(
                elevation: 7.0,
                child: Container(
                  padding: EdgeInsets.only(
                      left: 12.0, top: 180.0, right: 2.0, bottom: 5.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/MLpot.jpg"),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  // child: Card1(),
                ),
              ),
            ),
          ),
          _loading
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _image == null ? Container() : Image.file(_image),
                      SizedBox(
                        height: 20,
                      ),
                      _outputs != null
                          ? "${_outputs[0]["label"]}" != "invalid image"
                              ? RaisedButton(
                                  onPressed: () {
                                    sendImg(
                                      _image,
                                      "",
                                      "",
                                      1,
                                      1,
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScratchCard()));
                                  },
                                  child: Text(
                                    "${_outputs[0]["label"]}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      background: Paint()..color = Colors.white,
                                    ),
                                  ))
                              : Text(
                                  "${_outputs[0]["label"]}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    background: Paint()..color = Colors.white,
                                  ),
                                )
                          : Container(),
                    ],
                  ),
                ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: pickImage,
//        child: Icon(Icons.image),
//      ),
        ],
      ),
    );
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
