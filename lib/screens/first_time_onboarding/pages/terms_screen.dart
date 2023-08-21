import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/first_time_provider.dart';
import '../../../utils/constants.dart';
import '../../../utils/launch_url.dart';
import '../../../utils/snackbar_message.dart';
import 'package:flutter_yks_app/utils/account/logout.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            logOutTerms(context);
          },
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInDown(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Container(
                  // margin: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultPadding),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color.fromARGB(255, 51, 51, 51)
                              .withOpacity(0.1),
                          const Color.fromARGB(255, 115, 115, 115)
                              .withOpacity(0.2),
                        ]),
                    border: Border.all(
                      color: Colors.white24,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(defaultPadding),
                  child: const TermsWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TermsWidget extends StatefulWidget {
  const TermsWidget({Key? key}) : super(key: key);

  @override
  State<TermsWidget> createState() => _TermsWidgetState();
}

class _TermsWidgetState extends State<TermsWidget> {
  bool isAcceptedTerms = false;
  bool isAcceptedPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Kullanım Şartları",
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchURL("https://sorugo.app/user-agreement");
                      },
                  ),
                  const TextSpan(
                    text: " 'nı kabul ediyorum.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Checkbox(
              value: isAcceptedTerms,
              onChanged: (value) {
                setState(() {
                  isAcceptedTerms = value!;
                });
              },
            ),
          ],
        ),
        Row(
          children: [
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Gizlilik Sözleşmesi",
                    style: const TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchURL("https://sorugo.app/privacy-policy");
                      },
                  ),
                  const TextSpan(
                    text: " 'ni kabul ediyorum.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Checkbox(
              value: isAcceptedPrivacy,
              onChanged: (value) {
                setState(() {
                  isAcceptedPrivacy = value!;
                });
              },
            ),
          ],
        ),
        const SizedBox(
          height: defaultPadding * 2,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: (isAcceptedTerms && isAcceptedPrivacy)
                ? Colors.white
                : Colors.white38,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultPadding),
            ),
            minimumSize: const Size(200, 50),
            maximumSize: const Size(500, 100),
          ),
          onPressed: () async {
            if (isAcceptedTerms && isAcceptedPrivacy) {
              context.read<FirstTimeProvider>().goUserNameForm();
            } else {
              SnackbarMessage.showSnackbar(
                  "Devam etmek için lütfen şartları kabul edin.",
                  Colors.redAccent);
            }
          },
          child: Text(
            "İlerle",
            style: GoogleFonts.poppins(
                fontSize: 19, fontWeight: FontWeight.w400, color: Colors.black),
          ),
        )
      ],
    );
  }
}
