import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/constant.dart';

class AuthController {
  Future<String> signUpUser(
      String name, String address, String email, String password) async {
    String res = 'some error occured';
    try {
      if (name.isNotEmpty &&
          address.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        firebaseStore.collection('Customers').doc(cred.user!.uid).set({
          'Name': name,
          'Address': address,
          'Email': email,
        });
        print(cred.user!.email);
        res = 'success';
      } else {
        res = 'Fields must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}