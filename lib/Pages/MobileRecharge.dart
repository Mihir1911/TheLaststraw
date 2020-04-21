import 'package:flutter/material.dart';
import 'package:palet/Pages/PaymentOptions.dart';
import 'package:palet/components/loading.dart';
import 'package:palet/models/uid.dart';
import 'package:palet/models/user.dart';
import 'package:palet/services/database.dart';

class MobileRecharge extends StatefulWidget {
  @override
  _MobileRechargeState createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  int getBillAmount(String provider) {
    if (provider == 'Vodafone') {
      return 400;
    }
    if (provider == 'Airtel') {
      return 500;
    }
    if (provider == 'Jio') {
      return 300;
    } else
      return 0;
  }

  String initial = 'Choose provider';
  int billAmount = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: current_user_uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    'Mobile Recharge',
                    style: TextStyle(fontFamily: 'PatuaOne'),
                  ),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Colors.tealAccent,
                          Colors.teal,
                        ],
                      ),
                    ),
                  ),
                ),
                body: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 60.0,
                            child: DropdownButtonFormField(
                              decoration: new InputDecoration(
                                labelText: initial,
                                fillColor: Colors.white,
                                focusColor: Colors.teal,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),

                                ),


                                labelStyle: TextStyle(color: Colors.grey[800]),

                                //fillColor: Colors.green
                              ),
                              items: [
                                DropdownMenuItem(
                                  child: Text('Vodafone'),
                                  value: 'Vodafone',
                                ),
                                DropdownMenuItem(
                                  child: Text('Airtel'),
                                  value: 'Airtel',
                                ),
                                DropdownMenuItem(
                                  child: Text('Jio'),
                                  value: 'Jio',
                                ),
                              ],
                              onChanged: (val) {
                                setState(() {
                                  billAmount = getBillAmount(val);
                                  initial = val;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            initialValue: userData.phone,
                            decoration: new InputDecoration(
                              labelText: "Enter Phone number",
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelStyle: TextStyle(color: Colors.grey[800]),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(
                                  color: Colors.green,
                                ),
                              ),

                              //fillColor: Colors.green
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Card(
                            elevation: 8.0,
                            child: Container(
                              height: 200.0,
                              width: 300.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    'Bill Amount',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                  Text(
                                    'Rs. $billAmount',
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF3CCD94),
                                    Colors.tealAccent
                                  ],
                                )),
                            margin: EdgeInsets.only(top: 50.0),
                            width: double.infinity,
                            height: 50.0,
                            child: Center(
                                child: Text(
                              'Proceed to pay',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          onTap: () {
                            if (billAmount != 0) {
    Navigator.push(context, MaterialPageRoute(builder: (context){
    return PaymentOptions(amount: billAmount,);
    }));
                            } else {}
                          },
                        )
                      ],
                    ),
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}
