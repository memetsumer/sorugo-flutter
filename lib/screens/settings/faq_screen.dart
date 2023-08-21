import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/utils/constants.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'FAQScreen',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final List<FAQItem> items = [
    //   FAQItem(
    //     title: "Ücretsiz Olarak Ne Kadar Kullanabilirim?",
    //     body:
    //         "Uygulamaya ilk defa giriş yaptığınız andan itibaren 7 günlük ücretsiz kullanma hakkınız başlar.",
    //   ),
    //   FAQItem(
    //     title: "Ücretsiz Hesap ile Neler Yapabilirim?",
    //     body: "Uygulamanın tüm özelliklerini kullanabilirsiniz.",
    //   ),
    //   FAQItem(
    //     title: "Ücretsiz Hakkım Bitti, Şimdi ne Olacak?",
    //     body:
    //         "Ücretsiz süre içinde yaptığınız istatistikleri görmeye devam edebilirsiniz. Ancak uygulamanın diğer özelliklerini kullanamya devam etmek için abone olmanız gerekmektedir. Abone olduktan sonra uygulamayı kullanmaya aynı şekilde devam edebilirsiniz.",
    //   ),
    //   FAQItem(
    //     title: "Aboneliğimi Nasıl İptal Ederim?",
    //     body: Platform.isIOS
    //         ? "Ayarlar Uygulamasını Açıp, Adınız (En Üst Kısım) > Abonelikler' e gidip iptal edebilirsiniz."
    //         : "Google Play Uygulamasını Açıp, Profil > Ödemeler ve Abonelikler > Abonelikler' e gidip iptal edebilirsiniz.",
    //   ),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sıkça Sorulan Sorular'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future:
              FirebaseFirestore.instance.collection('faqs').doc('base').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data!.data();

              final List<FAQItem> items = [];

              data!["questions"].forEach((e) {
                items.add(
                    FAQItem(title: e["title"] ?? "", body: e["body"] ?? ""));
              });

              return SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  elevation: 0,
                  children: items
                      .map(
                        (e) => ExpansionPanelRadio(
                          canTapOnHeader: true,
                          backgroundColor: darkBackgroundColor,
                          headerBuilder: ((context, isExpanded) {
                            return ListTile(
                              title: Text(
                                e.title,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            );
                          }),
                          body: ListTile(
                            dense: true,
                            title: Text(e.body,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white.withOpacity(0.6),
                                    )),
                          ),
                          value: e.title,
                        ),
                      )
                      .toList(),
                ),
              );
            }

            return const CircularProgressIndicator();
          }),
    );
  }
}

class FAQItem {
  final String title;
  final String body;

  FAQItem({
    required this.title,
    required this.body,
  });
}
