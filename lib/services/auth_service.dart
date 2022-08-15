import 'package:automatik_users_app/constants/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthController {
  Future<String> signUpUser(
      String firstname, String lastname, String email, String password) async {
    String res = 'some error occured';
    try {
      if (firstname.isNotEmpty &&
          lastname.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        firebaseStore.collection('customers').doc(cred.user!.uid).set({
          'First Name': firstname,
          'Last Name': lastname,
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
