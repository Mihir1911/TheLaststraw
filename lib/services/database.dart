

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:palet/Pages/profile/profile.dart';
import 'package:palet/Pages/wallet.dart';
import 'package:palet/components/mode.dart';
import 'package:palet/models/uid.dart';

import 'package:palet/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });
  final CollectionReference profileCollection = Firestore.instance.collection('profiles');
  final CollectionReference accountCollection = Firestore.instance.collection('accounts');
  final CollectionReference busTicketCollection = Firestore.instance.collection('bustickets');



  Future updateUserData(String name, String emailID, String phone, String address) async {
  return await profileCollection.document(uid).setData({
    'name': name,
    'emailID': emailID,
    'phone': phone,
    'address': address,


  });
}

Future updateUserBalance(int balance) async {
  return await accountCollection.document(uid).setData(
    {

      'balance': balance,
    }
  );
}

  Future updateUserCards(String suid) async {
    accountCollection.document(uid).collection('cards').document(suid).setData({
      'user_id':suid,
    });

  }
  Future deleteUserCards(String suid) async {
    accountCollection.document(uid).collection('cards').document(suid).delete();

  }




//profile list from snapshot

  List<Profile> _profileListFromSnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc){
    return Profile(
      name: doc.data['name'] ?? '',
      emailID: doc.data['emailID'] ?? '',
      phone: doc.data['phone'] ?? '',
      address: doc.data['address'] ?? '',

    );
  }).toList();
  }







  List<CardData> _cardsListFromSnapshot(QuerySnapshot snapshot){
   return snapshot.documents.map((doc){
     return CardData(
     exp: doc.data["cardExpiry"] ?? '',
       name: doc.data["cardHolderName"] ?? '',
     number: doc.data["cardNumber"] ?? ''

   );
  }).toList();
}


  //userData from snapshot

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  return UserData(
    uid: uid,
    name: snapshot.data["name"],
    emailID: snapshot.data["emailID"],
    phone: snapshot.data["phone"],
    address: snapshot.data["address"],

  );
  }


WalletData _walletDataFromSnapshot(DocumentSnapshot snapshot){
  return WalletData(
    uid: uid,
    balance: snapshot.data["balance"],

  );
}

 // ADD THIS PORTION
//get profiles stream

  Stream<List<Profile>> get profiles{
    return profileCollection.snapshots()
      .map(_profileListFromSnapshot);
}

//get user doc stream
  Stream<UserData> get userData{
    return profileCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

  Stream<WalletData> get walletData{
    return accountCollection.document(uid).snapshots()
        .map(_walletDataFromSnapshot);
  }

  Stream<List<CardData>> get cardData{
    return accountCollection.document(uid).collection('cards').snapshots()
    .map(_cardsListFromSnapshot);

  }

}