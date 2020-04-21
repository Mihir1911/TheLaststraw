import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:palet/Pages/shopping/Shopping_cart_new.dart';
import 'package:palet/Pages/shopping/Shopping_list_new.dart';
import 'package:palet/constants.dart';
import '../../components/HorizontalList.dart';
import '../../components/products.dart';
import '../Cart.dart';
import 'Shopping_cart.dart';

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    Widget image_carousel=new Container(
      height: 200.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('Asset/c1.jpg'),
          AssetImage('Asset/m1.jpeg'),
          AssetImage('Asset/m2.jpg'),
          AssetImage('Asset/w1.jpeg'),
        ],
        autoplay: false,
        // animationCurve: Curves.fastOutSlowIn,
        //animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart())
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kMainColor,
        centerTitle: true,

        title: Text('ShoppApp'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,color: Colors.white,),onPressed: (){},),
          IconButton(icon: Icon(Icons.list,color: Colors.white,),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new Shopping_list()));

          },),
          IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,),onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new Newcart()));

          },)

        ],

      ),







      body: ListView(
        children: <Widget>[
          image_carousel,
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Categories'),

          ),
          HorizontalList(),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text('Products'),


          ),
          Container(
            height: 320.0,
            child: Products(),
          )
        ],
      ),


    );
  }
}

