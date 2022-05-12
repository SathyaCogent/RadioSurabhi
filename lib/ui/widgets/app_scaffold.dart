import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:radiosurabhi/ui/widgets/social_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/audioWebView.dart';

class AppScaffold extends StatefulWidget {
  final int index;
  const AppScaffold(
      {Key? key,
      this.body,
      this.heading,
      this.index = 0,
      this.bottom = false,
      this.appicon = false,
      this.logout = false,
      this.back = false})
      : super(key: key);
  final Widget? body;
  final bool bottom;
  final bool logout, back, appicon;
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
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  bool opendrawer = false;
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Radio Surabhi',
        text: 'Radio Surabhi Android Application',
        linkUrl:
            'https://play.google.com/store/apps/details?id=com.cogent.radiosurabhi',
        chooserTitle: 'Share Radio Surabhi Playstore Link');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
        title: Text(widget.heading ?? ''),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 90,
        leading: widget.back
            ? Builder(builder: (BuildContext context) {
                return IconButton(
                  icon:
                      const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                );
              })
            : widget.appicon
                ? Container(
                    child: Image.asset(
                    "assets/images/radio_logo.png",
                  ))
                : null,
        actions: [
          /*IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/newspage');
            },
          ),*/
          const Padding(padding: EdgeInsets.only(left: 4)),
          InkWell(
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
          ),
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
                    ? const Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
                      )
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
    ));
  }
}
