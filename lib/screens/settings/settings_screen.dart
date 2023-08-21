import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/screens/settings/notifications_screen.dart';
import 'package:flutter_yks_app/screens/settings/purchases_screen.dart';

import '../../utils/account/logout.dart';
import '/models/theme_provider.dart';
import '/screens/settings/profile_pic.dart';
import '/screens/settings/my_account_screen.dart';
import '/screens/settings/settings_list_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: defaultPadding * 4,
              ),
              const Center(
                child: ProfilePicWidget(edit: false),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              Text(
                context.watch<ThemeProvider>().getUserName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade100,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Text(
                FirebaseAuth.instance.currentUser!.email!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade100,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SettingsListTile(
                title: "Hesabım",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyAccountScreen(),
                      ));
                },
                faIcon: const FaIcon(FontAwesomeIcons.user),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SettingsListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PurchasesScreen(),
                      ));
                },
                title: 'Satın Almalarım',
                faIcon: const FaIcon(FontAwesomeIcons.moneyBill1),
              ),
              const SizedBox(
                height: defaultPadding,
              ),
              SettingsListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotificationsScreen(),
                      ));
                },
                title: "Bildirimler",
                faIcon: const FaIcon(FontAwesomeIcons.bell),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              SettingsListTile(
                title: 'Çıkış Yap',
                faIcon: const FaIcon(
                  FontAwesomeIcons.arrowRightFromBracket,
                  color: Colors.redAccent,
                ),
                onTap: () async {
                  await showLogOutDialog(context);
                },
              ),
              const SizedBox(
                height: defaultPadding * 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
