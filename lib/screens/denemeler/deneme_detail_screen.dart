import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:animations/animations.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../create_deneme/components/slider_deneme_time.dart';
import '/utils/constants.dart';
import '/network/network.dart';

//Deneme
class DenemeDetailScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final String title;
  const DenemeDetailScreen({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  State<DenemeDetailScreen> createState() => _DenemeDetailScreenState();
}

class _DenemeDetailScreenState extends State<DenemeDetailScreen> {
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'DenemeDetailScreen',
    );
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 1));

    if (widget.data["yanlis"] == 0) {
      HapticFeedback.heavyImpact();
      _controllerTopCenter.play();
    }

    super.initState();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color;

    switch (widget.data["importance"]) {
      case 'Kolay':
        color = Colors.greenAccent;
        break;
      case 'Orta':
        color = Colors.amberAccent;
        break;
      case 'Zor':
        color = Colors.redAccent;
        break;
      default:
        color = Colors.tealAccent;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 20,
              ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
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
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    Center(
                      child: FadeInDown(
                        duration: const Duration(milliseconds: 500),
                        child:
                            SliderDenemeTimeDetail(value: widget.data['sure']),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Doğru",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.greenAccent,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.greenAccent,
                                    blurRadius: 12,
                                  )
                                ],
                              ),
                            ),
                            Text("${widget.data['dogru']}",
                                style: const TextStyle(
                                  fontSize: 45,
                                  color: Colors.greenAccent,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.greenAccent,
                                      blurRadius: 12,
                                    )
                                  ],
                                )),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Yanlış",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.redAccent,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.redAccent,
                                      blurRadius: 12,
                                    )
                                  ],
                                )),
                            Text("${widget.data['yanlis']}",
                                style: const TextStyle(
                                  fontSize: 45,
                                  color: Colors.redAccent,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.redAccent,
                                      blurRadius: 12,
                                    )
                                  ],
                                )),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Net",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 12,
                                    )
                                  ],
                                )),
                            Text("${widget.data['net']}",
                                style: const TextStyle(
                                  fontSize: 45,
                                  color: Colors.white,
                                  shadows: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 12,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    if (widget.data["yanlis"] == 0)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: defaultPadding,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Hiç Yanlışın Yok, Bravoo! ",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                              ),
                            ),
                            const Text(
                              "🎉 💯",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: defaultPadding,
                      ),
                      child: Row(
                        children: [
                          Text(
                            widget.data["title"],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
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
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    ...(widget.data["netler"] as List).map(
                      (e) => DersNetStatus(
                        name: e["denemeName"],
                        dogru: e["netler"]["dogru"],
                        yanlis: e["netler"]["yanlis"],
                        total: e["netler"]["total"],
                      ),
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
                      height: defaultPadding,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirection: pi / 2,

              numberOfParticles: 50, // a lot of particles at once
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showWarning(BuildContext context) async => showModal<bool>(
        context: context,
        configuration: const FadeScaleTransitionConfiguration(
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 300),
        ),
        builder: (context) => AlertDialog(
          backgroundColor: darkBackgroundColorSecondary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24))),
          title: Text("Bu denemeyi silmek istediğine emin misin?",
              style: Theme.of(context).textTheme.bodyLarge),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                "İptal Et",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.blueAccent),
              ),
            ),
            TextButton(
              onPressed: () async {
                await EasyLoading.showInfo('Siliniyor...', dismissOnTap: true);

                DenemeDao().deleteDeneme(widget.data["id"]);

                await EasyLoading.dismiss();
                if (!mounted) return;
                Navigator.pop(context, true);
                Navigator.pop(context);
              },
              child: Text(
                "Sil",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.red),
              ),
            ),
          ],
        ),
      );
}

class DersNetStatus extends StatelessWidget {
  final String name;
  final int total;
  final int dogru;
  final int yanlis;
  const DersNetStatus({
    Key? key,
    required this.name,
    required this.total,
    required this.dogru,
    required this.yanlis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            NetProgressIndicator(
              value: dogru,
              total: total,
              colors: const [
                Colors.green,
                Colors.greenAccent,
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            NetProgressIndicator(value: yanlis, total: total, colors: const [
              Colors.red,
              Colors.redAccent,
            ])
          ],
        ));
  }
}

class NetProgressIndicator extends StatelessWidget {
  final int value;
  final int total;
  final List<Color> colors;
  const NetProgressIndicator({
    Key? key,
    required this.value,
    required this.total,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      // width: MediaQuery.of(context).size.width - defaultPadding * 6,
      // width: MediaQuery.of(context).size.width - defaultPadding * 6,
      animation: true,
      animationDuration: 1000,
      backgroundColor: Colors.transparent,
      lineHeight: 10.0,
      trailing: Text(
        value.toString(),
        style: GoogleFonts.poppins(),
      ),
      percent: value == 0 ? 0.04 : value / total,
      barRadius: const Radius.circular(defaultPadding),
      linearGradient: LinearGradient(colors: colors),
    );
  }
}
