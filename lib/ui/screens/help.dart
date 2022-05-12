import 'package:flutter/material.dart';
import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = YoutubePlayerController(
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
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return AppScaffold(
      heading: 'Help',
      back: true,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
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
                  child: imagecard(context, 'assets/images/about_roadmap.jpg',
                      screenwidth, screenheight),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Textwidget(
                  data: "RoadMap",
                  isheading1: false,
                  isheading2: false,
                  isheading3: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Textwidget(
                  data:
                      "Radio Surabhi started off as a two hour radio program on 104.9KZMP-FM, and over the years because of its popularity exponentially grew into a 24hr. radio channel on the same frequency 104.9FM HD-4. We aim to reach as many Telugu audiences across the USA over the coming years and become a unique voice for Telugu listeners across North America.",
                  isheading1: false,
                  isheading2: false,
                  isheading3: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Textwidget(
                  data: "How to tune in",
                  isheading1: false,
                  isheading2: false,
                  isheading3: true,
                ),
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
                          height: 1.55,
                        ),
                      ),
                    ),
                    Textwidget(
                      data:
                          "  Go to FunAsia.net and click on Change Station at the page footer.",
                      isheading1: false,
                      isheading2: false,
                      isheading3: false,
                    ),
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
                    Textwidget(
                      data: "  You will find an option for HD4",
                      isheading1: false,
                      isheading2: false,
                      isheading3: false,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Textwidget(
                  data: "HD RADIO",
                  isheading1: false,
                  isheading2: false,
                  isheading3: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.black,
                  ),
                ),
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
      fit: BoxFit.fill,
    );
  }
}
