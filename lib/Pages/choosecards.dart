import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:palet/Pages/Add_card.dart';
import 'package:palet/Pages/MobileRecharge.dart';
import 'package:palet/Pages/PaymentOptions.dart';
import 'package:palet/Pages/authenticate/SignInPage.dart';
import 'package:palet/components/CreditCard.dart';
import 'package:palet/components/loading.dart';
import 'package:palet/models/uid.dart';
import 'package:palet/models/user.dart';
import 'package:palet/services/auth.dart';
import 'package:palet/services/database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class ChooseCards extends StatefulWidget {
  static final String id = 'choosecards';
  final String password;
  final int updateValue;



  ChooseCards({this.updateValue, this.password});
  @override
  _ChooseCardsState createState() => _ChooseCardsState();
}

class _ChooseCardsState extends State<ChooseCards> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CardData>>(
        stream: DatabaseService(uid: current_user_uid).cardData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<CardData> cardData = snapshot.data;
            List<CardWidget> cardNumbers = [];
            for (var card in cardData) {


              final cardWidget = CardWidget(
                Name: card.name,
                number: card.number,
                expiry: card.exp,
                cvv: card.cvv,
                update: widget.updateValue,
              );
              cardNumbers.add(cardWidget);

            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text('Choose cards'),
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: cardNumbers,

                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: LinearGradient(
                            colors: [Color(0xFF3CCD94), Colors.tealAccent],
                          )),
                      margin: EdgeInsets.only(top: 50.0),
                      width: double.infinity,
                      height: 50.0,
                      child: Center(
                          child: Text(
                        'Add Card',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, addcard.id);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}


