import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_yks_app/models/theme_provider.dart';
import 'package:flutter_yks_app/screens/onboarding/mvp_offer_widget.dart';
import 'package:flutter_yks_app/utils/premium_function.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as mbs;
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../iap/iap_manager.dart';
import '../../models/app_provider.dart';
import '../../utils/snackbar_message.dart';
import '../create_deneme/create_deneme_screen.dart';
import '../create_soru/create_soru_screen.dart';
import 'components/custom_drawer.dart';
import '../dashboard_screen/dashboard_screen.dart';
import '../denemeler/denemeler_screen.dart';
import '../onboarding/welcome_widget.dart';
import '../sorular/sorular_screen.dart';
import '../stats_taramalar/stats_screen.dart';
import '/utils/constants.dart';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class Layout extends StatefulWidget {
  const Layout({
    Key? key,
  }) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedTab = 0;

  final iconList2 = [
    "assets/icons/home.svg",
    "assets/icons/clock.svg",
    "assets/icons/sorular.svg",
    "assets/icons/denemeler.svg",
  ];

  @override
  void initState() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging
        .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        )
        .then(
          (value) => FirebaseMessaging.onMessage.listen(
            (RemoteMessage message) {
              SnackbarMessage.showSnackbar(
                  "Message data: ${message.data},  ${message.notification ?? ''}",
                  Colors.limeAccent);
            },
          ),
        );

    // MVP offer için debug amaçlı
    // Hive.box(dbSettings).delete(dbMvpOfferShown);

    // RevenueCat init
    context.read<IAPManager>().init().then(
        (value) => Purchases.addCustomerInfoUpdateListener((purchaserInfo) {
              context.read<IAPManager>().updatePurchaseStatus();
            }));

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        bool isFirstTime = context.read<AppProvider>().getFirstTime;

        if (isFirstTime) {
          context.read<AppProvider>().setWait(false);
          Future.delayed(
            const Duration(seconds: 0),
            () => mbs.showMaterialModalBottomSheet(
              context: context,
              bounce: true,
              isDismissible: false,
              enableDrag: false,
              backgroundColor: Colors.transparent,
              builder: (context) => const WelcomeWidget(),
            ),
          );
        }

        context.read<IAPManager>().isMvpOfferValid(
          () {
            if (!isFirstTime) {
              mbs.showMaterialModalBottomSheet(
                context: context,
                bounce: true,
                isDismissible: false,
                enableDrag: false,
                backgroundColor: Colors.transparent,
                builder: (context) => const MVPOfferWidget(),
              );
            }
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        extendBody: true,
        key: themeProvider.getKey,
        endDrawer: const CustomDrawer(),
        drawerScrimColor: darkBackgroundColor,
        floatingActionButton: const LayoutFab(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: iconList2.length,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Colors.white : Colors.grey.shade400;
            return Center(
              child: SvgPicture.asset(
                iconList2[index],
                color: color,
                width: MediaQuery.of(context).size.height > 700
                    ? (isActive ? 35 : 22)
                    : (isActive ? 32 : 20),
              ),
            );
          },
          borderWidth: 2,
          borderColor: Colors.white24,
          blurEffect: true,
          notchMargin: defaultPadding / 2,
          safeAreaValues: const SafeAreaValues(bottom: false),
          height: MediaQuery.of(context).size.height > 700
              ? kBottomNavigationBarHeight + defaultPadding * 2
              : kBottomNavigationBarHeight + defaultPadding,
          splashRadius: 0,
          backgroundColor: darkBackgroundColorSecondary.withOpacity(0.1),
          activeIndex: _selectedTab,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          gapLocation: GapLocation.center,
          leftCornerRadius: defaultPadding * 3,
          rightCornerRadius: defaultPadding * 3,
          onTap: (index) => setState(() => _selectedTab = index),
        ),
        body: IndexedStack(index: _selectedTab, children: const [
          DashboardScreen(),
          StatsScreen(),
          SorularScreen(),
          DenemelerScreen(),
        ]),
      );
    });
  }
}

class LayoutFab extends StatefulWidget {
  const LayoutFab({Key? key}) : super(key: key);

  @override
  State<LayoutFab> createState() => _LayoutFabState();
}

class _LayoutFabState extends State<LayoutFab> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          premiumFunction(context, mounted, () => showHomeMenu(context)),
      elevation: 10,
      enableFeedback: true,
      highlightElevation: 20,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: 3),
              BoxShadow(
                offset: Offset(-1, -1),
                color: Color.fromARGB(255, 114, 51, 124),
                blurRadius: 10,
              ),
              BoxShadow(
                offset: Offset(1, 1),
                color: Color.fromARGB(255, 105, 3, 85),
                blurRadius: 10,
              ),
            ],
            border: Border.all(
              color: const Color.fromARGB(255, 114, 53, 124),
              width: 1,
            ),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 114, 53, 124),
                Color.fromARGB(255, 105, 3, 85),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            )),
        child: Center(
          child: SvgPicture.asset(
            "assets/icons/plus.svg",
            height: 36,
            color: Colors.grey.shade100,
          ),
        ),
      ),
    );
  }

  Future<dynamic> showHomeMenu(BuildContext context) {
    return mbs.showMaterialModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: darkBackgroundColorSecondary,
        context: context,
        builder: (context) => Wrap(
              children: [
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  title: const Text('Soru Kaydet'),
                  leading: SvgPicture.asset(
                    "assets/icons/camera.svg",
                    height: 30,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const CreateSoruScreen()));
                  },
                ),
                ListTile(
                  title: const Text('Deneme Ekle'),
                  leading: SvgPicture.asset(
                    "assets/icons/bookmark.svg",
                    height: 30,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateDenemeScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: defaultPadding * 5),
              ],
            ));
  }
}
