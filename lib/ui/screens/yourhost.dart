import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
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
      back: true,
      body: SingleChildScrollView(
        child: StreamWidget(hostListBloc.hostsListStream, _buildContent),
      ),
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
                  data: "About us",
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    filterData.socialMedia.facebook != "null"
                        ? InkWell(
                            onTap: () async {
                              AndroidIntent intent = AndroidIntent(
                                action: 'action_view',
                                data: filterData.socialMedia.facebook,
                              );
                              await intent.launch();
                            },
                            child: const NeuButton(
                              char: 'f',
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    // filterData.socialMedia.facebook != "null"
                    //     ? InkWell(
                    //         onTap: () async {
                    //           AndroidIntent intent = const AndroidIntent(
                    //             action: 'action_view',
                    //             data: 'https://www.instagram.com/radiosurabhi/',
                    //           );
                    //           await intent.launch();
                    //         },
                    //         child: const NeuButton(
                    //           char: 'i',
                    //         ),
                    //       )
                    //     : SizedBox(),
                  ],
                ),
              )
            : Text(''),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Textwidget(
            data: filterData.name,
            isheading1: false,
            isheading2: false,
            isheading3: true,
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
                return Textwidget(
                  data:
                      filterData.description.blocks[index].data.text.toString(),
                  isheading1: false,
                  isheading2: false,
                  isheading3: false,
                );
              }),
        ),
      ],
    );
  }

  Widget imagecard(BuildContext context, String assetname, double screenwidth,
      double screenheight) {
    return Image.network(
      assetname,
      width: screenwidth * 0.85,
      height: screenheight * 0.3,
      fit: BoxFit.cover,
    );
  }
}
