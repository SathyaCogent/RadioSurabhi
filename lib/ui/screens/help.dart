import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radiosurabhi/ui/screens/archives.dart';
import 'package:radiosurabhi/ui/screens/home_page.dart';
import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';
//import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../../main.dart';
import '../widgets/youtubeController.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);
  static bool ishelpvideoplay = false;
  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  // late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  // late PlayerState _playerState;
  // late YoutubeMetaData _videoMetaData;
  // double _volume = 100;
  // bool _muted = false;
  // bool _isPlayerReady = false;
  String videourl = 'https://youtu.be/Uc8T9bwCOAc';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videourl = 'https://youtu.be/Uc8T9bwCOAc';
    /*_controller = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId("https://youtu.be/Uc8T9bwCOAc")
              .toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }*/
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.

    super.deactivate();
  }

  @override
  void dispose() {
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget buildVideo(BuildContext context) {
    return Center(child: buildTopCard());
  }

  Widget buildTopCard() {
    return Stack(alignment: AlignmentDirectional.topEnd, children: [
      videourl != '' || videourl != null
          ? StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
              return YoutubeController(
                url: videourl,
                disableDragSeek: true,
                myFun: () async {
                  setState(() {
                    Archives.isplayvideo = false;
                    videourl = 'https://youtu.be/Uc8T9bwCOAc';
                  });
                },
              );
            })
          : const AspectRatio(
              aspectRatio: 16 / 11,
              child: Center(
                  child: Text(
                'Preparing',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ))),
      Positioned(
        child: IconButton(
            onPressed: () async {
              if (MyApp.playerstate.value == PlayerState.pause) {
                print('----e----');
                await MyApp.audioPlayer.stop();
                await MyApp.audioPlayer.playOrPause();
              }
              setState(() {
                HelpPage.ishelpvideoplay = false;
                videourl = '';
              });
              // refresh();
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
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

  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return AppScaffold(
      heading: 'Help',
      appicon: true,
      back: true,
      body: HelpPage.ishelpvideoplay
          ? buildVideo(context)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Textwidget(
                        data: "Help",
                        isheading1: false,
                        isheading2: true,
                        isheading3: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: imagecard(
                            context,
                            'assets/images/about_roadmap.jpg',
                            screenwidth,
                            screenheight),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text("RoadMap",
                          style: TextStyle(fontSize: 15, height: 1.6)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                          "Radio Surabhi started off as a two hour radio program on 104.9KZMP-FM, and over the years because of its popularity exponentially grew into a 24hr. radio channel on the same frequency 104.9FM HD-4. We aim to reach as many Telugu audiences across the USA over the coming years and become a unique voice for Telugu listeners across North America.",
                          style: TextStyle(fontSize: 14, height: 1.6)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text("How to tune in",
                          style: TextStyle(fontSize: 15, height: 1.6)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 20,
                                height: 0.1,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Text(
                                  "  Go to FunAsia.net and click on Change Station at the page footer.",
                                  style: TextStyle(fontSize: 14, height: 1.6))),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              '\u2022',
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.55,
                              ),
                            ),
                          ),
                          Text("  You will find an option for HD4",
                              style: TextStyle(fontSize: 14, height: 1.6)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text("HD RADIO",
                          style: TextStyle(fontSize: 14, height: 1.6)),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Center(
                            child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                              Image.asset(
                                'assets/images/helpusyou.png',
                                width: screenwidth * 0.90,
                                //height: screenheight * 0.25,
                                fit: BoxFit.contain,
                              ),
                              Positioned(
                                  top: isLandscape
                                      ? screenheight * 0.40 - 120
                                      : screenheight * 0.25 - 120,
                                  bottom: 0,
                                  right: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      //_onTapedVideo(dataList[index]);

                                      if (!HelpPage.ishelpvideoplay) {
                                        setState(() {
                                          HelpPage.ishelpvideoplay = true;

                                          // oldbottmstat = HomePage.isplayings;

                                          // HomePage.isplayings = false;
                                        });
                                      }
                                      setState(() {
                                        //SystemChrome.setPreferredOrientations(
                                        // [DeviceOrientation.landscapeLeft]);
                                        videourl =
                                            'https://youtu.be/Uc8T9bwCOAc';
                                      });
                                    },
                                    child: SizedBox(
                                      width: 60,
                                      child: SvgPicture.asset(
                                        "assets/play.svg",
                                        fit: BoxFit.contain,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ]))

                        /*child: YoutubePlayer(
                        controller: _controller,
                        showVideoProgressIndicator: true,
                        progressIndicatorColor: Colors.black,
                        onEnded: (data) async {
                          if (HomePage.playerstate.value.toString() ==
                              'PlayerState.pause') {
                            await HomePage.audioPlayer.stop();
                            await HomePage.audioPlayer.play();
                          }
                          SystemChrome.setPreferredOrientations(
                              DeviceOrientation.values);
                        },
                      ),*/

                        ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget imagecard(BuildContext context, String assetname, double screenwidth,
      double screenheight) {
    return Image.asset(
      assetname,
      width: screenwidth * 0.85,
      height: screenheight * 0.25,
      fit: BoxFit.contain,
    );
  }
}
