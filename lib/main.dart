import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'iap/purchase_api.dart';
import '/screens/home/home.dart';

import 'utils/constants.dart';
import 'utils/snackbar_message.dart';
import 'utils/sorugo_theme.dart';

import '/iap/iap_manager.dart';
import 'models/models.dart';
import 'models/adapters/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await PurchaseApi.initPlatformState();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Hive initialization
  await Hive.initFlutter();
  // First, register adapters
  Hive.registerAdapter(DersAdapter());
  Hive.registerAdapter(TaramaAdapter());
  Hive.registerAdapter(ExamAdapter());
  Hive.registerAdapter(DenemeAdapter());
  Hive.registerAdapter(DenemeStatAdapter());
  // Then, open boxes
  await Hive.openBox(dbSettings);
  await Hive.openBox(dbOnlyDersNames);
  await Hive.openLazyBox<Ders>(dbDersler);
  await Hive.openBox<Tarama>(dbTaramalar);
  await Hive.openBox<Exam>(dbExam);
  await Hive.openBox<Deneme>(dbDenemeler);
  await Hive.openBox<DenemeStat>(dbDenemelerStat);

  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SorularManager()),
        ChangeNotifierProvider(create: (context) => SoruManager()),
        ChangeNotifierProvider(create: (context) => DenemeManager()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => IAPManager()),
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => FirstTimeProvider()),
      ],
      child: MaterialApp(
        theme: SorugoAppTheme.theme,
        title: appTitle,
        debugShowCheckedModeBanner: false,
        home: const Home(),
        builder: EasyLoading.init(),
        scaffoldMessengerKey: SnackbarMessage.messengerKey,
      ),
    );
  }
}
