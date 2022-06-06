import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:radiosurabhi/blocs/host_bloc.dart';
import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/social_button.dart';
import 'package:radiosurabhi/ui/widgets/stream.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';

class Yourhost extends StatefulWidget {
  const Yourhost({Key? key}) : super(key: key);

  @override
  State<Yourhost> createState() => _YourhostState();
}

class _YourhostState extends State<Yourhost> {
  late HostsBloc hostListBloc;
  List? singerImage = ["assets/images/boy.jpg"];

  @override
  void initState() {
    super.initState();
    hostListBloc = HostsBloc();
    hostListBloc.getHostsListdata();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      heading: 'Your Host',
      appicon: true,
      back: true,
      body: StreamWidget(hostListBloc.hostsListStream, _buildContent),
    );
  }

  Widget _buildContent(BuildContext context, var HostDataList) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Textwidget(
                  data: "Your Host",
                  isheading1: false,
                  isheading2: true,
                  isheading3: false,
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: HostDataList.length,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                      child: yourhostList(context, HostDataList[index]),
                    );
                  }),
            ]));
  }

  Widget yourhostList(BuildContext context, var filterData) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: imagecard(
                context, filterData.imageP, screenwidth, screenheight),
          ),
        ),
        filterData.socialMedia != null
            ? Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      //filterData.socialMedia.facebook != "null"
                      // ? InkWell(
                      //     child: const NeuButton(
                      //       char: 'y',
                      //     ),
                      //     onTap: () async {
                      //       AndroidIntent intent = const AndroidIntent(
                      //         action: 'action_view',
                      //         data: 'https://www.youtube.com/c/RadioSurabhi',
                      //       );
                      //       await intent.launch();
                      //     },
                      //   )
                      // : SizedBox(),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.03,
                      // ),
                      filterData.socialMedia.facebook != 'null'
                          ? InkWell(
                              onTap: filterData.socialMedia.facebook == "null"
                                  ? null
                                  : () async {
                                      AndroidIntent intent = AndroidIntent(
                                        action: 'action_view',
                                        data: filterData.socialMedia.facebook,
                                      );
                                      await intent.launch();
                                    },
                              child: SizedBox(
                                width: 30,
                                child: SvgPicture.asset(
                                  "assets/f.svg",
                                  fit: BoxFit.contain,
                                ),
                              ))
                          : Container(),
                      if (filterData.socialMedia.facebook != 'null')
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      // InkWell(
                      //   onTap: () async {},
                      //   child: SizedBox(
                      //     width: 30,
                      //     child: SvgPicture.asset(
                      //       "assets/insta.svg",
                      //       fit: BoxFit.contain,
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.03,
                      // ),
                      filterData.socialMedia.twitter != 'null'
                          ? InkWell(
                              onTap: () async {
                                AndroidIntent intent = AndroidIntent(
                                  action: 'action_view',
                                  data: filterData.socialMedia.twitter,
                                );
                                await intent.launch();
                              },
                              child: SizedBox(
                                width: 30,
                                child: SvgPicture.asset(
                                  "assets/tw.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Container(),
                      if (filterData.socialMedia.twitter != 'null')
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      filterData.socialMedia.linkedin != 'null'
                          ? InkWell(
                              onTap: () async {
                                AndroidIntent intent = AndroidIntent(
                                  action: 'action_view',
                                  data: filterData.socialMedia.linkedin,
                                );
                                await intent.launch();
                              },
                              child: SizedBox(
                                width: 30,
                                child: SvgPicture.asset(
                                  "assets/linked.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Container(),
                      if (filterData.socialMedia.linkedin != 'null')
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      filterData.socialMedia.instagram != 'null'
                          ? InkWell(
                              onTap: () async {
                                AndroidIntent intent = AndroidIntent(
                                  action: 'action_view',
                                  data: filterData.socialMedia.instagram,
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
                            )
                          : Container(),
                      if (filterData.socialMedia.instagram != 'null')
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                      filterData.socialMedia.spotify != 'null'
                          ? InkWell(
                              onTap: () async {
                                AndroidIntent intent = AndroidIntent(
                                  action: 'action_view',
                                  data: filterData.socialMedia.spotify,
                                );
                                await intent.launch();
                              },
                              child: SizedBox(
                                width: 30,
                                child: SvgPicture.asset(
                                  "assets/spotify.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Container(),
                      if (filterData.socialMedia.spotify != 'null')
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),

                      filterData.socialMedia.website != 'null'
                          ? InkWell(
                              onTap: () async {
                                AndroidIntent intent = AndroidIntent(
                                  action: 'action_view',
                                  data: filterData.socialMedia.website,
                                );
                                await intent.launch();
                              },
                              child: SizedBox(
                                width: 30,
                                child: SvgPicture.asset(
                                  "assets/website.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Container(),
                      if (filterData.socialMedia.website != 'null')
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),

                      filterData.socialMedia.soundcloud != 'null'
                          ? InkWell(
                              onTap: () async {
                                AndroidIntent intent = AndroidIntent(
                                  action: 'action_view',
                                  data: filterData.socialMedia.soundcloud,
                                );
                                await intent.launch();
                              },
                              child: SizedBox(
                                width: 30,
                                child: SvgPicture.asset(
                                  "assets/soundcloud.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Container(),
                      if (filterData.socialMedia.soundcloud != 'null')
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),

                      filterData.socialMedia.youtube != 'null'
                          ? InkWell(
                              onTap: () async {
                                AndroidIntent intent = AndroidIntent(
                                  action: 'action_view',
                                  data: filterData.socialMedia.youtube,
                                );
                                await intent.launch();
                              },
                              child: SizedBox(
                                width: 30,
                                child: SvgPicture.asset(
                                  "assets/you.svg",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ))
            : Text(''),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Textwidget(
            data: filterData.name,
            isheading1: false,
            isheading2: true,
            isheading3: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: filterData.description.blocks.length,
              scrollDirection: Axis.vertical,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                        filterData.description.blocks[index].data.text
                            .toString(),
                        style: TextStyle(fontSize: 14, height: 1.6)));
              }),
        ),
      ],
    );
  }

  Widget imagecard(BuildContext context, String assetname, double screenwidth,
      double screenheight) {
    return Image.network(
      assetname,
      width: screenwidth * 0.95,
      // height: screenheight * 0.3,
      fit: BoxFit.cover,
    );
  }
}
