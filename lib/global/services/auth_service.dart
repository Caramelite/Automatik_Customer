import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/constant.dart';

class AuthController {
  Future<String> signUpUser(
      String name, String address, String email, String password, String phone) async {
    String res = 'some error occured';
    try {
      if (name.isNotEmpty &&
          address.isNotEmpty &&
          email.isNotEmpty &&
          phone.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        firebaseStore.collection('customers').doc(cred.user!.uid).set({
          'Name': name,
          'Address': address,
          'Email': email,
          'Phone': phone,
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

  // GET UID
  Future<String> getCurrentUID() async {
    return ( firebaseAuth.currentUser!).uid;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return firebaseAuth.currentUser!;
  }

  // Sign Out
  signOut() {
    return firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }
}