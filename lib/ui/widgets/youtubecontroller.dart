import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../main.dart';
import '../screens/home_page.dart';

class YoutubeController extends StatefulWidget {
  const YoutubeController({
    Key? key,
    required this.url,
    this.disableDragSeek = false,
    required this.myFun,
  }) : super(key: key);
  final String url;
  final bool disableDragSeek;
  final void Function() myFun;

  @override
  State<YoutubeController> createState() => _YoutubeControllerState();
}

class _YoutubeControllerState extends State<YoutubeController> {
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late YoutubePlayerController _controller;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.url + '---d');

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url).toString(),
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: widget.disableDragSeek,
        controlsVisibleAtStart: true,
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

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.url != oldWidget.url) {
      _controller.load(YoutubePlayer.convertUrlToId(widget.url).toString());
      print(widget.url + '--ssssss-d');
      /*_controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.url).toString(),
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: false,
          disableDragSeek: widget.disableDragSeek,
          controlsVisibleAtStart: true,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      )..addListener(listener);
      _idController = TextEditingController();
      _seekToController = TextEditingController();
      _videoMetaData = const YoutubeMetaData();
      _playerState = PlayerState.unknown;*/
      //widget.myFun();
    }
  }

  void listener() async {
    print('zzzzzzzzz' + _controller.value.playerState.toString());

    if (_controller.value.playerState == PlayerState.paused) {
      if (MyApp.playerstate.value.toString() == 'PlayerState.pause') {
        await MyApp.audioPlayer.stop();
        await MyApp.audioPlayer.playOrPause();
      }
    }
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String time = durationFormatter(
      (_controller.metadata.duration.inMilliseconds),
    );
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        //aspectRatio: 16 / 9,
        onEnded: (data) async {
          if (MyApp.playerstate.value.toString() == 'PlayerState.pause') {
            await MyApp.audioPlayer.stop();
            await MyApp.audioPlayer.playOrPause();
          }
          SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        },
      ),
      builder: (context, player) {
        return player;
      },
    );

    /*YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.black,
      //thumbnail: Image.asset('assets/images/girl.jpg'),

      bottomActions: [
        Text(
          " ${time}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ],
      onEnded: (data) async {
        if (HomePage.playerstate.value.toString() == 'PlayerState.pause') {
          await HomePage.audioPlayer.stop();
          await HomePage.audioPlayer.play();
        }
      },
    );*/
  }

  String durationFormatter(int milliSeconds) {
    var seconds = milliSeconds ~/ 1000;
    final hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;
    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';
    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';
    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';
    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';
    return formattedTime;
  }
}
