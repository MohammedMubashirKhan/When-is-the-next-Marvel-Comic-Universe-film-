import 'package:bds_services_pvt_ltd/services/auth_methods.dart';
import 'package:bds_services_pvt_ltd/widgets/text_field_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController _phoneEditingController = TextEditingController();
  void phoneSignIn() async {
    FirebaseAuthMethods(FirebaseAuth.instance)
        .phoneSignIn(context, _phoneEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldInput(
              hintText: "Enter Phone Number",
              textInputType: TextInputType.phone,
              textEditingController: _phoneEditingController,
            ),
            SizedBox(
              height: 8,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                onTap: phoneSignIn,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 13,
                  ),
                  width: double.infinity,
                  color: Colors.orange,
                  child: Text("Send OTP"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
