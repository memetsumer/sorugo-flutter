import 'package:animations/animations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yks_app/utils/premium_function.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';

import '/models/sorular/soru_manager.dart';
import '../../network/soru/soru_item_dao.dart';
import '../../network/user/user_dao.dart';
import '../components/cached_img.dart';
import 'components/cozum_bulunamadi.dart';
import 'components/cozum_var.dart';
import 'components/flip_card.dart';
import 'components/soru.dart';
import '/utils/constants.dart';

class SoruDetailScreen extends StatefulWidget {
  final String urlSoru;
  final bool hasCozum;
  final String soruId;
  final Map<String, dynamic> data;

  const SoruDetailScreen(
      {Key? key,
      required this.urlSoru,
      required this.hasCozum,
      required this.soruId,
      required this.data})
      : super(key: key);

  @override
  State<SoruDetailScreen> createState() => _SoruDetailScreenState();
}

class _SoruDetailScreenState extends State<SoruDetailScreen> {
  bool showRepeatPicker = false;

  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'SoruDetailScreen',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color;

    switch (widget.data["importance"]) {
      case 'Düşük':
        color = Colors.greenAccent;
        break;
      case 'Orta':
        color = Colors.amberAccent;
        break;
      case 'Yüksek':
        color = Colors.redAccent;
        break;
      default:
        color = Colors.tealAccent;
    }
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        context.read<SoruManager>().setUpdatedNote("");
        context.read<SoruManager>().setRepeatNotification(0);
        return true;
      },
      child: Scaffold(
        floatingActionButton: !widget.hasCozum
            ? CozumBulunamadi(
                id: widget.data["id"],
                cozum: widget.hasCozum,
                isFab: true,
                isCozumUzerinde: widget.data['isCozumUzerinde'])
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                _showWarning(context);
              },
              icon: const Icon(
                Icons.delete,
                size: 30.0,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: defaultPadding * 2,
              ),
              Center(
                child: SizedBox(
                    height: size.height * 0.8,
                    child: MyImageCard(
                      data: widget.data,
                      hasCozum: widget.hasCozum,
                      urlSoru: widget.urlSoru,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.data['ders'] != "Geometri" &&
                                widget.data["ders"] != "Edebiyat")
                              Text(
                                (widget.data['konuKind'] as String)
                                    .toUpperCase(),
                              ),
                            Text(
                              widget.data["ders"],
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                color,
                                color.withOpacity(0.8),
                              ]),
                              borderRadius:
                                  BorderRadius.circular(defaultPadding)),
                          child: Container(
                            color: Colors.black12,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: defaultPadding,
                                vertical: defaultPadding / 2,
                              ),
                              child: Text(
                                widget.data['importance'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      widget.data["konu"],
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Consumer<SoruManager>(
                      builder: (_, soruManager, __) {
                        return AnimatedCrossFade(
                          crossFadeState: (soruManager.updatedNote == "" &&
                                  widget.data["extraNote"] == "")
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: const Duration(milliseconds: 500),
                          firstChild: Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                onPressed: () => premiumFunction(
                                    context, mounted, () => setNote(context)),
                                child: Text(
                                  "Not Ekle",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.blueAccent),
                                ),
                              ),
                            ],
                          ),
                          secondChild: Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            decoration: const BoxDecoration(
                              color: darkBackgroundColorSecondary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(defaultPadding),
                              ),
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Not",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                  ),
                                ),
                                Builder(builder: (context) {
                                  String updatedNote =
                                      context.watch<SoruManager>().updatedNote;

                                  return Text(
                                    updatedNote == ""
                                        ? widget.data['extraNote']
                                        : updatedNote,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                        ),
                                  );
                                }),
                                Row(
                                  children: [
                                    const Spacer(),
                                    TextButton(
                                        onPressed: () => premiumFunction(
                                            context,
                                            mounted,
                                            () => setNote(context)),
                                        child: Text(
                                          "Düzenle",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: Colors.blueAccent,
                                              ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: defaultPadding * 1.5,
                    ),
                    const Center(
                      child: Text("Kaydedildi"),
                    ),
                    Center(
                      child: Text(
                        "${DateTime.parse(widget.data["date"].toString()).day.toString()}/${DateTime.parse(widget.data["date"].toString()).month.toString()}/${DateTime.parse(widget.data["date"].toString()).year.toString()}",
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> setNote(context) async {
    showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 300),
      ),
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: darkBackgroundColorSecondary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24))),
        title: const Text("Not Ekle"),
        content: TextFormField(
          maxLength: 200,
          maxLines: 5,
          onChanged: (value) {
            context.read<SoruManager>().setExtraNote(value);
            context.read<SoruManager>().setUpdatedNote(value);
          },
          validator: (value) {
            if (value!.trim().isEmpty) {
              return "Alan Boş bırakılamaz";
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: "Notunuzu buraya yazın", counterText: ""),
        ),
        actions: [
          TextButton(
            child: const Text(
              "Tamam",
              style: TextStyle(color: Colors.blueAccent),
            ),
            onPressed: () async {
              await SoruDao().updateNote(widget.data["id"],
                  context.read<SoruManager>().extraNote.trim());
              if (!mounted) return;
              context.read<SoruManager>().setExtraNote("");
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }

  Future<bool?> _showWarning(BuildContext context) async => showModal<bool>(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: darkBackgroundColorSecondary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            title: Text("Bu soruyu silmek istediğine emin misin?",
                style: Theme.of(context).textTheme.bodyMedium),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "İptal Et",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.blueAccent),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    await EasyLoading.showInfo('Siliniyor...',
                        dismissOnTap: true);

                    await SoruDao().deleteSoru(widget.data["id"]);
                    await UserDao().decrementSavedSoru();

                    if (widget.hasCozum == true) {
                      SoruDao().deleteCozumImage(widget.data["id"]);
                    }

                    await EasyLoading.dismiss();
                    if (!mounted) return;
                    Navigator.pop(context, false);
                    Navigator.pop(context);
                  },
                  child: Text("Sil",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.red))),
            ],
          ));
}

class MyImageCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool hasCozum;
  final String urlSoru;

  const MyImageCard({
    Key? key,
    required this.data,
    required this.hasCozum,
    required this.urlSoru,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final soruImg = CachedImg(
      imgUrl: urlSoru,
    );
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(defaultPadding),
      child: FutureBuilder(
        future: getImages(data),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data != 'no-cozum'
                ? FlipCard(
                    front: Soru(
                      url: urlSoru,
                      child: soruImg,
                    ),
                    back: Cozum(
                      hasCozum: hasCozum,
                      data: snapshot.data as String,
                      img: CachedImg(imgUrl: snapshot.data as String),
                    ),
                  )
                : FlipCard(
                    front: Soru(
                      url: urlSoru,
                      child: soruImg,
                    ),
                    back: CozumBulunamadi(
                        id: data["id"],
                        cozum: hasCozum,
                        isFab: false,
                        isCozumUzerinde: data['isCozumUzerinde']),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<String?> getImages(data) async {
    return await data['hasCozum']
        ? SoruDao().getCozumImage(data["id"])
        : Future.value("no-cozum");
  }
}
