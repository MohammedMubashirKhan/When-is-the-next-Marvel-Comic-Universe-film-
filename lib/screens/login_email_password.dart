import 'package:bds_services_pvt_ltd/services/auth_methods.dart';
import 'package:bds_services_pvt_ltd/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginEmailPassword extends StatefulWidget {
  const LoginEmailPassword({Key? key}) : super(key: key);

  @override
  State<LoginEmailPassword> createState() => _LoginEmailPasswordState();
}

class _LoginEmailPasswordState extends State<LoginEmailPassword> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  void loginUser() async {
    FirebaseAuthMethods(FirebaseAuth.instance).loginEmailPassword(
        email: _emailTextEditingController.text,
        password: _passwordTextEditingController.text,
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login With Email",
          style: TextStyle(fontSize: 30),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldInput(
              hintText: "Email",
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailTextEditingController,
            ),
            SizedBox(
              height: 16,
            ),
            TextFieldInput(
              hintText: "password",
              textInputType: TextInputType.emailAddress,
              textEditingController: _passwordTextEditingController,
              isPassword: true,
            ),
            SizedBox(
              height: 40,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                onTap: loginUser,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  width: double.infinity,
                  color: Colors.orange,
                  child: Text("login"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
