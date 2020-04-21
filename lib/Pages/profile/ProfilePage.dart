import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:palet/Pages/profile/profile.dart';
import 'package:palet/components/loading.dart';
import 'package:palet/components/mode.dart';
import 'package:palet/models/user.dart';
import 'package:palet/services/auth.dart';
import 'package:palet/services/database.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final AuthService _auth = AuthService();

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String emailID;
  String phone;
  String address;
  String password;
  int day;
  int month;
  int year;
  int d;
  int m;
  int y;
  DateTime newDt = DateTime.now();
  Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());
  Timestamp dob;
  Timestamp newdob;

  static DateTime birthDate = DateTime.now();
  bool isDateSelected;

  String birthDateInString =
      "${birthDate.month}/${birthDate.day}/${birthDate.year}";

//  File sampleimage;
//
//  Future getImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.camera);
//
//    setState(() {
//      sampleimage = image;
//    });
//  }

  bool _status = true;
  bool _newdt = false;
  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _onpressed;
    getStatus() {
      if (!_status) {
        _onpressed = () async {
          newDt =
              await showRoundedDatePicker(
            context: context,
            initialDate: DateTime(
                DateTime.now().year - 18),
            firstDate: DateTime(
                DateTime.now().year - 50),
            lastDate: DateTime(
                DateTime.now().year - 10),
            borderRadius: 16,
          );
          print('$newDt is newdt');
          setState(() {
            _newdt = true;
            day = newDt.day;
            print('$day is new day');

            month = newDt.month;
            year = newDt.year;
            newdob = Timestamp.fromDate(newDt);
            print(newdob.toDate());
          });
        };
      }
      return _onpressed;
    }

//    final profiles = Provider.of<List<Profile>>(context);
    final user = Provider.of<UserID>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;

          dob = userData.dob;
          newDt = dob.toDate();
          m = newDt.month;
          d = newDt.day;
          y = newDt.year;

          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal[600],
                  title: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'PROFILE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'sans-serif-light',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                body: new Container(
                  color: Colors.teal[600],
                  child: Form(
                    key: _formKey,
                    child: new ListView(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            new Container(
                              height: 250.0,
                              color: Colors.white,
                              child: new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 1.0),
                                    child: new Stack(
                                        fit: StackFit.loose,
                                        children: <Widget>[
                                          new Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              new Container(
                                                  width: 140.0,
                                                  height: 140.0,
                                                  decoration: new BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: new DecorationImage(
                                                      image: new ExactAssetImage(
                                                          'assets/images/as.png'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),

//                                        Container(
//                                          child: FlatButton(
//                                            onPressed: getImage,
//                                          ),
//
//                                        ),
//                                        Container(
//                                          child: sampleimage == null ? Text('select image') : enableUpload(),
//
//                                        ),
                                            ],
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 90.0, right: 0.0),
                                              child: new Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Center(
                                                    child: new Icon(
                                                        Icons.account_circle,
                                                        color: Colors.teal,
                                                        size: 100.0),
                                                  ),
                                                ],
                                              )),
                                        ]),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              color: Color(0xffFFFFFF),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 25.0),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Personal Information',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                _status
                                                    ? _getEditIcon()
                                                    : new Container(),
                                              ],
                                            )
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Name',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue:
                                                    userData.name ?? null,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Enter Your Name",
                                                ),
                                                onChanged: (val) {
                                                  setState(() => name = val);
                                                },
                                                enabled: !_status,
                                                autofocus: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Email ID',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue:
                                                    userData.emailID ?? emailID,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Enter Email ID"),
                                                onChanged: (val) {
                                                  setState(() => emailID = val);
                                                },
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 220.0,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: !_newdt
                                                      ? 'DOB: $d/$m/$y'
                                                      : 'DOB: $day/$month/$year'),
                                              enabled: false,
                                            ),
                                          ),
                                          FlatButton(
                                            onPressed: getStatus(),
                                            child: Icon(
                                              Icons.date_range,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Mobile',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                validator: (val) => val.length <
                                                        10
                                                    ? 'Enter a valid mobile number'
                                                    : null,
                                                initialValue:
                                                    userData.phone ?? null,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "Enter Mobile Number"),
                                                onChanged: (val) {
                                                  setState(() => phone = val);
                                                },
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Address',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                validator: (val) => val.isEmpty
                                                    ? 'Enter an address'
                                                    : null,
                                                initialValue:
                                                    userData.address ?? null,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Enter Address"),
                                                onChanged: (val) {
                                                  setState(() => address = val);
                                                },
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                new Text(
                                                  'Current Password',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: new Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: <Widget>[
                                            new Flexible(
                                              child: new TextFormField(
                                                initialValue: password,
                                                obscureText: true,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: "password"),
                                                onChanged: (val) {
                                                  setState(
                                                      () => password = val);
                                                },
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        )),
                                    !_status
                                        ? _getActionButtons()
                                        : new Container(),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    final user = Provider.of<UserID>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Container(
                          child: new RaisedButton(
                        child: new Text("Save"),
                        textColor: Colors.white,
                        color: Colors.teal[600],
                        onPressed: () async {
                          FirebaseUser user =
                              await FirebaseAuth.instance.currentUser();
                          if (_formKey.currentState.validate()) {
                            if (password != null) {
                              //Pass in the password to updatePassword.
                              user.updatePassword(password).then((_) {
                                print("Succesfull changed password");
                              }).catchError((error) {
                                print("Password can't be changed" +
                                    error.toString());
                                //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                              });
                              user.updateEmail(emailID).then((_) {
                                print("Succesfull changed email");
                              }).catchError((error) {
                                print("Email can't be changed" +
                                    error.toString());
                                //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
                              });
                            }

                            setState(() {
                              _status = true;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                            print(dob.toDate());

                            await DatabaseService(uid: user.uid).updateUserData(
                              name ?? userData.name,
                              emailID ?? userData.emailID,
                              phone ?? userData.phone,
                              address ?? userData.address,
                              newdob ?? userData.dob,
                            );
                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      )),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Container(
                          child: new RaisedButton(
                        child: new Text("Cancel"),
                        textColor: Colors.white,
                        color: Colors.teal[600],
                        onPressed: () {
                          setState(() {
                            _status = true;
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                          });
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                      )),
                    ),
                    flex: 2,
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Widget _getActionButton() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Container(
              child: new RaisedButton(onPressed: () {
                setState(() {
                  _status = true;
                });
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.teal[600],
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

//  Widget enableUpload(){
//    return Container(
//      child: Column(
//        children: <Widget>[
//          Image.file(sampleimage, height: 100.0, width: 100.0,),
//          RaisedButton(
//            color: Colors.blue,
//            onPressed: (){
//              final StorageReference firebaseRef = FirebaseStorage.instance.ref().child('myimage.jpg');
//              final StorageUploadTask task =
//                  firebaseRef.putFile(sampleimage);
//            },
//
//          )
//        ],
//      ),
//    );
//
//  }

}
