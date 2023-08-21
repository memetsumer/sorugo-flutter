import 'package:flutter/material.dart';
import 'package:flutter_yks_app/models/app_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '/utils/constants.dart';
import '../../models/adapters/exam/exam_adapter.dart';
import '/screens/first_time_onboarding/first_time_onboarding_screen.dart';
import 'layout.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Exam>>(
      valueListenable: Hive.box<Exam>(dbExam).listenable(),
      builder: (context, box, widget) {
        return FutureBuilder(
          future: Future.delayed(Duration(
              milliseconds: context.watch<AppProvider>().getWait ? 1000 : 0)),
          builder: (context, snapshot) {
            Exam? exam =
                box.get(examBox, defaultValue: Exam(name: "", code: ""));
            String? code = exam?.code;

            if (context.watch<AppProvider>().getWait &&
                snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget();
            }

            if (exam == null || code == null) {
              return const LoadingWidget();
            }

            if (code == "") {
              return const FirstTimeOnboardingScreen();
            }
            return const Layout();
          },
        );
      },
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgPath),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
