import 'package:automatik_users_app/constants/firebase_auth_controller.dart';
import 'package:automatik_users_app/global/global.dart';
import 'package:automatik_users_app/screens/Splash%20Screen/splash_screen.dart';
import 'package:automatik_users_app/widgets/progress_dialog.dart';
import 'package:automatik_users_app/widgets/roundedbutton.dart';
import 'package:automatik_users_app/widgets/textfield.dart';
import 'package:automatik_users_app/widgets/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String profileLink;
  late String licenseLink;
  bool showSpinner = false;
  late String email;
  late String password;
  TextEditingController emailC = TextEditingController();
  TextEditingController firstNameC = TextEditingController();
  TextEditingController lastNameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController licenseC = TextEditingController();
  TextEditingController pass1C = TextEditingController();
  TextEditingController pass2C = TextEditingController();
  FocusNode emailFN = FocusNode();
  FocusNode firstNameFN = FocusNode();
  FocusNode lastNameFN = FocusNode();
  FocusNode phoneFN = FocusNode();
  FocusNode licenseFN = FocusNode();
  FocusNode pass1FN = FocusNode();
  FocusNode pass2FN = FocusNode();
  FocusNode licensePhotoFN = FocusNode();
  bool hidePassword = true;
  bool hidePassword1 = true;
  DateTime expiryDate = DateTime.now();
  DateTime minimumDate = DateTime.now().subtract(
    const Duration(days: 0),
  );
  ScrollController scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();

  validateForm() {
    if (firstNameC.text.length < 3) {
      Fluttertoast.showToast(msg: "Name must be at least 3 characters.");
    } else if (!emailC.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email Address is not valid.");
    } else if (phoneC.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number is mandatory.");
    } else if (pass1C.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters");
    } else {
      saveCustomerInfoNow();
    }
  }

  saveCustomerInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(message: "Processing... Please wait");
        });

    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
                email: emailC.text.trim(), password: pass1C.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      Map customerMap = {
        "id": firebaseUser.uid,
        "name": firstNameC.text.trim(),
        "email": emailC.text.trim(),
        "phone": phoneC.text.trim(),
      };

      DatabaseReference customerRef =
          FirebaseDatabase.instance.ref().child("customer");
      customerRef.child(firebaseUser.uid).set(customerMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been created!");
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created.");
    }
  }

  @override
  void dispose() {
    emailC.dispose();
    firstNameC.dispose();
    lastNameC.dispose();
    phoneC.dispose();
    licenseC.dispose();
    pass1C.dispose();
    pass2C.dispose();
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text("Registration"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Scrollbar(
            controller: scrollController,
            child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 16.00),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              validator: UnifiedValidators.emptyValidator,
                              controller: firstNameC,
                              focusNode: firstNameFN,
                              textAlign: TextAlign.left,
                              onEditingComplete: () {
                                lastNameFN.requestFocus();
                              },
                              keyboardType: TextInputType.name,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'First Name',
                              ),
                            ),
                          ),
                          Container(
                            width: 16.0,
                          ),
                          Flexible(
                            child: TextFormField(
                              validator: UnifiedValidators.emptyValidator,
                              controller: lastNameC,
                              focusNode: lastNameFN,
                              onEditingComplete: () {
                                emailFN.requestFocus();
                              },
                              textAlign: TextAlign.left,
                              keyboardType: TextInputType.name,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Last Name',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        validator: UnifiedValidators.emailValidator,
                        controller: emailC,
                        focusNode: emailFN,
                        textAlign: TextAlign.left,
                        onEditingComplete: () {
                          phoneFN.requestFocus();
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Email',
                          prefixIcon: const Icon(
                            Icons.email,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        validator: UnifiedValidators.emptyValidator,
                        controller: phoneC,
                        focusNode: phoneFN,
                        textAlign: TextAlign.left,
                        onEditingComplete: () {
                          pass1FN.requestFocus();
                        },
                        keyboardType: TextInputType.number,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Phone Number',
                          prefixIcon: const Icon(
                            Icons.phone,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        validator: UnifiedValidators.passwordValidator,
                        controller: pass1C,
                        focusNode: pass1FN,
                        textAlign: TextAlign.left,
                        onEditingComplete: () {
                          pass2FN.requestFocus();
                        },
                        obscureText: hidePassword,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(hidePassword
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextFormField(
                        validator: (value) =>
                            MatchValidator(errorText: 'Password does not match')
                                .validateMatch(pass1C.text, pass2C.text),
                        controller: pass2C,
                        focusNode: pass2FN,
                        textAlign: TextAlign.left,
                        obscureText: hidePassword1,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(hidePassword1
                                ? CupertinoIcons.eye_slash
                                : CupertinoIcons.eye),
                            onPressed: () {
                              setState(() {
                                hidePassword1 = !hidePassword1;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: RoundedButton(
                          buttonTitle: 'Register',
                          color: Colors.blueAccent,
                          buttonOnPressed: () {
                            AuthController.instance.register(
                                emailC.text.trim(), pass1C.text.trim());
                          }),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}