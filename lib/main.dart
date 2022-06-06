import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';
import 'package:radiosurabhi/resources/api/api_base_helper.dart';
import 'package:radiosurabhi/ui/route_generator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:awesome_notifications/awesome_notifications.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void callbackDispatcher() {
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
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String initialRoute = '/';

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final NotificationAppLaunchDetails? notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    initialRoute = '/newspage';
  }
  await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: IOSInitializationSettings(),
          macOS: MacOSInitializationSettings()),
      onSelectNotification: (String? payload) => selectNotification(payload));
  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager().registerPeriodicTask("5", 'simplePeriodicTask',
      existingWorkPolicy: ExistingWorkPolicy.replace,
      initialDelay: const Duration(seconds: 0),
      frequency: const Duration(hours: 23),
      constraints: Constraints(
        networkType: NetworkType.not_required,
      ));
  runApp(MyApp(
    initialRoute: initialRoute,
  ));
  /*SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
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

  static AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  static ValueNotifier<PlayerState> playerstate =
      ValueNotifier<PlayerState>(PlayerState.pause);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  String url = 'https://radiosurabhi.streamguys1.com/live1';
  void setupPlaylist() async {
    MyApp.audioPlayer.open(Audio.liveStream(url),
        showNotification: false,
        playInBackground: PlayInBackground.enabled,
        audioFocusStrategy: AudioFocusStrategy.request(
            resumeAfterInterruption: true, resumeOthersPlayersAfterDone: true),
        //forceOpen: true,
        // notificationSettings: NotificationSettings(
        //     seekBarEnabled: false,
        //     stopEnabled: true,
        //     prevEnabled: false,
        //     nextEnabled: false,
        //     playPauseEnabled: true,
        //     customStopAction: (player) {
        //       print('erttert');
        //       MyApp.audioPlayer.stop();
        //     },
        //     // notificationSettings: NotificationSettings(
        //     //     nextEnabled: false,
        //     //     prevEnabled: false,
        //     //     playPauseEnabled: true,
        //     //     stopEnabled: true,
        //     //     customStopAction: (players) {
        //     //       print('2222222222');
        //     //     },
        //     customPlayPauseAction: (players) {
        //       print('---fddddfff');
        //       if (players.isPlaying.value) {
        //         MyApp.audioPlayer.stop();
        //       } else {
        //         MyApp.audioPlayer.play();
        //       }
        //     }),
        autoStart: false);
  }

  @override
  void initState() {
    super.initState();
    setupPlaylist();

    print('-ee---------ccccc');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Drawer Menu',
      debugShowCheckedModeBanner: false,
      navigatorObservers: <NavigatorObserver>[observer],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: widget.initialRoute,
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

Future selectNotification(String? payload) async {
  await NavigationService.navigateTo("/newspage");
}
