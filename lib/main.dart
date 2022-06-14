import 'package:assets_audio_player/assets_audio_player.dart' as assetply;
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radiosurabhi/resources/api/api_base_helper.dart';
import 'package:radiosurabhi/ui/route_generator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:upgrader/upgrader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/*void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    var dataResponse = await ApiBaseHelper().get('im/v1/news');

    var dataResponseList = json.decode(dataResponse)['data'];

    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      dataResponseList[0]['short_description'],
      htmlFormatBigText: true,
      contentTitle: dataResponseList[0]['name'],
      htmlFormatContentTitle: true,
      htmlFormatSummaryText: true,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            styleInformation: bigTextStyleInformation,
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false);
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, dataResponseList[0]['name'],
        dataResponseList[0]['short_description'], platformChannelSpecifics,
        payload: '');

    return Future.value(true);
  });
}*/
Future<void> _messageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  HttpOverrides.global = MyHttpOverrides();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String initialRoute = '/';

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  /*final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    initialRoute = '/newspage';
  }*/
  /* await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: IOSInitializationSettings(),
          macOS: MacOSInitializationSettings()),
      onSelectNotification: (String? payload) => selectNotification(payload));*/
  //Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  /*Workmanager().registerPeriodicTask("5", 'simplePeriodicTask',
      existingWorkPolicy: ExistingWorkPolicy.replace,
      initialDelay: const Duration(seconds: 0),
      frequency: const Duration(hours: 23),
      constraints: Constraints(
        networkType: NetworkType.not_required,
      ));*/
  runApp(MyApp(
    initialRoute: initialRoute,
  ));
  /*SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(
          initialRoute: initialRoute,
        ), // Wrap your app
      ),
    );
  });*/
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.initialRoute = '/'}) : super(key: key);

  final String initialRoute;
  static bool isshowflash = true;
  static assetply.AssetsAudioPlayer audioPlayer = assetply.AssetsAudioPlayer();
  static ValueNotifier<assetply.PlayerState> playerstate =
      ValueNotifier<assetply.PlayerState>(assetply.PlayerState.pause);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  String url = 'https://radiosurabhi.streamguys1.com/live1';
  late FirebaseMessaging messaging;
  void setupPlaylist() async {
    MyApp.audioPlayer.open(assetply.Audio.liveStream(url),
        showNotification: true,
        playInBackground: assetply.PlayInBackground.enabled,
        audioFocusStrategy: assetply.AudioFocusStrategy.request(
            resumeAfterInterruption: true, resumeOthersPlayersAfterDone: true),
        //forceOpen: true,
        notificationSettings: const assetply.NotificationSettings(
          seekBarEnabled: false,
          stopEnabled: true,
          prevEnabled: false,
          nextEnabled: false,
          playPauseEnabled: true,
        ),
        autoStart: false);
  }

  checkSplashScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
  }

  @override
  void initState() {
    super.initState();
    checkSplashScreen();
    setupPlaylist();

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin.initialize(
          const InitializationSettings(
              android: AndroidInitializationSettings('@mipmap/ic_notii'),
              iOS: IOSInitializationSettings(),
              macOS: MacOSInitializationSettings()),
          onSelectNotification: (String? payload) =>
              selectNotification(payload));

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          const AndroidNotificationDetails(
              'your channel id', 'your channel name',
              importance: Importance.max,
              priority: Priority.high,
              showWhen: false);
      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(0, event.notification!.title,
          event.notification!.body, platformChannelSpecifics,
          payload: null);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      Navigator.pushNamed(context, '/newspage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Radio Surabhi',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MyApp.isshowflash ? widget.initialRoute : '/homepage',
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

Future selectNotification(String? payload) async {
  await NavigationService.navigateTo("/newspage");
}
