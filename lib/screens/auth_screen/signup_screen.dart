import 'package:automatik_users_app/global/global.dart';
import 'package:automatik_users_app/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../controllers/firebase_auth_controller.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/roundedbutton.dart';
import '../../widgets/textfield.dart';
import '../../widgets/validators.dart';
import '../splashScreen/splash_screen.dart';
import 'login_screen.dart';

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.05),
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              backgroundImage: AssetImage("assets/images/Logo.png"),
            ),
            SizedBox(height: Dimensions.height20+Dimensions.height10),

            Container(
              margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
              child: TextFormField(
                validator: UnifiedValidators.emptyValidator,
                controller: firstNameC,
                focusNode: firstNameFN,
                  decoration: InputDecoration(
                    hintText: "First Name",
                    prefixIcon: const Icon(Icons.person, color: Colors.blue,),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                  )
              ),
            ),
            SizedBox(height: Dimensions.height10),

            Container(
              margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
                child: TextFormField(
                  validator: UnifiedValidators.emptyValidator,
                    controller: lastNameC,
                  focusNode: lastNameFN,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      prefixIcon: const Icon(Icons.person, color: Colors.blue,),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        borderSide: const BorderSide(color: Colors.white, width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                      ),
                    )
                ),
            ),
            SizedBox(height: Dimensions.height10),

            Container(
              margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
              child: TextFormField(
                  validator: UnifiedValidators.emailValidator,
                  controller: emailC,
                  focusNode: emailFN,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email, color: Colors.blue,),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                  )
              ),
            ),
            SizedBox(height: Dimensions.height10),

            Container(
              margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
              child: TextFormField(
                  validator: UnifiedValidators.emptyValidator,
                  controller: phoneC,
                  focusNode: phoneFN,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Phone",
                    prefixIcon: const Icon(Icons.phone, color: Colors.blue,),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                  )
              ),
            ),
           SizedBox(height: Dimensions.height10),

            Container(
              margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
              child: TextFormField(
                validator: UnifiedValidators.passwordValidator,
                controller: pass1C,
                focusNode: pass1FN,
                obscureText: hidePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock, color: Colors.blue,),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      borderSide: const BorderSide(color: Colors.white, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(hidePassword
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye, color: Colors.blue,),
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                    ),
                  )
              ),
            ),
            SizedBox(height: Dimensions.height10),

            Container(
              margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2)
                    )
                  ]
              ),
              child: TextFormField(
                validator: (value) =>
                    MatchValidator(errorText: 'Password does not match')
                        .validateMatch(pass1C.text, pass2C.text),
                controller: pass2C,
                focusNode: pass2FN,
                obscureText: hidePassword1,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock, color: Colors.blue,),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(hidePassword1
                        ? CupertinoIcons.eye_slash
                        : CupertinoIcons.eye, color: Colors.blue,),
                    onPressed: () {
                      setState(() {
                        hidePassword1 = !hidePassword1;
                      });
                    },
                  ),
                )
              ),
            ),
            SizedBox(height: Dimensions.height20),

            Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenHeight/13,
              child: ElevatedButton(
                onPressed: ()
                {
                  AuthController.instance.register(
                      emailC.text.trim(), pass1C.text.trim());

                },
                child: const Center(
                  child: Text("Register",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Alredy have an account?",  style: TextStyle(color: Colors.grey[700]),),
                TextButton(
                  child: Text("Login here",
                    style: TextStyle(color: Colors.grey[850]),
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
                  },
                )
              ],
            ),

            /*Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: RoundedButton(
                  buttonTitle: 'Register',
                  color: Colors.blueAccent,
                  buttonOnPressed: () {
                    AuthController.instance.register(
                        emailC.text.trim(), pass1C.text.trim());
                  }),
            ),*/
          ],
        ),
      ),
    );
  }
}