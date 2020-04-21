








import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:palet/BusTickets.dart';
import 'package:palet/Pages/Add_card.dart';
import 'package:palet/Pages/BusTicketForm.dart';
import 'package:palet/Pages/Homepage.dart';
import 'package:palet/Pages/MobileRecharge.dart';
import 'package:palet/Pages/BusTicketsBLABLA.dart';
import 'package:palet/Pages/PaymentOptions.dart';
import 'package:palet/Pages/choosecards.dart';

import 'package:palet/Pages/profile/ProfilePage.dart';
import 'package:palet/Pages/shopping/ShoppingPage.dart';

import 'package:palet/Pages/authenticate/SignInPage.dart';
import 'package:palet/Pages/authenticate/SignupPage.dart';

import 'package:palet/Pages/wallet.dart';
import 'package:palet/Pages/wrapper.dart';
import 'package:palet/models/user.dart';
import 'package:palet/services/auth.dart';
import 'package:provider/provider.dart';



void main() => runApp(MyApp());

 class MyApp extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
     return StreamProvider<UserID>.value(
       value: AuthService().user,
       child: MaterialApp(
         debugShowCheckedModeBanner: false,
      home: Wrapper(),
       routes:
{

'/home': (context)=> Home(),
'/profile': (context) => ProfilePage(),
'/shopping': (context) => ShoppingPage(),
'/signup': (context) => SignUpPage(),
'/signin': (context) => SignInPage(),
'/wallet':(context) => WalletPage(),
  '/recharge':(context) => MobileRecharge(),
  '/movie':(context) => BusTicketsBLABLA(),
  ChooseCards.id: (context) => ChooseCards(),
addcard.id: (context) => addcard(),
  BusTicketsPage.id: (context) => BusTicketsPage(),
  PaymentOptions.id: (context) => PaymentOptions(),
  BusTicketForm.id: (context) => BusTicketForm(),

  // Lets just put a comment here
// lalala
//beep bop
       //beeeeeeep
//haha

}

       ),
     );
   }
 }


