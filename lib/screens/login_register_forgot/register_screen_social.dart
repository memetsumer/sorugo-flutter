import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/app_provider.dart';
import '../../utils/constants.dart';
import 'sign_in_helpers.dart';

class RegisterScreenSocial extends StatefulWidget {
  const RegisterScreenSocial({Key? key}) : super(key: key);

  @override
  State<RegisterScreenSocial> createState() => _RegisterScreenSocialState();
}

class _RegisterScreenSocialState extends State<RegisterScreenSocial> {
  bool isButtonActive = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.read<AppProvider>().goOnboarding();
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultPadding * 2),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 51, 51, 51).withOpacity(0.1),
                      const Color.fromARGB(255, 115, 115, 115).withOpacity(0.2),
                    ]),
                border: Border.all(
                  color: Colors.white24,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 25,
                    spreadRadius: -5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: defaultPadding),
                  Center(
                    child: Image.asset(
                      "assets/images/logo_name.png",
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: defaultPadding * 3),
                  if (Platform.isIOS)
                    SignInSocial.buildOnlyAppleSignIn(context),
                  const SizedBox(height: defaultPadding),
                  SignInSocial.buildOnlyGoogleSignIn(context),
                  const SizedBox(height: defaultPadding * 1.5),
                ],
              ),
            ),
          ),
          // create a user agreement and privacy-policy rich text
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
