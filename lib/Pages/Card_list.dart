import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:palet/components/Cardtile.dart';
import 'package:palet/models/user.dart';
import 'package:provider/provider.dart';

class CardList extends StatefulWidget {
  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {

    final cards=Provider.of<List<CardData>>(context);

 cards.forEach((card){
   print(card.number);
 }

 );

  return Container();

  }
}
