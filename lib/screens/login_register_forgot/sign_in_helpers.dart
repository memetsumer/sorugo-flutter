import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/sign_in_methods.dart';
import '../../utils/constants.dart';

class SignInSocial {
  static Widget buildOnlyGoogleSignIn(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(300, 50),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultPadding),
        ),
      ),
      onPressed: () async {
        await GoogleSignInProvider().googleLogin();
      },
      child: Row(
        children: [
          const SizedBox(width: defaultPadding / 2),
          const FaIcon(
            FontAwesomeIcons.google,
            color: Colors.black,
          ),
          const Spacer(),
          Text(
            "Google ile devam et",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black, fontSize: 19),
          ),
          const Spacer()
        ],
      ),
    );
  }

  static Widget buildOnlyAppleSignIn(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 50),
          backgroundColor: Colors.white,
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultPadding),
          ),
        ),
        onPressed: () async {
          await AppleSignInProvider().signInWithApple();
        },
        child: Row(
          children: [
            const SizedBox(
              width: defaultPadding / 2,
            ),
            const FaIcon(
              FontAwesomeIcons.apple,
              color: Colors.black,
              size: 30,
            ),
            const Spacer(),
            Text(
              "Apple ile devam et",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black, fontSize: 19),
            ),
            const Spacer()
          ],
        ));
  }
}
