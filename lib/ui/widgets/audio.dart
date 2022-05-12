import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiosurabhi/ui/screens/webview.dart';
import '../widgets/PlayingControls.dart';
import '../widgets/PositionSeekWidget.dart';
import '../widgets/app_scaffold.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioPage extends StatefulWidget {
  const AudioPage({Key? key}) : super(key: key);

  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage>
    with SingleTickerProviderStateMixin {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  final audios = <Audio>[
    //Audio.network(
    //  'https://d14nt81hc5bide.cloudfront.net/U7ZRzzHfk8pvmW28sziKKPzK',
    //  metas: Metas(
    //    id: 'Invalid',
    //    title: 'Invalid',
    //    artist: 'Florent Champigny',
    //    album: 'OnlineAlbum',
    //    image: MetasImage.network(
    //        'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
    //  ),
    //),
    Audio.network(
      '',
      metas: Metas(
        id: 'Online',
        title: 'Online',
        artist: 'Florent Champigny',
        album: 'OnlineAlbum',
        // image: MetasImage.network('https://www.google.com')
        image: const MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    //_subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
    //  print('finished : $data');
    //}));
    //openPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));

    openPlayer();
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: false,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: NeumorphicTheme.baseColor(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 0.82,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset("assets/images/landing.jpg",
                        fit: BoxFit.cover)),
                Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        width: MediaQuery.of(context).size.width * 1,
                        // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //  bottomLeft: Radius.circular(30.0),
                          //   bottomRight: Radius.circular(30.0)),
                          color: HexColor("#002271"),
                        ),
                        child: Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            /*  decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                            ),*/
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: SizedBox(
                                height:
                                MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: InkWell(

                                  /*   style: ElevatedButton.styleFrom(
                                    //  primary: HexColor("#002271"),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      )),*/
                                  child:  Container(
                                      height: MediaQuery.of(context).size.height * 0.5,
                                      child: Image.asset("assets/images/radiobutton.png",
                                      )),
                                  onTap: () async {
                                    toWebView(context,
                                        "https://player.streamguys.com/radiosurabhi/sgplayer/player.php",
                                        );
                                  },
                                ))
                          /*_assetsAudioPlayer.builderCurrent(
                                builder: (context, Playing? playing) {
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    SizedBox(child:
                                        _assetsAudioPlayer.builderLoopMode(
                                      builder: (context, loopMode) {
                                        return PlayerBuilder.isPlaying(
                                            player: _assetsAudioPlayer,
                                            builder: (context, isPlaying) {
                                              return PlayingControls(
                                                loopMode: loopMode,
                                                isPlaying: isPlaying,
                                                isPlaylist: true,
                                                onStop: () {
                                                  _assetsAudioPlayer.stop();
                                                },
                                                toggleLoop: () {
                                                  _assetsAudioPlayer
                                                      .toggleLoop();
                                                },
                                                onPlay: () {
                                                  _assetsAudioPlayer
                                                      .playOrPause();
                                                },
                                                onNext: () {
                                                  _assetsAudioPlayer.next(
                                                      keepLoopMode: true);
                                                },
                                                onPrevious: () {
                                                  _assetsAudioPlayer.previous();
                                                },
                                              );
                                            });
                                      },
                                    )),
                                    SizedBox(
                                        width: 220,
                                        child: _assetsAudioPlayer
                                            .builderRealtimePlayingInfos(
                                                builder: (context,
                                                    RealtimePlayingInfos?
                                                        infos) {
                                          if (infos == null) {
                                            return SizedBox();
                                          }
                                          //print('infos: $infos');
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              PositionSeekWidget(
                                                currentPosition:
                                                    infos.currentPosition,
                                                duration: infos.duration,
                                                seekTo: (to) {
                                                  _assetsAudioPlayer.seek(to);
                                                },
                                              ),
                                            ],
                                          );
                                        })),
                                  ]);
                            })*/
                        ))),
              ],
            ),
          ),
        ),
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
      BuildContext context, Function(BuildContext context) builder) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return builder(context);
    }));
  }
}
