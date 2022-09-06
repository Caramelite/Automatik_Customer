import 'package:automatik_users_app/widgets/roundedbutton.dart';
import 'package:automatik_users_app/widgets/textfield.dart';
import 'package:automatik_users_app/widgets/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../global/services/auth_service.dart';
import '../../widgets/dimensions.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String profileLink;
  late String licenseLink;
  bool showSpinner = false;
  late String email;
  late String password;
  TextEditingController emailC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController licenseC = TextEditingController();
  TextEditingController pass1C = TextEditingController();
  TextEditingController pass2C = TextEditingController();
  FocusNode emailFN = FocusNode();
  FocusNode nameFN = FocusNode();
  FocusNode addressFN = FocusNode();
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

  @override
  void dispose() {
    emailC.dispose();
    nameC.dispose();
    addressC.dispose();
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
            SizedBox(height: Dimensions.screenHeight*0.1),
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
                controller: nameC,
                focusNode: nameFN,
                textAlign: TextAlign.left,
                onEditingComplete: () {
                  nameFN.requestFocus();
                },
                keyboardType: TextInputType.name,
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Name',
                  prefixIcon: const Icon(
                    Icons.person,
                  ),
                ),
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
                controller: addressC,
                focusNode: addressFN,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.name,
                decoration: kTextFieldDecoration.copyWith(
                  labelText: 'Address',
                  prefixIcon: const Icon(
                    Icons.location_on_rounded,
                  ),
                ),
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
                buttonOnPressed: () async {
                  await AuthController().signUpUser(nameC.text, addressC.text,
                       emailC.text, pass2C.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}