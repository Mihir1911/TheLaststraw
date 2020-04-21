import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:palet/Pages/authenticate/authenticate.dart';
import 'package:palet/components/loading.dart';
import 'package:palet/constants.dart';
import 'package:palet/services/auth.dart';


class SignUpPage extends StatefulWidget {
  final Function toggleView;
  SignUpPage({ this.toggleView });


  @override
  _SignPageState createState() => _SignPageState();
}

class _SignPageState extends State<SignUpPage> {
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formKey= GlobalKey<FormState>();
  String email='';
  String password='';
  String error='';
  String phone='';
  String name='';
  Timestamp dob;
  final TextEditingController phoneNumberController= MaskedTextController(mask: '0000000000');
  final TextEditingController emailController= MaskedTextController(mask: 'A');
  int day = 01;
  int month = 01;
  int year = 2002;
  DateTime newDt = DateTime.now();
  Timestamp myTimeStamp = Timestamp.fromDate(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return  loading? Loading() :Scaffold(
      resizeToAvoidBottomPadding: false,
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child:Stack(
              children: <Widget>[
                Container(
                  padding:EdgeInsets.fromLTRB(15.0, 50.0,0.0,0.0),
                  child:Text(
                      'Sign up',

                      style:TextStyle(
                        color: kMainColor,
                          fontSize:80.0,
                          fontWeight:FontWeight.bold,
                      fontFamily: 'Pacifico')
                  ),
                ),


              ],
            ),
          ),
          Container(
            padding:EdgeInsets.only(top:35.0,left:20.0,right:20.0),
            child:Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      validator: (val) => val.isEmpty? 'Enter your name': null,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color:Colors.grey,
                        ),
                      ),

                      onChanged: (val){
                        setState(()
                        => name = val
                        );
                      }
                  ),
                  TextFormField(
                      validator: (val) => val.length !=10 ? 'Enter a valid phone no.': null,
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color:Colors.grey,
                        ),
                      ),

                      onChanged: (val){
                        setState(()
                        => phone = val
                        );
                      }
                  ),
                  TextFormField(
                    validator: (val) => val.isEmpty? 'Enter your email': null,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color:Colors.grey,
                        ),
                      ),

                      onChanged: (val){
                        setState(()
                        => email = val
                        );
                      }
                  ),
                 Row(

                   children: <Widget>[
                     Container(
                       width: 230.0,
                       child: TextFormField(
                         decoration: InputDecoration(
                             hintText: 'DOB: $day/$month/$year'
                         ),
enabled: false,
                       ),
                     ),
                     FlatButton(
                       onPressed: () async {
                         newDt = await showRoundedDatePicker(
                           context: context,
                           initialDate: DateTime(DateTime.now().year - 18),
                           firstDate: DateTime(DateTime
                               .now()
                               .year - 50),
                           lastDate: DateTime(DateTime
                               .now()
                               .year - 10),
                           borderRadius: 16,
                         );
                         print('$newDt is newdt');
                         myTimeStamp = Timestamp.fromDate(newDt);
                         setState(() {
                           day=newDt.day;
                           month=newDt.month;
                           year=newDt.year;
                         });
                         dob = Timestamp.fromDate(newDt);


                       },
                       child: Icon(
                         Icons.date_range,
                       ),
                     ),
                   ],

                 ),
                  TextFormField(
                      validator: (val) => val.length<6? 'Enter a password 6+ chars long': null,
                      decoration: InputDecoration(

                        labelText: 'Password',
                        labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          color:Colors.grey,
                        ),
                      ),
                      obscureText: true,
                      onChanged: (val){
                        setState(()
                        => password = val
                        );
                      }
                  ),
                  SizedBox(height:20.0,),
                  SizedBox(height:5.0),
                  SizedBox(height:40.0),
                  Container(
                    height:40.0,
                    child:Material(
                      borderRadius:BorderRadius.circular(20.0),
                      shadowColor:Colors.greenAccent,
                      color: kSecondaryColor,
                      elevation:7.0,
                      child:GestureDetector(
                        onTap:() async {

                          if(_formKey.currentState.validate()) {
                            setState(() =>
                            loading = true);
                            dynamic newUser = await _auth
                                .registerWithEmailAndPassword(name, email, password, phone, dob);

                            if (newUser == null) {
                              setState(() =>
                              error = 'please supply a valid email');

                              loading = false;
                            }
                          }


                        },
                        child:Center(
                          child:Text(
                            'Register',
                            style:TextStyle(
                                color:Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily:'Montserrat'
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height:20.0),
                  Text(error,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height:5.0),
                  InkWell(
                    onTap: () {
                    widget.toggleView();
                    },
                    child:Text('Already have an Account? Sign in',
                      style:TextStyle(
                        color:Colors.green,
                        fontFamily:'Montserrat',
                        fontWeight:FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),),
                  )
                ],

              ),
            ),
          ),



        ],
      ),
    );
  }
}










