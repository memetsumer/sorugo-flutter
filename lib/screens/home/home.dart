import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_yks_app/screens/home/home_config_wrapper.dart';
import 'package:flutter_yks_app/utils/account/logout.dart';

import '/screens/onboarding/welcome.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Stream<User?> authState;

  @override
  void initState() {
    super.initState();

    authState = FirebaseAuth.instance.authStateChanges();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: authState,
        builder: (BuildContext context, authSnapshot) {
          if (authSnapshot.hasError) {
            logOutBeginning(context);
            return Scaffold(
                body: Center(
                    child: Text(
                        "Giriş yapılırken hata oluştu. ${authSnapshot.error}")));
          }

          if (authSnapshot.hasData) {
            return const HomeConfigWrapper();
          } else {
            return const WelcomeScreen();
          }
        });
  }
}
