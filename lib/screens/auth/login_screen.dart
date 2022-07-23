import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global/global.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/progress_dialog.dart';
import '../splashScreen/splash_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if(!emailTextEditingController.text.contains("@"))
    {
      Fluttertoast.showToast(msg: "Email Address is not valid.");
    }

    else if(passwordTextEditingController.text.isEmpty)
    {
      Fluttertoast.showToast(msg: "Password is required.");
    }
    else
    {
      loginCustomerNow();
    }
  }

  loginCustomerNow() async {
    showDialog(
        context : context,
        barrierDismissible: false,
        builder: (BuildContext c)
        {
          return ProgressDialog(message: "Processing... Please wait");
        }
    );

    final User? firebaseUser =
        (
            await fAuth.signInWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim()
            ).catchError((msg) {
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "Error: " + msg.toString());
            })
        ).user;

    if(firebaseUser != null)
    {
      DatabaseReference customerRef = FirebaseDatabase.instance.ref().child("customer");
      customerRef.child(firebaseUser.uid).once().then((customerKey)
      {
        final snap = customerKey.snapshot;
        if(snap.value != null)
        {
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Logged in Successfully!");
          Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
        else
        {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
      });
    }
    else
    {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05),
              Container(
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage("assets/images/Logo.png"),
                ),
              ),
              SizedBox(height: Dimensions.height20+Dimensions.height10),

              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Hello", style: TextStyle(color: Colors.black, fontSize: 56, fontWeight: FontWeight.bold)),
                    Text("Sign in to your account", style: TextStyle(color: Colors.grey))
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20),

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
                child: TextField(
                  controller: emailTextEditingController,
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
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20),

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
                child: TextField(
                  controller: passwordTextEditingController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.password, color: Colors.blue,),
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
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20),

              Container(
                width: Dimensions.screenWidth/2,
                height: Dimensions.screenHeight/13,
                child: ElevatedButton(
                  onPressed: ()
                  {
                    validateForm();
                  },
                  child: const Center(
                    child: Text("Login",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.height20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account yet?",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  TextButton(
                    child: Text("SignUp here",
                      style: TextStyle(color: Colors.grey[850]),
                    ),
                    onPressed: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (c) => const SignUpScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
