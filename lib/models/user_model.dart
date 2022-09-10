import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserModel
{
  String? uid;
  String? address;
  String? name;
  String? email;
  String? phone;

  UserModel({this.address, this.name, this.email, this.uid, this.phone});

  UserModel.fromSnapshot(DataSnapshot snap)
  {
     uid = snap.key;
     address = (snap.value as dynamic)["address"];
     name = (snap.value as dynamic)["name"];
     email = (snap.value as dynamic)["email"];
     phone = (snap.value as dynamic)["phone"];
  }

  factory UserModel.fromDocument(DocumentSnapshot snap)
  {
    return UserModel(
        // uid: snap.get("id"),
        name: snap.get("Name"),
        address: snap.get("Address"),
        email: snap.get("Email"),
        phone: snap.get("Phone"),
    );

  }

//send data to Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': uid,
      'userName': name,
      'userEmail': email,
      'userPhone': phone,
      'userAddress': address,
    };
  }

  //draw data from firestore
  factory UserModel.fromFirestore(Map<String, dynamic> firestore) =>
      UserModel(
        uid: firestore['userId'],
        email: firestore['userEmail'] ?? " ",
        name: firestore['userName'] ?? " ",
        address: firestore['userAddress'] ?? " ",
        phone: firestore['userPhone'] ?? " ",
      );
}
