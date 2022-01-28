import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Displayer extends StatefulWidget {
  const Displayer({Key? key}) : super(key: key);

  @override
  _DisplayerState createState() => _DisplayerState();
}

class _DisplayerState extends State<Displayer> {
  XFile? _image;
  var _output;
  var message;
  var electrical = ["batteries", "e-waste", "light blubs"];
  var organic = ["carrot", "potato", "rose", "tomato"];
  var recycle = [
    "clothes",
  ];
  Color c1 = Colors.blueAccent;
  Color c2 = Color(0xff5ebcd6);

  Future getimage(bool isCamera) async {
    XFile image;
    final imgpic = ImagePicker();
    if (isCamera) {
      image = (await imgpic.pickImage(source: ImageSource.camera))!;
    } else {
      image = (await imgpic.pickImage(source: ImageSource.gallery))!;
    }
    setState(() {
      _image = image;
    });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
    );
    print("predict = " + output.toString());
    setState(() {
      var x = output![0]['label'];
      if (electrical.contains(x)) {
        this._output = 'ELECTRICAL WASTE';
        c1 = Colors.redAccent;
        c2 = Colors.red;
      } else if (recycle.contains(x)) {
        this._output = "RECYCLABLE WASTE";
        c1 = Colors.orangeAccent;
        c2 = Colors.orange;
      } else if (organic.contains(x)) {
        this._output = "ORGANIC WASTE";
        c1 = Colors.greenAccent;
        c2 = Colors.green;
      }
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/tflite/rohit2.tflite",
        labels: "assets/tflite/rohit2.txt");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [c1, c2],
          )),
          child: Padding(
            padding: EdgeInsets.only(top: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    'CLEANIFY',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 30.0),
                  child: Text(
                    'Start your Treasure Sorting',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          onPressed: () {
                            getimage(false);
                          },
                          icon: Icon(Icons.insert_drive_file_outlined)),
                      IconButton(
                          onPressed: () {
                            getimage(true);
                          },
                          icon: Icon(Icons.camera_alt_outlined)),
                    ],
                  ),
                ),
                if (_image != null)
                  SizedBox(
                    child: Center(
                      child: Container(
                        height: 300,
                        child: Image.file(
                          File(_image!.path),
                          height: 300,
                          width: 250,
                        ),
                      ),
                    ),
                  ),
                if (_output != null)
                  Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "CLASSIFIED",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text(
                            ":",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 20)),
                          Text(
                            _output,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(400, 100)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 5),
                        if (_image != null)
                          Center(
                            child: Column(
                              children: <Widget>[
                                MaterialButton(
                                    height: 40,
                                    minWidth: 100,
                                    child: Text(
                                      "CLASSIFY",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    color: c1,
                                    splashColor: c2,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    onPressed: () {
                                      classifyImage(File(_image!.path));
                                    }),
                                Padding(padding: EdgeInsets.only(top: 5)),
                              ],
                            ),
                          ),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.only(left: 13)),
                            ]),
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
