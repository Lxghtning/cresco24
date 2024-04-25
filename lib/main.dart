import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Components/utils.dart';
import 'Login/verifyemail.dart';
import 'firebase_options.dart';
import 'package:cresco24/Login/sign_up.dart';


final navigatorKey = GlobalKey<NavigatorState>();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //After initialization, building material app
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
      home: const SecurityTree(),

    );
  }
}

class SecurityTree extends StatefulWidget {
  const SecurityTree({super.key});

  @override
  State<SecurityTree> createState() => _SecurityTreeState();
}

class _SecurityTreeState extends State<SecurityTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (ConnectionState == snapshot.connectionState) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something Went Wrong!!"),
              );
            } else if (snapshot.hasData && FirebaseAuth.instance.currentUser!.isAnonymous == false) {
              return const VerifyEmailPage();
            } else {
              return const SignUpWidget();
            }
          }),
    );
  }
}

