import 'package:firebase_database/firebase_database.dart';

class UserModel
{
  String? address;
  String? name;
  String? uid;
  String? email;
  String? imagePath;

  UserModel({this.address, this.name, this.email, this.uid});

  /*UserModel.fromSnapshot(DataSnapshot snap)
  {
    phone = (snap.value as dynamic)["phone"];
    name = (snap.value as dynamic)["name"];
    id = snap.key;
    email = (snap.value as dynamic)["email"];
    imagePath = (snap.value as dynamic)["imagePath"];
  }*/

//send data to Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': uid,
      'userName': name,
      'userEmail': email,
      'userPhone': address,
    };
  }

  //draw data from firestore
  factory UserModel.fromFirestore(Map<String, dynamic> firestore) =>
      UserModel(
        uid: firestore['userId'],
        email: firestore['userEmail'] ?? " ",
        name: firestore['userName'] ?? " ",
        address: firestore['userAddress'] ?? " ",
      );
}
