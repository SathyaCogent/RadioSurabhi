import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radiosurabhi/ui/widgets/successtoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:radiosurabhi/ui/screens/home_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../main.dart';
import '../screens/archives.dart';
import '../screens/audioWebView.dart';
import 'package:webviewx/webviewx.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../screens/help.dart';
import '../screens/home_page.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

class AppScaffold extends StatefulWidget {
  final int index;
  static bool? streamingplay;
  static bool isOnline = true;
  static bool isonlineplay = false;
  AppScaffold(
      {Key? key,
      this.body,
      this.heading,
      this.index = 0,
      this.bottom = false,
      this.appicon = false,
      this.logout = false,
      this.play = false,
      this.bottombar = true,
      this.temphidedrawer = false,
      this.back = false})
      : super(key: key);
  final Widget? body;
  final bool bottom;
  final bool play;
  final bool logout, back, appicon, bottombar, temphidedrawer;
  final String? heading;
  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  /*final List<Widget> viewContainer = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    Myorders(),
  ];*/

  /// Compulsory

  String url = 'https://radiosurabhi.streamguys1.com/live1';

  /// Optional
  int timeProgress = 0;
  int audioDuration = 0;
  double currentvol = 0.5;
  bool openpop = false;
  bool enablebtn = true;

  //AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.newPlayer();

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> subscription;
  bool opendrawer = false;
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Radio Surabhi',
        text: 'Radio Surabhi 104.9FM Telugu Channel',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.radiosurabhi.fmteluguchannel',
        chooserTitle: 'Share Radio Surabhi Playstore Link');
  }

  // final initialContent =
  //'https://player.streamguys.com/radiosurabhi/sgplayer/player.php';
  Size get screenSize => MediaQuery.of(context).size;
  late WebViewXController webviewController;

  Widget slider() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.89,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
              trackHeight: 5,
              disabledInactiveTrackColor: Color.fromRGBO(255, 1, 1, 1),
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0)),
          child: Slider.adaptive(
              inactiveColor: Colors.red,
              activeColor: Colors.green,
              value: audioDuration.toDouble(),
              max: 1,
              label: '',
              onChanged: null),
        ));
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();

    checkConnectivity2();
    /* if (widget.play == true) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setupPlaylist();
      });
    }*/
    MyApp.audioPlayer.currentPosition.listen((positionValue) {
      timeProgress = positionValue.inSeconds;

      HomePage.playDuration.value = positionValue.inSeconds;
    });
    MyApp.audioPlayer.playerState.listen((playerState) async {
      MyApp.playerstate.value = playerState;
    });

    Future.delayed(Duration.zero, () async {
      currentvol = await PerfectVolumeControl.getVolume();
      setState(() {
        // refresh UI
      });
    });

    PerfectVolumeControl.stream.listen((volume) {
      setState(() {
        currentvol = volume;
      });
    });
    PerfectVolumeControl.hideUI = true;
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    //PerfectVolumeControl.stream.
  }

  void checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      AppScaffold.isOnline = true;
    } else {
      AppScaffold.isOnline = false;
    }
  }

  void checkConnectivity2() async {
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() async {
        if (result == ConnectivityResult.none) {
          FlutterSuccessToast().offlineToast(context, "No Internet Connection");

          AppScaffold.isOnline = false;
        } else if (result == ConnectivityResult.mobile) {
          FlutterSuccessToast().onlineToast(context, "No Internet Connection");

          AppScaffold.isonlineplay
              ? await MyApp.audioPlayer.playOrPause()
              : null;
          AppScaffold.isonlineplay = false;

          AppScaffold.isOnline = true;
        } else if (result == ConnectivityResult.wifi) {
          FlutterSuccessToast().onlineToast(context, "No Internet Connection");

          AppScaffold.isonlineplay
              ? await MyApp.audioPlayer.playOrPause()
              : null;
          AppScaffold.isonlineplay = false;
          AppScaffold.isOnline = true;
        }
      });
    });
  }

  void openCallBottom(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        // shape: const RoundedRectangleBorder(
        // borderRadius: BorderRadius.only(
        //  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        // ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStates) {
            return Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  InkWell(
                    onTap: () async {
                      final Uri launchUri = Uri(
                        scheme: 'tel',
                        path: '+19726361966',
                      );
                      await launchUrl(launchUri);
                      Navigator.pop(context);
                      if (HomePage.isplayings) {
                        setState(() {
                          HomePage.hidetempradio = false;
                        });
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green),
                        alignment: Alignment.topCenter,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text('Call  +1 9726361966',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22))
                            ])),
                  ),
                  SizedBox(height: 25),
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        if (HomePage.isplayings) {
                          setState(() {
                            HomePage.hidetempradio = false;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        alignment: Alignment.topCenter,
                        child: Center(
                            child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        )),
                      )),
                  SizedBox(height: 25),
                ]));
          });
        });
  }

  void _showMyDialog(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                  left: 30,
                  right: 20,
                  top: MediaQuery.of(context).size.height * 0.01),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Volume",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18),
                        )),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.009),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Slider(
                      value: currentvol,
                      activeColor: Color.fromRGBO(255, 1, 1, 1),
                      inactiveColor: Color.fromRGBO(255, 1, 1, 0.4),

                      onChanged: (newvol) {
                        currentvol = newvol;
                        PerfectVolumeControl.setVolume(newvol); //set new volume
                        setState(() {});
                      },
                      min: 0, //
                      max: 1,
                      divisions: 100,
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  /// Optional
  String getTimeString(int seconds) {
    //setState(() {});
    //print(seconds);
    String minuteString =
        '${(seconds / 60).floor() < 10 ? 0 : ''}${(seconds / 60).floor()}';
    String secondString = '${seconds % 60 < 10 ? 0 : ''}${seconds % 60}';

    return '$minuteString:$secondString';
    // Returns a string with the format mm:ss
  }

  @override
  Widget build(BuildContext context) {
    log('eeeeeeeee' + MyApp.audioPlayer.isPlaying.value.toString());

    return Scaffold(
      endDrawerEnableOpenDragGesture: false,

      /* floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          child: Icon(Icons.call),
          backgroundColor: HexColor('#fc5252'),
          splashColor: HexColor('#e83e8c'),
          focusColor: HexColor('#e83e8c'),
          onPressed: () async {
            /* final Uri launchUri = Uri(
              scheme: 'tel',
              path: '9442102251',
            );
            await launchUrl(launchUri);*/

            if (HomePage.isplayings) {
              setState(() {
                HomePage.hidetempradio = true;
              });
            }
            openCallBottom(context);
          }),*/
      appBar: AppBar(
        elevation: 0,
        bottom: widget.bottom
            ? PreferredSize(
                preferredSize: const Size.fromHeight(5.0),
                child: SizedBox(
                    height: 3,
                    width: MediaQuery.of(context).size.width,
                    child: ValueListenableBuilder<bool>(
                        valueListenable: AudioWebViewPage.loading,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          if (value && widget.bottom) {
                            return const LinearProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.green));
                          } else {
                            return Container();
                          }
                        })))
            : PreferredSize(
                preferredSize: const Size.fromHeight(5.0), child: Container()),
        backgroundColor: HexColor("#1e2a9c"),
        title: Text(
          widget.heading ?? '',
          style: TextStyle(fontSize: 16),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 130,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.back || HomePage.isplayvideo)
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () async {
                  //Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/homepage');
                  SystemChrome.setPreferredOrientations(
                      DeviceOrientation.values);
                  HelpPage.ishelpvideoplay = false;
                  Archives.isplayvideo = false;
                  HomePage.isplayvideo = false;

                  if (MyApp.playerstate.value.toString() ==
                      'PlayerState.pause') {
                    await MyApp.audioPlayer.stop();
                    await MyApp.audioPlayer.playOrPause();
                  }
                },
              ),
            if (widget.appicon)
              SizedBox(
                  //  height: 20,
                  width: widget.back
                      ? 80
                      : HomePage.isplayvideo
                          ? 80
                          : 105,
                  child: Image.asset(
                    "assets/images/radio_logo.png",
                  )),
          ],
        ),
        actions: [
          // IconButton(
          //   icon: const Icon(
          //     Icons.notifications,
          //     size: 25,
          //   ),
          //   onPressed: () {
          //     Navigator.pushNamed(context, '/newspage');
          //   },
          // ),

          SizedBox(
              width: 25,
              child: FloatingActionButton(
                  elevation: 0.0,
                  child: Icon(
                    Icons.call,
                    size: 15,
                  ),
                  backgroundColor: HexColor('#fc5252'),
                  splashColor: HexColor('#e83e8c'),
                  focusColor: HexColor('#e83e8c'),
                  onPressed: () async {
                    /* final Uri launchUri = Uri(
              scheme: 'tel',
              path: '9442102251',
            );
            await launchUrl(launchUri);*/

                    if (HomePage.isplayings) {
                      setState(() {
                        HomePage.hidetempradio = true;
                      });
                    }
                    openCallBottom(context);
                  })),

          const SizedBox(width: 5),
          const Padding(padding: EdgeInsets.only(left: 4)),

          !HomePage.isplayvideo &&
                  !Archives.isplayvideo &&
                  !HelpPage.ishelpvideoplay &&
                  !widget.temphidedrawer
              ? InkWell(
                  child: SizedBox(
                    width: 30,
                    child: SvgPicture.asset(
                      "assets/Menu.svg",
                      fit: BoxFit.contain,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    //on drawer menu pressed
                    if (_drawerscaffoldkey.currentState!.isEndDrawerOpen) {
                      //if drawer is open, then close the drawer
                      Navigator.pop(context);
                      setState(() {
                        opendrawer = false;
                      });
                    } else {
                      _drawerscaffoldkey.currentState!.openEndDrawer();
                      //if drawer is closed then open the drawer.
                      setState(() {
                        opendrawer = true;
                      });
                    }
                  },
                )
              : Container(),
          // IconButton(
          //   onPressed: () {
          //     //on drawer menu pressed
          //     if (_drawerscaffoldkey.currentState!.isEndDrawerOpen) {
          //       //if drawer is open, then close the drawer
          //       Navigator.pop(context);
          //       setState(() {
          //         opendrawer = false;
          //       });
          //     } else {
          //       _drawerscaffoldkey.currentState!.openEndDrawer();
          //       //if drawer is closed then open the drawer.
          //       setState(() {
          //         opendrawer = true;
          //       });
          //     }
          //   },
          //   icon: opendrawer
          //       ? const Icon(
          //           Icons.close,
          //           size: 30,
          //         )
          //       : const Icon(
          //           Icons.menu,
          //           size: 30,
          //         ),
          // ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      bottomNavigationBar: HomePage.isplayings &&
              !HomePage.isplayvideo &&
              !Archives.isplayvideo &&
              !HelpPage.ishelpvideoplay &&
              !HomePage.hidetempradio
          ? SizedBox(
              height: 130,
              child: _buildBottomStream(),
            )
          : SizedBox(
              height: 0,
            ),
      key: _drawerscaffoldkey,
      endDrawer: Drawer(
          child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HexColor("#3b29a1"),
            HexColor("#ab3c90"),
          ],
        )),
        child: Column(children: <Widget>[
          Expanded(
              child: Container(
                  // decoration: BoxDecoration(
                  //     gradient: LinearGradient(
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  //   colors: [
                  //     HexColor("#3b29a1"),
                  //     HexColor("#ab3c90"),
                  //   ],
                  // )),
                  child:
                      ListView(padding: const EdgeInsets.all(0.0), children: <
                          Widget>[
            const SizedBox(
              height: 10,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              trailing: IconButton(
                onPressed: () {
                  //on drawer menu pressed
                  if (_drawerscaffoldkey.currentState!.isEndDrawerOpen) {
                    //if drawer is open, then close the drawer
                    Navigator.pop(context);
                    setState(() {
                      opendrawer = false;
                    });
                  } else {
                    _drawerscaffoldkey.currentState!.openEndDrawer();
                    //if drawer is closed then open the drawer.
                    setState(() {
                      opendrawer = true;
                    });
                  }
                },
                icon: opendrawer
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        ))
                    : const Icon(
                        Icons.menu,
                        size: 30,
                      ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('YOUR HOST',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/yourhost');
              },
            ),
            const Divider(color: Colors.white),
            ListTile(
                visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                title: const Text('SHOWS',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/showspage');
                }),
            const Divider(color: Colors.white),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('ARCHIVES',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/archives');
              },
            ),
            const Divider(color: Colors.white),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('NEWS',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/newspage');
              },
            ),
            /*    Divider(color: Colors.white),
                              ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                title: Text('kids',
                                    style: TextStyle(fontSize: 15, color: Colors.white)),
                              ),*/
            const Divider(color: Colors.white),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('ABOUT US',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () async {
                // toWebView(context,
                //     "http://www.radiosurabhi.com/aboutus.html",
                //     title: 'About Us');
                Navigator.pop(context);
                Navigator.pushNamed(context, '/aboutus');
              },
            ),
            // const Divider(color: Colors.white),
            // const ListTile(
            //   visualDensity:
            //       VisualDensity(horizontal: 0, vertical: -4),
            //   title: Text('SHARE',
            //       style:
            //           TextStyle(fontSize: 15, color: Colors.white)),
            // ),
            // const Divider(color: Colors.white),
            // const ListTile(
            //   visualDensity:
            //       VisualDensity(horizontal: 0, vertical: -4),
            //   title: Text('SCHEDULES',
            //       style:
            //           TextStyle(fontSize: 15, color: Colors.white)),
            // ),
            const Divider(color: Colors.white),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('TESTIMONIALS',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/testimonials');
              },
            ),
            const Divider(color: Colors.white),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('CONTACT US',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/contactus');
              },
            ),
            const Divider(color: Colors.white),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('SHARE THIS APP',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () async {
                // AndroidIntent intent = const AndroidIntent(
                //   action: 'action_view',
                //   data:
                //       'https://play.google.com/store/apps/details?id=com.cogent.radiosurabhi',
                // );
                // await intent.launch();
                share();
              },
            ),
            const Divider(color: Colors.white),
            ListTile(
              visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
              title: const Text('HELP',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/helppage');
              },
            ),
            const Divider(color: Colors.white),
          ]))),
          Container(
              /*decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      HexColor("#ab3c90"),
                      HexColor("#ab3c90"),
                    ],
                  )),*/
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      const ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text('Social Media Connect',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.width * 0.06,
                            left: MediaQuery.of(context).size.width * 0.055,
                          ),
                          child: SizedBox(
                            height: 50,
                            child: Row(
                              children: [
                                InkWell(
                                  child: SizedBox(
                                    width: 30,
                                    child: SvgPicture.asset(
                                      "assets/you.svg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  onTap: () async {
                                    AndroidIntent intent = const AndroidIntent(
                                      action: 'action_view',
                                      data:
                                          'https://www.youtube.com/c/RadioSurabhi',
                                    );
                                    await intent.launch();
                                  },
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                InkWell(
                                  onTap: () async {
                                    AndroidIntent intent = const AndroidIntent(
                                      action: 'action_view',
                                      data:
                                          'https://www.facebook.com/RadioSurabhi',
                                    );
                                    await intent.launch();
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    child: SvgPicture.asset(
                                      "assets/f.svg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                InkWell(
                                  onTap: () async {
                                    AndroidIntent intent = const AndroidIntent(
                                      action: 'action_view',
                                      data:
                                          'https://www.instagram.com/radiosurabhi/',
                                    );
                                    await intent.launch();
                                  },
                                  child: SizedBox(
                                    width: 30,
                                    child: SvgPicture.asset(
                                      "assets/insta.svg",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ))),
        ]),
      )),

      body: widget
          .body!, // bottomNavigationBar: BottomNavBarWidget(widget.index),
    );
  }

  Future<void> _showOtherPop(BuildContext context, String title, String content,
      {isimage = false}) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter setState) {
            return AlertDialog(
                insetPadding: EdgeInsets.all(5),
                titlePadding: EdgeInsets.all(0),
                contentPadding: EdgeInsets.only(left: 0, right: 0),
                title: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1.0, color: Colors.lightBlue.shade900),
                      ),
                    ),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                        height: 60,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                title,
                                style: TextStyle(fontSize: 18),
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              )
                            ]))),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                content: Container(
                    // height: 200,
                    // width: 300,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        isimage
                            ? Image.asset("assets/images/landing.jpg",
                                fit: BoxFit.cover)
                            : Text(
                                content,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ))));
            //));
          });
        });
  }

  Future<void> _showDetailPop(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter setState) {
            return AlertDialog(
                insetPadding: EdgeInsets.all(5),
                titlePadding: EdgeInsets.all(0),
                contentPadding: EdgeInsets.only(left: 0, right: 0),
                title: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 1.0, color: Colors.lightBlue.shade900),
                      ),
                    ),
                    child: Container(
                        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                        height: 60,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'About SG Player',
                                style: TextStyle(fontSize: 18),
                              ),
                              InkWell(
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              )
                            ]))),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                content: Container(
                    // height: 200,
                    // width: 300,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                            child: Text(
                          'Version 3.2.5',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'SGplayer is a cloud audio and video media player optimized for live and on-demand content delivery.',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'SGplayer supports HTML5 and HLS audio and video on desktop and mobile devices to ensure that your content has 100% device coverage. It can be configured and hosted by StreamGuys and embedded on your site, or can be self-managed. Use SGplayer to play your Podcast. New episodes will be visible in the player as soon as they are published to your feed.',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Use SGplayer to play your live streams. With live in-stream metadata display, your listeners will always know what is currently playing.',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'SGplayer integrates with SGrewind to allow your listeners to rewind your live stream and hear recently played content.',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Some key features of SGplayer are: Integrated VAST support for ad delivery, live in-stream metadata display, video close captioning support, ad-insertion for your content using our Ad-insertion Solutions, Ad-insertion integrations with Google DFP, Adswizz, and TargetSpot, Social Media Integration, Nielsen SDK integration, and support for multiple audio/video streams in one player.',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                        SizedBox(height: 20),
                      ],
                    ))));
            //));
          });
        });
  }

  Future<void> _showMyPop(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext ctx) {
          return StatefulBuilder(
              builder: (BuildContext ctx, StateSetter setState) {
            return AlertDialog(
                backgroundColor: HexColor("#F4F4F4"),
                content: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _showOtherPop(context, 'Details', '', isimage: true);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.info_rounded, color: Colors.black),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Details',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _showOtherPop(context, 'Previously Played',
                            'Noting has been played yet');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add_card_outlined, color: Colors.black),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Previously Played',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pop(context);
                        share();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.share_rounded, color: Colors.black),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'Share',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        _showDetailPop(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.question_mark_rounded,
                              color: Colors.black),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            'About SG Played',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )));
          });
        });
  }

  Widget _buildBottomStream() {
    return Column(children: [
      Expanded(child: Container()),
      Container(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 15, 20, 5),
                  color: Color.fromRGBO(14, 24, 124, 1),
                  alignment: Alignment.center,
                  child: MyApp.audioPlayer.builderPlayerState(
                      builder: (context, isPlaying) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 19, child: slider()),
                        Container(
                            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    height: 20,
                                    //width: MediaQuery.of(context).size.width,
                                    child: ValueListenableBuilder<int>(
                                        valueListenable: HomePage.playDuration,
                                        builder: (BuildContext context,
                                            int value, Widget? child) {
                                          return Text(getTimeString(value),
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.white));
                                        })),
                                Text(
                                  'Live'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                              ],
                            )),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                iconSize: 40,
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  _showMyPop(context);
                                },
                                icon: const Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                )),
                            IconButton(
                              iconSize: 45,
                              onPressed: enablebtn
                                  ? () async {
                                      print('2222222222' +
                                          HomePage.audioPlayer.playerState.value
                                              .toString());
                                      if (HomePage
                                              .audioPlayer.playerState.value ==
                                          PlayerState.play) {
                                        enablebtn = false;
                                        await HomePage.audioPlayer.pause();
                                        HomePage.audioPlayer.playerState
                                                .value ==
                                            PlayerState.stop;
                                        enablebtn = true;
                                      }
                                      if (HomePage
                                              .audioPlayer.playerState.value ==
                                          PlayerState.stop) {
                                        enablebtn = false;
                                        await HomePage.audioPlayer.play();
                                        enablebtn = true;
                                      }
                                    }
                                  : null,
                              icon: Icon(
                                (HomePage.audioPlayer.playerState.value ==
                                        PlayerState.play)
                                    ? Icons.pause_circle
                                    : (HomePage.audioPlayer.playerState.value ==
                                            PlayerState.stop)
                                        ? Icons.play_circle
                                        : Icons.error,
                              ),
                              color: Colors.white,
                            ),
                            IconButton(
                                padding: EdgeInsets.all(0),
                                iconSize: 40,
                                onPressed: () {
                                  _showMyDialog(context);
                                },
                                icon: Icon(
                                    currentvol != 0
                                        ? Icons.volume_up_sharp
                                        : Icons.volume_off_sharp,
                                    color: Colors.white))
                          ],
                        )*/
                        ValueListenableBuilder<PlayerState>(
                            valueListenable: MyApp.playerstate,
                            builder: (BuildContext context, PlayerState value,
                                Widget? child) {
                              log(value.name.toString());
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      padding: EdgeInsets.all(0),
                                      onPressed: () {
                                        _showMyPop(context);
                                      },
                                      icon: const Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                    iconSize: 45,
                                    onPressed: !enablebtn
                                        ? null
                                        : () async {
                                            if (value == PlayerState.play) {
                                              AppScaffold.isonlineplay = false;
                                              await MyApp.audioPlayer.stop();
                                            }
                                            if (value == PlayerState.pause) {
                                              await MyApp.audioPlayer.stop();
                                              await MyApp.audioPlayer
                                                  .playOrPause();
                                            }
                                            if (value == PlayerState.stop) {
                                              print('ss' + value.toString());
                                              AppScaffold.isonlineplay = true;
                                              setState(() {
                                                enablebtn = false;
                                              });
                                              await MyApp.audioPlayer
                                                  .playOrPause();
                                            }
                                            setState(() {
                                              enablebtn = true;
                                            });
                                          },
                                    icon: Icon((value == PlayerState.play)
                                        ? Icons.pause_circle
                                        : Icons.play_circle),
                                    color: Colors.white,
                                  ),
                                  IconButton(
                                      padding: EdgeInsets.all(0),
                                      iconSize: 40,
                                      onPressed: () {
                                        _showMyDialog(context);
                                      },
                                      icon: const Icon(Icons.volume_up_sharp,
                                          color: Colors.white))
                                ],
                              );
                            })
                      ],
                    );
                  }))))
    ]);
  }

  /*Widget _buildWebViewX() {
    return WebViewX(
      key: const ValueKey('webviewx'),
      initialContent: initialContent,
      initialSourceType: SourceType.url,
      height: screenSize.height / 7,
      width: double.infinity,
      onWebViewCreated: (controller) => webviewController = controller,
      onPageStarted: (src) =>
          debugPrint('A new page has started loading: $src\n'),
      onPageFinished: (src) =>
          debugPrint('The page has finished loading: $src\n'),
      jsContent: const {
        EmbeddedJsContent(
          js: "function testPlatformIndependentMethod() { console.log('Hi from JS') }",
        ),
        EmbeddedJsContent(
          webJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback('Web callback says: ' + msg) }",
          mobileJs:
              "function testPlatformSpecificMethod(msg) { TestDartCallback.postMessage('Mobile callback says: ' + msg) }",
        ),
      },
      dartCallBacks: {
        // DartCallback(
        // name: 'TestDartCallback',
        // callBack: (msg) => //showSnackBar(msg.toString(), context),
        // )
      },
      webSpecificParams: const WebSpecificParams(
        printDebugInfo: true,
      ),
      mobileSpecificParams: const MobileSpecificParams(
        androidEnableHybridComposition: true,
      ),
      navigationDelegate: (navigation) {
        debugPrint(navigation.content.sourceType.toString());
        return NavigationDecision.navigate;
      },
    );
  }*/
}
