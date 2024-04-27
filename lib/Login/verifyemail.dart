import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cresco24/Components/myButton.dart';
import 'package:cresco24/Components/utils.dart';
import 'package:cresco24/Home/beforeHome.dart';


//deals with statuis of email verification
class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  //if email is not verified, sends a verification email
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 2),
        (_) => checkEmailVerified(),
      ); // Timer. periodic
    }
  }

  @override
  //timer is used so that verification email can be sent again after some time
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } on Exception catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future signOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  //if user is verified, returns home, else stays on verification page
  Widget build(BuildContext context) => isEmailVerified || FirebaseAuth.instance.currentUser!.email.toString() == "guest@srimalcards.in"
      ?  const BeforeHome()
      : Scaffold(
          backgroundColor: HexColor("#4169E1"),
          appBar: AppBar(
            backgroundColor: HexColor("#4169E1"),
            title: const Text("Verify Email"),
          ),
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text("A verification email has been sent",
                  style: TextStyle(
                      fontFamily: "Sarabun",
                      fontSize: 30,
                      color: Colors.white)),
              const SizedBox(height: 24),
              MyButton(onTap: sendVerificationEmail, text: "Resend Email"),
              const SizedBox(height: 24),
              MyButton(onTap: signOut, text: "Cancel"),
            ],
          )));
}
