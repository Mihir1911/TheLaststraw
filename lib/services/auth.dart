import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:palet/models/user.dart';
import 'package:palet/models/uid.dart';
import 'package:palet/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  UserID _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? UserID(user.uid) : null;
  }

  Stream<UserID> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }


  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      p = password;
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      current_user_uid = user.uid;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String name, String email, String password, String phone, Timestamp dob) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      current_user_uid = user.uid;
      await DatabaseService(uid: user.uid)
          .updateUserData(name, email, phone, null,dob);
      await DatabaseService(uid: user.uid).updateUserBalance(1000);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }




//  Future<void> verifyPhone(String phone, String verificationID, String email, String password) async {
//
//
//    final PhoneVerificationCompleted verified = (AuthCredential authResult){
//AuthService().signInWithEmailAndPassword(email, password);
//    };
//    final PhoneVerificationFailed verificationFailed = (AuthException authException){
//print(authException.toString());
//    };
//    final PhoneCodeSent smsSent = (String verId, [int forceSend]){
//verificationID= verId;
//    };
//    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId){
//      verificationID= verId;
//    };
//
//      await _auth.verifyPhoneNumber(
//          phoneNumber: phone,
//          timeout: const Duration(seconds: 5),
//          verificationCompleted: verified,
//          verificationFailed: verificationFailed,
//          codeSent: smsSent,
//          codeAutoRetrievalTimeout: autoTimeout);
//
//
//
//  }


  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }





}




