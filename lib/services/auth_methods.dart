import 'package:bds_services_pvt_ltd/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthMethods {
  FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // SIGNUP EMAIL
  signUpUserWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      sendEmailVerification(context);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (err) {
      showSnackBar(err.message!, context);
    }
  }

  // EMAIL LOGIN
  Future<void> loginEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (!_auth.currentUser!.emailVerified) {
        await sendEmailVerification(context);
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      showSnackBar("Email verificatio is sent", context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
  }

  signOut() async {
    await _auth.signOut();
  }

  // PHONE SIGN IN
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    TextEditingController codeController = TextEditingController();

    if (kIsWeb) {
      try {
        ConfirmationResult result =
            await _auth.signInWithPhoneNumber(phoneNumber);
        showOTPDialog(
          context: context,
          codeController: codeController,
          onPressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(
                verificationId: result.verificationId,
                smsCode: codeController.text.trim());
            await _auth.signInWithCredential(credential);
            Navigator.pop(context); // to remove OTP code dialog box
            Navigator.pop(context); // SECOND to remove PHONE LOGIN SCREEN
          },
        );
      } on FirebaseAuthException catch (e) {
        showSnackBar(e.message!, context);
      }
    } else {
      // FOR ANDROID AND IOS
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (error) {
          showSnackBar(error.message!, context);
        },
        codeSent: (String verificationId, int? forceResendingToken) async {
          showOTPDialog(
            context: context,
            codeController: codeController,
            onPressed: () async {
              PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: codeController.text.trim());
              await _auth.signInWithCredential(credential);
              // first to remove OTP code dialog box
              Navigator.pop(context);
              // SECOND to remove PHONE LOGIN SCREEN
              Navigator.pop(context);
            },
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    }
  }

  // ANONYMOUS SIGNIN
  Future<void> signinAnonymous(BuildContext context) async {
    try {
      await _auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      showSnackBar(e.message!, context);
    }
  }
}
