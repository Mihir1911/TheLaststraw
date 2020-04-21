import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palet/Pages/Homepage.dart';
import 'package:palet/components/CreditCard.dart';
import 'package:palet/components/loading.dart';
import 'package:palet/constants.dart';
import 'package:palet/models/uid.dart';
import 'package:palet/models/user.dart';
import 'package:palet/services/database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PaymentOptions extends StatefulWidget {
  static String id = '/paymentoptions';
  final int amount;

  PaymentOptions( { this.amount } );
  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  String walletID = '';
  int balance = 0;
  int amt;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool _value1 = false;

  String selected = 'Select Promo Code';

  Firestore _firestore = Firestore.instance;

  void _value1Changed(bool value) => setState(() => _value1 = value);
  bool _value2 = false;
  void _value2Changed(bool value) => setState(() => _value2 = value);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WalletData>(
        stream: DatabaseService(uid: current_user_uid).walletData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            WalletData walletData = snapshot.data;
            balance=walletData.balance;
            amt=widget.amount;
            return StreamBuilder<List<CardData>>(
                stream: DatabaseService(uid: current_user_uid).cardData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<CardData> cardData = snapshot.data;
                    List<CardWidget> cardNumbers = [];
                    List<RadioListTile> radiolist = [];
                    String _character;

                    for (var card in cardData) {
                      final cardWidget = CardWidget(
                        Name: card.name,
                        number: card.number,
                        expiry: card.exp,
                      );
                      cardNumbers.add(cardWidget);
                      _character = card.number;
                    }

                    return Scaffold(
                      appBar: AppBar(
                        backgroundColor: kMainColor,
                      ),
                      body: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Card(
                              elevation: 8.0,
                              child: Container(
                                height: 200.0,
                                width: double.infinity,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Amount to be paid ',
                                          style: TextStyle(fontSize: 30.0),
                                        ),
                                        Text(
                                          'Rs. $amt',
                                          style: TextStyle(fontSize: 30.0),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 50.0,
                                        child: DropdownButtonFormField(
                                          decoration: new InputDecoration(
                                            labelText: selected,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),

                                            labelStyle: TextStyle(
                                                color: Colors.grey[800]),

                                            //fillColor: Colors.green
                                          ),
                                          items: [
                                            DropdownMenuItem(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    '20FAB',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      'Get 10% off on purchases above Rs. 100'),
                                                ],
                                              ),
                                              value: '20FAB',
                                            ),
                                            DropdownMenuItem(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'PALLET75 ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      'Get 100% Cashback on purchases upto Rs.75 '),
                                                ],
                                              ),
                                              value: 'PALLET75',
                                            ),
                                            DropdownMenuItem(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'POB125 ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                      'Get 25% discount up to Rs.125'),
                                                ],
                                              ),
                                              value: 'POB125',
                                            ),
                                          ],
                                          onChanged: (val) {
                                            setState(() {
                                              selected = val;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ExpansionTile(
                              backgroundColor: kMainColor,
                              trailing: Icon(FontAwesomeIcons.wallet),
                              title: Text(
                                'Use Wallet',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Current Wallet balance: ' +
                                        walletData.balance.toString()),
                                    RaisedButton(
                                        child: Text('Use'), onPressed: () async {
                                          balance=balance-amt;
                                          if(balance<0){
                                            Alert(
                                              context: context,
                                              type: AlertType.error,
                                              title: "Insufficient Balance",
                                              desc: "Add card or use Saved Cards",
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "Okay",
                                                    style: TextStyle(color: Colors.white, fontSize: 20),

                                                  ),
                                                  onPressed: (){
                                                    Navigator.pop(context);

                                                  },
                                                  width: 120,
                                                )

                                              ],

                                            ).show();

                                          }
                                          else {
                                            await DatabaseService(
                                                uid: current_user_uid)
                                                .updateUserBalance(balance);
                                            Navigator.pop(context);
                                          }


                                    })
                                  ],
                                )
                              ],
                            ),
                            ExpansionTile(
                                trailing: Icon(Icons.credit_card),
                                title: Text(
                                  'Use Saved Cards',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                children: cardNumbers),
                            ExpansionTile(
                              trailing: Icon(Icons.credit_card),
                              title: Text(
                                'Add Card',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              children: <Widget>[
                                CreditCardForm(
                                  onCreditCardModelChange:
                                      onCreditCardModelChange,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, left: 20.0, right: 20.0),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 2.0),
                                      Container(
                                        child: CheckboxListTile(
                                          value: _value1,
                                          onChanged: _value1Changed,
                                          title: new Text('Remember card'),
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15.0),
                                        child: new RaisedButton(
                                          onPressed: () async {
                                            FirebaseUser user =
                                                await FirebaseAuth.instance
                                                    .currentUser();
                                            /*await DatabaseService(uid: user.uid).updateUserBalance(walletID, walletData.balance);*/
                                            if (_value1 == true) {
                                              _firestore
                                                  .collection('accounts')
                                                  .document(user.uid)
                                                  .collection('cards')
                                                  .add({
                                                'cardNumber': cardNumber,
                                                'cardExpiry': expiryDate,
                                                'cardHolderName':
                                                    cardHolderName,
                                              });
                                              Alert(
                                                context: context,
                                                type: AlertType.success,
                                                title: "New Card Added",
                                                buttons: [
                                                  DialogButton(
                                                    child: Text(
                                                      "Okay",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    },
                                                    width: 120,
                                                  )
                                                ],
                                              ).show();
                                            } else {
                                              setState(() async {});
                                              await DatabaseService(
                                                      uid: current_user_uid)
                                                  .updateUserBalance(balance);
                                            }
                                          },
                                          color: Colors.green,
                                          child: new Text('Add Card'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Loading();
                  }
                });
          } else {
            return Loading();
          }
        });
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
    });
  }
}
