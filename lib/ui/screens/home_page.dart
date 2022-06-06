import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiosurabhi/blocs/archives_bloc.dart';
import 'package:radiosurabhi/blocs/host_bloc.dart';
import 'package:radiosurabhi/blocs/news_bloc.dart';
import 'package:radiosurabhi/blocs/sponsors_bloc.dart';
import 'package:radiosurabhi/main.dart';
import 'package:radiosurabhi/ui/routerarguments/newshomepageview_args.dart';

import 'package:radiosurabhi/ui/routerarguments/yourhomepageview_args.dart';
import 'package:radiosurabhi/ui/screens/webview.dart';
import 'package:radiosurabhi/ui/widgets/stream.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';
import 'package:radiosurabhi/ui/widgets/youtubeController.dart';
import 'package:video_player/video_player.dart';

import '../widgets/app_scaffold.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:app_settings/app_settings.dart';
import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:new_version/new_version.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static bool popupinfo = true;
  static bool powersavemode = true;
  static bool streamingplay = false;

  static ValueNotifier<int> playDuration = ValueNotifier<int>(0);

  static bool isplayings = true;

  static bool isplayvideo = false;

  static bool hidetempradio = false;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool opendrawer = false;
  int _currentsliderindex = 0;
  //bool isplayvideo = false;

  String videourl = '';
  String mydum = '';

  final CarouselController _controller = CarouselController();
  late ArchiveBloc archiveListBloc;
  late HostsBloc hostListBloc;
  late SponsorsBloc sponsorListBloc;
  late NewsBloc newsListBloc;
  final Battery _battery = Battery();
  VideoPlayerController? _videocontroller;

  bool oldbottmstat = false;

  @override
  void initState() {
    super.initState();
    //setupPlaylist();

    opendrawer = false;
    archiveListBloc = ArchiveBloc();
    archiveListBloc.getArchiveListdata();
    hostListBloc = HostsBloc();
    hostListBloc.getHostsListdata();
    newsListBloc = NewsBloc();
    newsListBloc.getNewsListdata();
    sponsorListBloc = SponsorsBloc();
    sponsorListBloc.getSponsorsListdata();
    checkPowerSaverMode();
   
    print('----------ccccc');
  }

  // String url = 'https://radiosurabhi.streamguys1.com/live1';
  // void setupPlaylist() async {
  //   HomePage.audioPlayer.open(Audio.liveStream(url),
  //       playInBackground: PlayInBackground.disabledPause,
  //       showNotification: false,
  //       notificationSettings: NotificationSettings(),
  //       autoStart: false);
  // }

  @override
  void dispose() {
    _videocontroller!.dispose();

    super.dispose();
    print('----------ccccc');
  }

  

  void checkPowerSaverMode() async {
    bool? isBatteryOptimizationDisabled =
        await DisableBatteryOptimization.isBatteryOptimizationDisabled;

    if (!isBatteryOptimizationDisabled!) {
      await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
    }

    final isInPowerSaveMode = await _battery.isInBatterySaveMode;

    if (isInPowerSaveMode && HomePage.powersavemode) {
      await AppSettings.openBatteryOptimizationSettings();
      setState(() {
        HomePage.powersavemode = false;
      });
    }
  }

  var screenwidth, screenheight, isLandscape;

  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return AppScaffold(
      index: 0,
      appicon: true,
      bottom: true,
      play: true,
      heading: "Radio Surabhi",
      body: HomePage.isplayvideo
          ? isLandscape
              ? buildVideoPages(context)
              : buildVideoPage(context)
          : buildContent(context),
    );
  }

  Widget buildVideoPage(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          buildVideoView()
          //Text('0000000000000000000000000000'),
        ]);
  }

  Widget buildVideoPages(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return buildVideoView();
  }

  Widget buildContent(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return SingleChildScrollView(
      //padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomePage.isplayvideo ? buildVideoView() : buildTopCard(),
          // Image.asset("assets/images/landing.jpg", fit: BoxFit.cover),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Textwidget(
                  data: "Who is my host?",
                  isheading1: false,
                  isheading2: false,
                  isheading3: true,
                ),
              ),
              StreamWidget(hostListBloc.hostsListStream, imageCard),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 20, bottom: 0),
                child: Textwidget(
                  data: "Podcasts/Archives",
                  isheading1: false,
                  isheading2: false,
                  isheading3: true,
                ),
              ),
              StreamWidget(archiveListBloc.archiveListStream, youtubeCard),
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Textwidget(
                  data: "News & Events",
                  isheading1: false,
                  isheading2: false,
                  isheading3: true,
                ),
              ),
              StreamWidget(newsListBloc.newsListStream, newsimageCard)
            ],
          ),
          Align(
              alignment: Alignment.bottomLeft,
              // _buildTitle('Top Brands'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle('Our Sponsors'),
                  StreamWidget(sponsorListBloc.sponsorListStream, _buildSlider),
                  const SizedBox(
                    height: 25,
                  )
                ],
              ))
        ],
      ),
    );
  }

  refresh() {
    archiveListBloc = ArchiveBloc();
    archiveListBloc.getArchiveListdata();
    hostListBloc = HostsBloc();
    hostListBloc.getHostsListdata();
    newsListBloc = NewsBloc();
    newsListBloc.getNewsListdata();
    sponsorListBloc = SponsorsBloc();
    sponsorListBloc.getSponsorsListdata();
  }

  Widget buildVideoView() {
    return Stack(alignment: AlignmentDirectional.topEnd, children: [
      videourl != '' || videourl != null
          ? StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
              return //AspectRatio(
                  //aspectRatio: 16 / 6.2,
                  YoutubeController(
                url: videourl,
                disableDragSeek: true,
                myFun: () async {
                  setState(() {
                    HomePage.isplayvideo = false;
                    videourl = '';
                    //oldbottmstat ? HomePage.isplayings = true : false;
                  });
                  //if (HomePage.playerstate == PlayerState.pause) {
                  //await HomePage.audioPlayer.play();
                  //}
                },
              );
            })
          : const Center(
              child: Text(
              'Preparing',
              style: TextStyle(fontSize: 18, color: Colors.black),
            )),
      Positioned(
        child: IconButton(
            onPressed: () async {
              print('inside button click');

              if (MyApp.playerstate.value == PlayerState.pause) {
                print('----e----');
                await MyApp.audioPlayer.stop();
                await MyApp.audioPlayer.playOrPause();
              }
              setState(() {
                print('inside button click23');
                HomePage.isplayvideo = false;
                videourl = '';
              });

              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
              refresh();
            },
            alignment: Alignment.topRight,
            icon: const Icon(
              Icons.highlight_remove,
              size: 32,
              color: Colors.red,
            )),
      )
    ]);
  }

  Widget buildTopCard() {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 20),
      child: Container(
        width: screenwidth * 0.95,
        padding:
            const EdgeInsets.only(top: 14.0, bottom: 14, left: 14, right: 14),
        //height: screenheight * 0.20,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [HexColor("#3b29a1"), HexColor("#569abe")],
          ),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenwidth * 0.4,
                        child: Text(
                          'Radio Surabhi',
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05),
                        ),
                      ),
                      SizedBox(
                        width: screenwidth * 0.1,
                      ),
                      Text(
                        "104.9 FM HD\u2084",
                        style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenwidth * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: screenheight / 70),
                              child: Text(
                                "Live Radio",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                            ),
                            /*Padding(
                              padding: EdgeInsets.only(top: screenheight / 80),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/helppage');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "How to Connect",
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                  ),
                                ),
                              ),
                            ),*/
                          ],
                        ),
                      ),
                      SizedBox(
                        width: screenwidth * 0.1,
                      ),
                      /*IconButton(
                        icon: HomePage.isplayings
                            ? Image.asset(
                                "assets/Play_InActive28.png",
                              )
                            : Image.asset(
                                "assets/Play_Active28.png",
                              ),

                        /*
                        icon: Icon(
                          HomePage.isplayings
                              ? Icons.pause_circle
                              : Icons.play_circle,
                          color: Colors.white,
                        ),*/
                        iconSize: screenheight * 0.05,
                        onPressed: () {
                          setState(() {
                            HomePage.isplayings = !HomePage.isplayings;
                            if (HomePage.isplayings == false) {
                              archiveListBloc.getArchiveListdata();
                              hostListBloc.getHostsListdata();
                            } else {
                              //Navigator.pushNamed(context, "/audiopagewebview");
                            }
                          });
                        },
                      ),*/
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget youtubeCard(BuildContext context, var dataList) {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          height: isLandscape ? screenheight * 0.50 : screenheight * 0.22,
          width: screenwidth * 0.97,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: dataList.length,
              scrollDirection: Axis.horizontal,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    width: screenwidth * 0.65,
                    child: Padding(
                        padding: EdgeInsets.only(
                            top: 0.0, left: 0, right: screenwidth * 0.05),
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Image.network(
                                dataList[index].coverImageP,
                                fit: BoxFit.cover,
                                width: screenwidth * 0.65,
                                height: isLandscape
                                    ? screenheight * 0.50
                                    : screenheight * 0.20,
                              ),

                              /*child: YoutubeController(
                      url: dataList[index].videoUrl,
                      disableDragSeek: true,
                    ),*/

                              Positioned(
                                top: isLandscape
                                    ? screenheight * 0.50 - 70
                                    : screenheight * 0.20 - 70,
                                bottom: 0,
                                right: 15,
                                child: GestureDetector(
                                    onTap: () {
                                      if (!HomePage.isplayvideo) {
                                        setState(() {
                                          HomePage.isplayvideo = true;
                                        });
                                      }
                                      setState(() {
                                        videourl = dataList[index].videoUrl;
                                      });
                                    },
                                    child: SizedBox(
                                      width: 60,
                                      child: SvgPicture.asset(
                                        "assets/play.svg",
                                        fit: BoxFit.contain,
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ])));
              }),
        ));
  }

  // _onTapedVideo(var datayou) {
  //   //final controllervideo = VideoPlayerController.network(
  //   //'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
  //   final controllervideo = VideoPlayerController.network(datayou.videoUrl);
  //   _videocontroller = controllervideo;
  //   setState(() {});
  //   controllervideo
  //     ..initialize().then((_) {
  //       controllervideo.play();
  //       setState(() {});
  //     });
  // }

  Widget imageCard(BuildContext context, var imagedatalist) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: SizedBox(
          height: isLandscape ? screenheight * 0.61 : screenheight * 0.28,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: imagedatalist.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/yourhosthomepageview',
                        arguments:
                            YourHostHomePageViewArgs(imagedatalist[index]));
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: screenwidth * 0.05, top: 10),
                    child: Stack(
                      children: [
                        ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: Image.network(
                            imagedatalist[index].imageP,
                            fit: BoxFit.cover,
                            width: screenwidth * 0.42,
                            height: isLandscape
                                ? screenheight * 0.61
                                : screenheight * 0.28,
                          ),
                        ),
                        Container(
                          width: screenwidth * 0.42,
                          height: isLandscape
                              ? screenheight * 0.63
                              : screenheight * 0.33,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(15),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Colors.black,
                              gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent,
                                    Colors.black,
                                  ],
                                  stops: [
                                    0.0,
                                    0.5,
                                    1.0
                                  ])),
                        ),
                        Positioned(
                          bottom: isLandscape
                              ? screenheight * 0.13
                              : screenheight * 0.073,
                          left: screenwidth * 0.03,
                          child: Text(
                              imagedatalist[index].programName.toString(),
                              style: TextStyle(
                                  fontSize: 11, color: Colors.white70)),
                        ),
                        Positioned(
                          bottom: isLandscape
                              ? screenheight * 0.088
                              : screenheight * 0.052,
                          left: screenwidth * 0.03,
                          child: Text(imagedatalist[index].name.toString(),
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ),
                        Positioned(
                          bottom: isLandscape
                              ? screenheight * 0.054
                              : screenheight * 0.033,
                          left: screenwidth * 0.03,
                          child: Text(
                            imagedatalist[index].programDay.toString(),
                            style:
                                TextStyle(fontSize: 9, color: Colors.white70),
                          ),
                        ),
                        Positioned(
                          bottom: isLandscape
                              ? screenheight * 0.015
                              : screenheight * 0.015,
                          left: screenwidth * 0.03,
                          child: Text(
                              imagedatalist[index].programTimings.toString(),
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white70)),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  Widget newsimageCard(BuildContext context, var newsdatalist) {
    return Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SizedBox(
          height: isLandscape ? screenheight * 0.50 : screenheight * 0.23,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: newsdatalist.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/newshomepageview',
                        arguments: NewsHomePageViewArgs(newsdatalist[index]));
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: screenwidth * 0.05, top: 10),
                    child: Image.network(
                      newsdatalist[index].coverImageP,
                      fit: BoxFit.fill,
                      width: screenwidth * 0.65,
                    ),
                  ),
                );
              }),
        ));
  }

  Widget _buildSlider(BuildContext context, var sponsorsListData) {
    return Column(children: [
      const SizedBox(
        height: 10,
      ),
      CarouselSlider.builder(
          itemCount: sponsorsListData.length,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 0.7,
              enlargeCenterPage: true,
              aspectRatio: 19 / 7,
              autoPlayInterval: const Duration(seconds: 1),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentsliderindex = index;
                });
              }),
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            return _buildSliderItem(context, sponsorsListData[index].logoP);
          }),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: imgList.asMap().entries.map((entry) {
      //     //int pageIndex = imgList.indexOf(url);
      //     return GestureDetector(
      //         onTap: () => _controller.animateToPage(entry.key),
      //         child: Container(
      //           width: 30.0,
      //           height: 5.0,
      //           margin:
      //               const EdgeInsets.symmetric(vertical: 15.0, horizontal: 9.0),
      //           decoration: BoxDecoration(
      //             shape: BoxShape.rectangle,
      //             color: _currentsliderindex == entry.key
      //                 ? Colors.red
      //                 : const Color(0xffc5d2da),
      //           ),
      //         ));
      //   }).toList(),
      // ),
    ]);
  }

  Widget _buildSliderItem(BuildContext context, String item) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Image.network(item, fit: BoxFit.contain, width: 1000));
  }

  Widget _buildTitle(String title) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 15, 20),
      child: Textwidget(
        data: title,
        isheading1: false,
        isheading2: false,
        isheading3: true,
      ),
    );
  }

  Future<dynamic> toWebView(BuildContext context, String? url,
      {String? title}) {
    return navigateToPage(
      context,
      (context) {
        return PageWebView(
          url: url,
          title: title,
        );
      },
    );
  }

  Future navigateToPage(
      BuildContext context, Function(BuildContext context) builder,
      {RouteSettings? settings, bool popup = false}) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return builder(context);
    }));
  }
}
