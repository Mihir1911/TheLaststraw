import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:palet/Pages/BusTicketForm.dart';
import 'package:palet/constants.dart';


class BusTicketsPage extends StatefulWidget {
  static String id='/bus';
  @override
  _BusTicketsPageState createState() => _BusTicketsPageState();
}

class _BusTicketsPageState extends State<BusTicketsPage> {
  Widget image_carousel=new Container(
    height: 200.0,
    child: Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('Asset/bus3.jpg'),
        AssetImage('Asset/bus4.jpg'),
        AssetImage('Asset/bus1.png'),
        AssetImage('Asset/bus2.png'),
      ],
      autoplay: false,
      // animationCurve: Curves.fastOutSlowIn,
      //animationDuration: Duration(milliseconds: 1000),
      dotSize: 4.0,
      indicatorBgPadding: 2.0,
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart())
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text('Bus Tickets'),



      ),
      body: ListView(
        children: <Widget>[
          image_carousel,
          RaisedButton(
            child: Text(
                'Add tickets'
            ),
            onPressed: (){
              Navigator.pushNamed(context, BusTicketForm.id);
            },
          )


        ],

      ),


    );
  }
}
