import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yks_app/screens/settings/settings_list_tile.dart';
import 'package:flutter_yks_app/utils/constants.dart';
import 'package:flutter_yks_app/utils/snackbar_message.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../iap/entitlement.dart';
import '../../iap/iap_manager.dart';
import '../dashboard_screen/components/premium_banner.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Satın Almalarım'),
        elevation: 0,
        backgroundColor: darkBackgroundColor,
      ),
      body: FutureBuilder(
        future: Purchases.getCustomerInfo(),
        builder: (context, AsyncSnapshot<CustomerInfo> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final CustomerInfo? purchaserInfo = snapshot.data;

              final entitlements =
                  purchaserInfo!.entitlements.active.values.toList();

              Entitlement entitlement = entitlements.isEmpty
                  ? Entitlement.free
                  : entitlements.first.productIdentifier == "SoruGO_23_1m_1w_f"
                      ? Entitlement.monthly
                      : Entitlement.threeMonthly;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: entitlement == Entitlement.monthly
                    ? Platform.isIOS
                        ? MonthlyIOSSettings(
                            purchaserInfo: purchaserInfo,
                          )
                        : MonthlyAndroidSettings(
                            purchaserInfo: purchaserInfo,
                          )
                    : entitlement == Entitlement.threeMonthly
                        ? Platform.isIOS
                            ? MonthlyIOSSettings(
                                purchaserInfo: purchaserInfo,
                              )
                            : MonthlyAndroidSettings(
                                purchaserInfo: purchaserInfo,
                              )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Şuan Ücretsiz Olarak Uygulamayı Kullanıyorsun.',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const SizedBox(height: defaultPadding),
                              TextButton(
                                child: Text(
                                  'Satın Almayı Geri Yükle',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.blueAccent),
                                ),
                                onPressed: () async {
                                  try {
                                    Purchases.restorePurchases().then((value) =>
                                        value.activeSubscriptions.isEmpty
                                            ? SnackbarMessage.showSnackbar(
                                                'Daha Önceden Satın Alma Bulunamadı!',
                                                Colors.redAccent)
                                            : SnackbarMessage.showSnackbar(
                                                'Satın Alma Başarıyla Yüklendi!',
                                                Colors.greenAccent));
                                  } on PlatformException catch (e) {
                                    SnackbarMessage.showSnackbar(
                                        e.message, Colors.redAccent);
                                  }
                                },
                              ),
                            ],
                          ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class MonthlyIOSSettings extends StatelessWidget {
  final CustomerInfo purchaserInfo;
  const MonthlyIOSSettings({
    Key? key,
    required this.purchaserInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SettingsListTile(
          title: "Üyelik Durumu:",
          trailing: Text(
            purchaserInfo.entitlements.active.values.first.identifier,
          ),
          onTap: () {},
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Sonlanma Tarihi",
          trailing: Text(
            DateTime.parse(purchaserInfo
                        .entitlements.active.values.first.expirationDate ??
                    "-")
                .toIso8601String()
                .substring(0, 10),
          ),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "İlk Satın Alma Tarihi",
          trailing: Text(
            DateTime.parse(purchaserInfo
                    .entitlements.active.values.first.originalPurchaseDate)
                .toIso8601String()
                .substring(0, 10),
          ),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Son Yenileme Tarihi",
          trailing: Text(
            DateTime.parse(purchaserInfo
                    .entitlements.active.values.first.latestPurchaseDate)
                .toIso8601String()
                .substring(0, 10),
          ),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Abonelikten Çıkış Tarihi",
          trailing: Text(purchaserInfo
                      .entitlements.active.values.first.unsubscribeDetectedAt !=
                  null
              ? DateTime.parse(purchaserInfo
                      .entitlements.active.values.first.unsubscribeDetectedAt!)
                  .toIso8601String()
                  .substring(0, 10)
              : "-"),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Ödemenin Alınamadığı Tarih",
          trailing: Text(purchaserInfo.entitlements.active.values.first
                      .billingIssueDetectedAt !=
                  null
              ? DateTime.parse(purchaserInfo
                      .entitlements.active.values.first.billingIssueDetectedAt!)
                  .toIso8601String()
                  .substring(0, 10)
              : "-"),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Gelecek Sefer Yenilenecek",
          trailing: Text(
            purchaserInfo.entitlements.active.values.first.willRenew
                ? "Evet"
                : "Hayır",
          ),
        ),
        const SizedBox(height: defaultPadding * 3),
        if (context.watch<IAPManager>().getEntitlement != Entitlement.free)
          const PremiumBanner(
            padding: false,
            cardMargin: false,
            message: "Üyeliğini Değiştir",
            buttonMessage: "Değiştir",
          ),
      ],
    );
  }
}

class MonthlyAndroidSettings extends StatelessWidget {
  final CustomerInfo purchaserInfo;
  const MonthlyAndroidSettings({
    Key? key,
    required this.purchaserInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SettingsListTile(
          title: "Üyelik Durumu:",
          trailing: Text(
            purchaserInfo.entitlements.active.values.first.identifier,
          ),
          onTap: () {},
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Sonlanma Tarihi",
          trailing: Text(
            DateTime.parse(purchaserInfo
                        .entitlements.active.values.first.expirationDate ??
                    "-")
                .toIso8601String()
                .substring(0, 10),
          ),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "İlk Satın Alma Tarihi",
          trailing: Text(
            DateTime.parse(purchaserInfo
                    .entitlements.active.values.first.originalPurchaseDate)
                .toIso8601String()
                .substring(0, 10),
          ),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Son Yenileme Tarihi",
          trailing: Text(
            DateTime.parse(purchaserInfo
                    .entitlements.active.values.first.latestPurchaseDate)
                .toIso8601String()
                .substring(0, 10),
          ),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Abonelikten Çıkış Tarihi",
          trailing: Text(purchaserInfo
                      .entitlements.active.values.first.unsubscribeDetectedAt !=
                  null
              ? DateTime.parse(purchaserInfo
                      .entitlements.active.values.first.unsubscribeDetectedAt!)
                  .toIso8601String()
                  .substring(0, 10)
              : "-"),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Ödemenin Alınamadığı Tarih",
          trailing: Text(purchaserInfo.entitlements.active.values.first
                      .billingIssueDetectedAt !=
                  null
              ? DateTime.parse(purchaserInfo
                      .entitlements.active.values.first.billingIssueDetectedAt!)
                  .toIso8601String()
                  .substring(0, 10)
              : "-"),
        ),
        const SizedBox(height: defaultPadding),
        SettingsListTile(
          onTap: () {},
          title: "Gelecek Ay Yenilenecek",
          trailing: Text(
            purchaserInfo.entitlements.active.values.first.willRenew
                ? "Evet"
                : "Hayır",
          ),
        ),
      ],
    );
  }
}
