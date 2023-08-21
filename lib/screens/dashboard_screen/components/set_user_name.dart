import 'package:flutter/material.dart';
import '/utils/snackbar_message.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../models/theme_provider.dart';
import '../../../utils/constants.dart';

class SetUserNameWidget extends StatefulWidget {
  const SetUserNameWidget({Key? key}) : super(key: key);

  @override
  State<SetUserNameWidget> createState() => _SetUserNameWidgetState();
}

class _SetUserNameWidgetState extends State<SetUserNameWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool isButtonActive = true;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Kullanıcı Adını Değiştir",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
              maxLength: 12,
              validator: (value) =>
                  value!.isEmpty ? "Lütfen geçerli bir değer giriniz." : null,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(right: 16, left: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultPadding),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Yeni Kullanıcı Adın",
                counterText: '',
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: defaultPadding),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    defaultPadding,
                  ),
                ),
                minimumSize: const Size(300, 50),
                maximumSize: const Size(500, 100),
              ),
              onPressed: isButtonActive
                  ? () async {
                      setState(() {
                        isButtonActive = false;
                      });

                      if (_formKey.currentState!.validate()) {
                        try {
                          await context
                              .read<ThemeProvider>()
                              .updateUsername(_nameController.text.trim());
                          SnackbarMessage.showSnackbar(
                              "Kullanıcı Adın Başarıyla Değiştirildi!",
                              Colors.greenAccent);
                          if (!mounted) return;
                          Navigator.pop(context);
                        } catch (e) {
                          SnackbarMessage.showSnackbar(
                              "Kullanıcı Adı Değiştirilirken Bir Hata Oluştu.",
                              Colors.redAccent);
                        }
                      } else {
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            isButtonActive = true;
                          });
                        });
                        SnackbarMessage.showSnackbar(
                            "Lütfen Geçerli bir değer giriniz.",
                            Colors.redAccent);
                      }
                    }
                  : () {},
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
    );
  }
}
