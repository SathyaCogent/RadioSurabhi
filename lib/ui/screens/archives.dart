import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:radiosurabhi/blocs/archives_bloc.dart';
import 'package:radiosurabhi/ui/screens/home_page.dart';

import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/stream.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';
import 'package:radiosurabhi/ui/widgets/youtubecontroller.dart';

import '../../blocs/test_bloc.dart';
import '../../main.dart';

class Archives extends StatefulWidget {
  const Archives({Key? key, this.istestimonials = false}) : super(key: key);
  final bool istestimonials;
  static bool isplayvideo = false;
  @override
  State<Archives> createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> {
  late ArchiveBloc archiveListBloc;
  late TestBloc testListBloc;
  //bool isplayvideo = false;
  String videourl = '';
  @override
  void initState() {
    super.initState();

    archiveListBloc = ArchiveBloc();
    archiveListBloc.getArchiveListdata();

    testListBloc = TestBloc();
    testListBloc.getTestListdata();
  }

  var screenwidth, screenheight, isLandscape;
  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return AppScaffold(
      heading: !widget.istestimonials ? "Archives" : "Testimonials",
      //back: true,
      index: 0,
      appicon: true,
      back: true,
      bottom: true,
      play: true,
      body: Archives.isplayvideo
          ? buildVideoPage(context)
          : buildMyContent(context),

      /*body: Column(children: [
          Archives.isplayvideo ? buildTopCard() : Container(),
          if (!Archives.isplayvideo)
            widget.istestimonials
                ? Expanded(
                    child: StreamWidget(
                        testListBloc.testListStream, _buildContent))
                : Expanded(
                    child: StreamWidget(
                        archiveListBloc.archiveListStream, _buildContent)),
        ])*/
    );
  }

  Widget buildVideoPage(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Center(child: buildTopCard());
  }

  refresh() {
    archiveListBloc = ArchiveBloc();
    archiveListBloc.getArchiveListdata();

    testListBloc = TestBloc();
    testListBloc.getTestListdata();
  }

  Widget buildMyContent(BuildContext context) {
    return Column(children: [
      //Archives.isplayvideo ? buildTopCard() : Container(),
      widget.istestimonials
          ? Expanded(
              child: StreamWidget(testListBloc.testListStream, _buildContent))
          : Expanded(
              child: StreamWidget(
                  archiveListBloc.archiveListStream, _buildContent)),
    ]);
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
                    videourl = '';
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
                Archives.isplayvideo = false;
                videourl = '';
              });
              refresh();
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

  Widget _buildContent(BuildContext context, var dataList) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Textwidget(
                  data: !widget.istestimonials ? "Archives" : "Testimonials",
                  isheading1: false,
                  isheading2: true,
                  isheading3: false,
                ),
              ),
              ListView.builder(
                  itemCount: dataList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Image.network(
                                dataList[index].coverImageP,
                                fit: BoxFit.cover,
                                width: screenwidth * 0.95,
                                height: isLandscape
                                    ? screenheight * 0.40
                                    : screenheight * 0.25,
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

                                      if (!Archives.isplayvideo) {
                                        setState(() {
                                          Archives.isplayvideo = true;
                                        });
                                      }
                                      setState(() {
                                        videourl = dataList[index].videoUrl;
                                        //SystemChrome.setPreferredOrientations(
                                        // [DeviceOrientation.landscapeLeft]);
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
                            ])
                        /*YoutubeController(
                          url: dataList[index].videoUrl,
                          myFun: () async {
                            setState(() {});
                          },
                        ),*/

                        );
                  }),
            ]));
  }
}
