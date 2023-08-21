import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/models/first_time_provider.dart';

import '/utils/snackbar_message.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants.dart';
import '../../models/theme_provider.dart';

class UserNameForm extends StatefulWidget {
  const UserNameForm({Key? key}) : super(key: key);

  @override
  State<UserNameForm> createState() => _UserNameFormState();
}

class _UserNameFormState extends State<UserNameForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

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
              context.read<FirstTimeProvider>().goTerms();
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
                  child: Container(
                    width: size.width * 0.8,
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Kullanıcı Adınızı Oluşturun",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Colors.white,
                                      fontSize: 21,
                                    ),
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          TextFormField(
                            controller: _nameController,
                            textInputAction: TextInputAction.done,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            validator: (value) => value!.isEmpty
                                ? "Lütfen geçerli bir kullanıcı adı girin"
                                : null,
                            maxLength: 12,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(
                                  right: defaultPadding, left: defaultPadding),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(defaultPadding),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              hintText: "Kullanıcı Adın",
                              counterText: '',
                              fillColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(defaultPadding)),
                              minimumSize: const Size(200, 50),
                              maximumSize: const Size(500, 100),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();

                              if (_formKey.currentState!.validate()) {
                                try {
                                  context.read<ThemeProvider>().updateUsername(
                                      _nameController.text.trim());

                                  context
                                      .read<FirstTimeProvider>()
                                      .goChooseExam();
                                } catch (e) {
                                  SnackbarMessage.showSnackbar(
                                      "Bir Hata Oluştu.", Colors.redAccent);
                                }
                              } else {
                                SnackbarMessage.showSnackbar(
                                    "Lütfen geçerli bir değer girin.",
                                    Colors.redAccent);
                              }
                            },
                            child: Text("Kaydet",
                                style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}
