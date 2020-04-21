import 'package:flutter/material.dart';
import 'package:palet/models/user.dart';

class CardTile extends StatelessWidget {
  final CardData card;

  CardTile( {this.card} );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child:
        ListTile(
          title: Text(card.number,
          style: TextStyle(
              color: Colors.black,
          ),
          ),
        ),
      )

    );
  }
}
