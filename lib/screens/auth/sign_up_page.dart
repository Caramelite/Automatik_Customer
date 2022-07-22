import 'package:automatik_users_app/widgets/dimensions.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameTextEditingController = TextEditingController();
    TextEditingController emailTextEditingController = TextEditingController();
    TextEditingController phoneTextEditingController = TextEditingController();
    TextEditingController passwordTextEditingController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Dimensions.screenHeight*0.05),
          //app logo
          SizedBox(
            height: Dimensions.screenHeight*0.25,
            child: const Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 80,
                backgroundImage: AssetImage("assets/images/Logo.png"),
              ),
            ),
          ),
          SizedBox(height: Dimensions.height20),
          //name
          AppTextField(
            textController: nameTextEditingController,
            hintText: "Name",
            icon: Icons.person,
          ),
          SizedBox(height: Dimensions.height20),
          //email
          AppTextField(
            textController: emailTextEditingController,
            hintText: 'Email',
            icon: Icons.email,
          ),
          SizedBox(height: Dimensions.height20),
          //pasword
          AppTextField(
            textController: passwordTextEditingController,
            hintText: 'Password',
            icon: Icons.password_sharp,
          ),
          SizedBox(height: Dimensions.height20),
          //phone
          AppTextField(
            textController: phoneTextEditingController,
            hintText: "Phone",
            icon: Icons.phone,
          ),
        ],
      ),
    );
  }
}
