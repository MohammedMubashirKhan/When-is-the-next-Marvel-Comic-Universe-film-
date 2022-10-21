import 'package:bds_services_pvt_ltd/services/auth_methods.dart';
import 'package:bds_services_pvt_ltd/utils/utils.dart';
import 'package:bds_services_pvt_ltd/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpEmailPasswordScreen extends StatefulWidget {
  const SignUpEmailPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SignUpEmailPasswordScreen> createState() =>
      _SignUpEmailPasswordScreenState();
}

class _SignUpEmailPasswordScreenState extends State<SignUpEmailPasswordScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  void signUpUser() async {
    if (_passwordTextEditingController.text ==
        _confirmPasswordTextEditingController.text) {
      FirebaseAuthMethods(FirebaseAuth.instance).signUpUserWithEmailAndPassword(
          email: _emailTextEditingController.text,
          password: _passwordTextEditingController.text,
          context: context);
    } else {
      showSnackBar("Password are not matching", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SignUp With Email",
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
              hintText: "Enter password",
              textInputType: TextInputType.emailAddress,
              textEditingController: _passwordTextEditingController,
              isPassword: true,
            ),
            SizedBox(
              height: 16,
            ),
            TextFieldInput(
              hintText: "Confirm password",
              textInputType: TextInputType.emailAddress,
              textEditingController: _confirmPasswordTextEditingController,
              isPassword: true,
            ),
            SizedBox(
              height: 40,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                onTap: signUpUser,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  width: double.infinity,
                  color: Colors.orange,
                  child: Text("SignUp"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
