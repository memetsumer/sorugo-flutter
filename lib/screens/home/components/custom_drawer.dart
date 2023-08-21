import 'package:flutter/material.dart';
import '../../settings/about_screen.dart';
import '../../settings/faq_screen.dart';
import '/screens/settings/settings_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../models/theme_provider.dart';
import '../../../utils/constants.dart';
import '../../settings/profile_pic.dart';
import '/iap/entitlement.dart';
import '/iap/iap_manager.dart';
import '/screens/dashboard_screen/components/quiz_banner.dart';
import '/screens/settings/settings_list_tile.dart';
import '../../dashboard_screen/components/premium_banner.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
        child: ListView(
          children: [
            const Center(
              child: ProfilePicWidget(edit: false),
            ),
            Center(
              child: Text(
                context.watch<ThemeProvider>().getUserName,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade100,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            const SizedBox(height: defaultPadding),
            SettingsListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const SettingsScreen();
                    },
                  ));
                },
                faIcon: const FaIcon(
                  FontAwesomeIcons.gear,
                  color: Colors.white,
                ),
                title: "Ayarlar"),
            const SizedBox(
              height: defaultPadding,
            ),
            SettingsListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FAQScreen();
                }));
              },
              title: 'Sıkça Sorulan Sorular',
              faIcon: const FaIcon(FontAwesomeIcons.question),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            SettingsListTile(
              title: 'SoruGO Hakkında',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const AboutScreen(),
                  ),
                );
              },
              faIcon: const FaIcon(FontAwesomeIcons.s),
            ),
            if (context.watch<IAPManager>().getEntitlement ==
                Entitlement.free) ...[
              const SizedBox(height: defaultPadding),
              const PremiumBanner(
                padding: false,
                cardMargin: false,
              ),
            ],
            const SizedBox(height: defaultPadding),
            const QuizBanner(),
          ],
        ),
      ),
    );
  }
}
