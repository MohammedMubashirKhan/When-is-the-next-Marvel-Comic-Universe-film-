import 'package:bds_services_pvt_ltd/screens/login_email_password.dart';
import 'package:bds_services_pvt_ltd/screens/phone_scree.dart';
import 'package:bds_services_pvt_ltd/screens/signup_email_password_screen.dart';
import 'package:bds_services_pvt_ltd/services/auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            custonButton(
              icon: Icon(Icons.email),
              label: Text("SugnUp with Email"),
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignUpEmailPasswordScreen(),
                ));
              },
            ),
            custonButton(
              icon: Icon(Icons.email),
              label: Text("Login with Email"),
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginEmailPassword(),
                ));
              },
            ),
            custonButton(
              icon: Icon(Icons.phone),
              label: Text("Phone"),
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PhoneScreen(),
                ));
              },
            ),
            custonButton(
              icon: Icon(Icons.person),
              label: Text("Anonymous signin"),
              function: () {
                FirebaseAuthMethods(FirebaseAuth.instance)
                    .signinAnonymous(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox custonButton({
    Function()? function,
    required Icon icon,
    required Widget label,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: function,
        icon: icon,
        label: label,
        style: ElevatedButton.styleFrom(
          primary: Colors.orange,
        ),
      ),
    );
  }
}

// class LoginScreenWithEmail extends StatefulWidget {
//   LoginScreenWithEmail({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<LoginScreenWithEmail> createState() => _LoginScreenWithEmailState();
// }

// class _LoginScreenWithEmailState extends State<LoginScreenWithEmail> {
//   final TextEditingController _emailTextEditingController =
//       TextEditingController();
//   final TextEditingController _passwordTextEditingController =
//       TextEditingController();
//   bool isLoading = false;
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _emailTextEditingController.dispose();
//     _passwordTextEditingController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login Screen"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFieldInput(
//               textEditingController: _emailTextEditingController,
//               hintText: 'Email',
//               textInputType: TextInputType.emailAddress,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             TextFieldInput(
//               textEditingController: _passwordTextEditingController,
//               hintText: 'Password',
//               textInputType: TextInputType.visiblePassword,
//               isPassword: true,
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             InkWell(
//               onTap: () async {
//                 String res;
//                 setState(() {
//                   isLoading = true;
//                 });
//                 res = await Authmethods().signUpUserWithEmailAndPassword(
//                     _emailTextEditingController.text,
//                     _passwordTextEditingController.text);
//                 setState(() {
//                   isLoading = false;
//                 });
//                 showSnackBar(res, context);
//               },
//               hoverColor: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8.0),
//                 child: isLoading
//                     ? CircularProgressIndicator(
//                         backgroundColor: Colors.white,
//                         color: Color.fromARGB(255, 2, 1, 0),
//                       )
//                     : Text("Login Or SignUp"),
//                 decoration: ShapeDecoration(
//                   color: Color.fromARGB(255, 211, 137, 26),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => LoginScreenWithPhone(),
//                   ));
//                 },
//                 child: Text("Login with Phone"))
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LoginScreenWithPhone extends StatefulWidget {
//   LoginScreenWithPhone({Key? key}) : super(key: key);

//   @override
//   State<LoginScreenWithPhone> createState() => _LoginScreenWithPhoneState();
// }

// class _LoginScreenWithPhoneState extends State<LoginScreenWithPhone> {
//   bool isLoading = false;
//   final TextEditingController _phoneTextEditingController =
//       TextEditingController();
//   final TextEditingController _otpTextEditingController =
//       TextEditingController();
//   bool otpCodeVisibility = false;
//   String _verificationId = "";

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _phoneTextEditingController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login Screen with Phone"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFieldInput(
//               hintText: "Phone Number",
//               textInputType: TextInputType.number,
//               textEditingController: _phoneTextEditingController,
//             ),
//             Visibility(
//               visible: otpCodeVisibility,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: TextFieldInput(
//                   hintText: "Code",
//                   textInputType: TextInputType.number,
//                   textEditingController: _otpTextEditingController,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             InkWell(
//               onTap: () {
//                 if (otpCodeVisibility) {
//                   loginPhone();
//                 }
//                 verifyPhone();
//               },
//               hoverColor: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               child: Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 8.0),
//                 child: isLoading
//                     ? CircularProgressIndicator(
//                         backgroundColor: Colors.white,
//                         color: Color.fromARGB(255, 2, 1, 0),
//                       )
//                     : Text(otpCodeVisibility ? "Login Or SignUp" : "Send OTP"),
//                 decoration: const ShapeDecoration(
//                   color: Color.fromARGB(255, 211, 137, 26),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(8),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pushReplacement(MaterialPageRoute(
//                     builder: (context) => LoginScreenWithEmail(),
//                   ));
//                 },
//                 child: Text("Login with Email")),
//           ],
//         ),
//       ),
//     );
//   }

//   verifyPhone() async {
//     String res = "some error occur";
//     if (_phoneTextEditingController.text.isNotEmpty) {
//       // ConfirmationResult confirmationResult = await FirebaseAuth.instance
//       //     .signInWithPhoneNumber("+91${_phoneTextEditingController.text}");
//       // _verificationId = confirmationResult.verificationId;

//       FirebaseAuth.instance.verifyPhoneNumber(
//         verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
//           await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
//         },
//         verificationFailed: (error) {
//           print(error.toString());
//         },
//         codeSent: (verificationId, forceResendingToken) {
//           _verificationId = verificationId;
//           setState(() {
//             otpCodeVisibility = true;
//           });
//         },
//         codeAutoRetrievalTimeout: (verificationId) {},
//       );
//       setState(() {
//         otpCodeVisibility = true;
//       });
//     }
//   }

//   loginPhone() async {
//     PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: _otpTextEditingController.text);
//     try {
//       await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
//     } catch (e) {}
//   }
// }
