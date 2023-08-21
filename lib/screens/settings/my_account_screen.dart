import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/account/delete_account.dart';

import '/screens/settings/settings_list_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/adapters/exam/exam_adapter.dart' as hive_exam;

import '../../models/theme_provider.dart';
import '../../utils/constants.dart';
import '../dashboard_screen/components/set_user_name.dart';
import 'change_settings_screen.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Hesabım',
        ),
      ),
      body: Center(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: defaultPadding * 4,
                  ),
                  SettingsListTile(
                    onTap: () {},
                    title: 'Hazırlandığım Sınav',
                    trailing: Wrap(
                      children: [
                        ValueListenableBuilder(
                            valueListenable:
                                Hive.box<hive_exam.Exam>(dbExam).listenable(),
                            builder:
                                ((context, Box<hive_exam.Exam> box, child) {
                              hive_exam.Exam element = box.values.first;
                              String exam;

                              if (element.code == 'sozel') {
                                exam = 'YKS Sözel';
                              } else if (element.code == 'sayisal') {
                                exam = 'YKS Sayısal';
                              } else {
                                exam = 'YKS Eşit Ağırlık';
                              }
                              return Text(exam);
                            }))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  SettingsListTile(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangeSettingsScreen(
                            child: SetUserNameWidget(),
                          ),
                        ),
                      );
                    },
                    title: 'Kullanıcı Adım',
                    trailing: Wrap(
                      children: [
                        Text(
                          context.watch<ThemeProvider>().getUserName,
                        ),
                        const SizedBox(
                          width: defaultPadding,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.penToSquare,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  SettingsListTile(
                    onTap: () {},
                    title: 'Üyelik Tarihi',
                    trailing: Text(
                      FirebaseAuth.instance.currentUser!.metadata.creationTime!
                          .toIso8601String()
                          .substring(0, 10),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  SettingsListTile(
                    title: 'Hesabı Sil...',
                    onTap: () async {
                      await deleteAccountDialog(context);
                    },
                    faIcon: const FaIcon(
                      FontAwesomeIcons.trashCan,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
