import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/models/adapters/exam/exam_adapter.dart';
import 'package:flutter_yks_app/utils/snackbar_message.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '/screens/settings/settings_list_tile.dart';

import '../../utils/constants.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
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
          'Bildirimler',
        ),
      ),
      body: Center(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ValueListenableBuilder(
              valueListenable: Hive.box(dbSettings).listenable(),
              builder: ((context, Box box, child) {
                return SingleChildScrollView(
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
                        title: 'Sana Özel Bildirimler',
                        trailing: Switch.adaptive(
                            value: box.get(mainNotificationTopic),
                            onChanged: (value) async {
                              try {
                                if (value) {
                                  await FirebaseMessaging.instance
                                      .subscribeToTopic(mainNotificationTopic);
                                  box.put(mainNotificationTopic, true);
                                } else {
                                  await FirebaseMessaging.instance
                                      .unsubscribeFromTopic(
                                          mainNotificationTopic);
                                  box.put(mainNotificationTopic, false);
                                }
                              } catch (e) {
                                SnackbarMessage.showSnackbar(
                                    "Bir Hata Oluştu", Colors.redAccent);
                              }
                            }),
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      ValueListenableBuilder(
                          valueListenable: Hive.box<Exam>(dbExam).listenable(),
                          builder: ((context, Box<Exam> examBox, child) {
                            Exam exam = examBox.values.toList().first;
                            return SettingsListTile(
                              onTap: () {},
                              title: 'Sınava Yönelik Bildirimler',
                              trailing: Switch.adaptive(
                                  value: box.get(examNotificationTopic),
                                  onChanged: (value) async {
                                    try {
                                      if (value) {
                                        await FirebaseMessaging.instance
                                            .subscribeToTopic(exam.code);
                                        box.put(examNotificationTopic, true);
                                      } else {
                                        await FirebaseMessaging.instance
                                            .unsubscribeFromTopic(exam.code);
                                        box.put(examNotificationTopic, false);
                                      }
                                    } catch (e) {
                                      SnackbarMessage.showSnackbar(
                                          "Bir Hata Oluştu", Colors.redAccent);
                                    }
                                  }),
                            );
                          })),
                      const SizedBox(
                        height: defaultPadding * 2,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
