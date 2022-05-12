import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/social_button.dart';

import 'package:radiosurabhi/ui/widgets/text_widget.dart';

class Yourhosthomepageview extends StatefulWidget {
  const Yourhosthomepageview({Key? key, this.hostdata}) : super(key: key);

  final dynamic hostdata;
  @override
  State<Yourhosthomepageview> createState() => _YourhosthomepageviewState();
}

class _YourhosthomepageviewState extends State<Yourhosthomepageview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      heading: widget.hostdata.name,
      back: true,
      body:
          SingleChildScrollView(child: _buildContent(context, widget.hostdata)),
    );
  }

  Widget _buildContent(BuildContext context, var hostData) {
    return Container(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        alignment: Alignment.topLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              yourhostList(context, hostData),
            ]));
  }

  Widget yourhostList(BuildContext context, var filterData) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Center(
            child: imagecard(
                context, filterData.imageP, screenwidth, screenheight),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10),
            child: SizedBox(
                height: 50,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
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
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
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
                    InkWell(
                      onTap: () async {},
                      child: SizedBox(
                        width: 30,
                        child: SvgPicture.asset(
                          "assets/tw.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    InkWell(
                      onTap: () async {},
                      child: SizedBox(
                        width: 30,
                        child: SvgPicture.asset(
                          "assets/linked.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    InkWell(
                      onTap: () async {},
                      child: SizedBox(
                        width: 30,
                        child: SvgPicture.asset(
                          "assets/insta.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    InkWell(
                      onTap: () async {},
                      child: SizedBox(
                        width: 30,
                        child: SvgPicture.asset(
                          "assets/you.svg",
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ))),
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
