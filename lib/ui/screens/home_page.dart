import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiosurabhi/blocs/archives_bloc.dart';
import 'package:radiosurabhi/blocs/host_bloc.dart';
import 'package:radiosurabhi/blocs/news_bloc.dart';
import 'package:radiosurabhi/blocs/sponsors_bloc.dart';
import 'package:radiosurabhi/ui/routerarguments/newshomepageview_args.dart';

import 'package:radiosurabhi/ui/routerarguments/yourhomepageview_args.dart';
import 'package:radiosurabhi/ui/screens/webview.dart';
import 'package:radiosurabhi/ui/widgets/stream.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';
import 'package:radiosurabhi/ui/widgets/youtubeController.dart';

import '../widgets/app_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static bool popupinfo = true;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool opendrawer = false;
  int _currentsliderindex = 0;

  final CarouselController _controller = CarouselController();
  late ArchiveBloc archiveListBloc;
  late HostsBloc hostListBloc;
  late SponsorsBloc sponsorListBloc;
  late NewsBloc newsListBloc;
  @override
  void initState() {
    super.initState();
    opendrawer = false;
    archiveListBloc = ArchiveBloc();
    archiveListBloc.getArchiveListdata();
    hostListBloc = HostsBloc();
    hostListBloc.getHostsListdata();
    newsListBloc = NewsBloc();
    newsListBloc.getNewsListdata();
    sponsorListBloc = SponsorsBloc();
    sponsorListBloc.getSponsorsListdata();
  }

  var screenwidth, screenheight;
  bool isplaying = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      index: 0,
      appicon: true,
      heading: "Radio Surabhi",
      body: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 10.0, left: 10, right: 10, bottom: 10),
            child: Container(
              width: screenwidth * 0.95,
              height: screenheight * 0.19,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [HexColor("#3747DA"), HexColor("#05CAED")],
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: screenwidth * 0.4,
                              child: Text(
                                'Radio Surabhi',
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ),
                            SizedBox(
                              width: screenwidth * 0.1,
                            ),
                            Text(
                              "100.9 FM HD",
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 18),
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
                                    padding:
                                        EdgeInsets.only(top: screenheight / 70),
                                    child: Text(
                                      "Live Radio",
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w200,
                                          fontSize: 22),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: screenheight / 80),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/helppage');
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "How to Connect",
                                            style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isplaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                color: Colors.white,
                              ),
                              iconSize: screenheight * 0.05,
                              onPressed: () {
                                setState(() {
                                  isplaying = !isplaying;
                                  if (isplaying == false) {
                                    archiveListBloc.getArchiveListdata();
                                    hostListBloc.getHostsListdata();
                                  } else {
                                    Navigator.pushNamed(
                                        context, "/audiopagewebview");
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10),
                child: Textwidget(
                  data: "Who is my host?",
                  isheading1: false,
                  isheading2: false,
                  isheading3: true,
                ),
              ),
              StreamWidget(hostListBloc.hostsListStream, imageCard),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10),
                child: Textwidget(
                  data: "Podcasts/Archives",
                  isheading1: false,
                  isheading2: false,
                  isheading3: true,
                ),
              ),
              StreamWidget(archiveListBloc.archiveListStream, youtubeCard),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10),
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
                  _buildTitle('Our Sponcers'),
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

  Widget youtubeCard(BuildContext context, var dataList) {
    return SizedBox(
      height: screenheight * 0.25,
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
                  padding: const EdgeInsets.only(top: 0.0, left: 10, right: 10),
                  child: Center(
                    child: YoutubeController(
                      url: dataList[index].videoUrl,
                      disableDragSeek: true,
                    ),
                  ),
                ));
          }),
    );
  }

  Widget imageCard(BuildContext context, var imagedatalist) {
    return SizedBox(
      height: screenheight * 0.31,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: imagedatalist.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/yourhosthomepageview',
                    arguments: YourHostHomePageViewArgs(imagedatalist[index]));
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(40)),
                      child: Image.network(
                        imagedatalist[index].imageP,
                        fit: BoxFit.cover,
                        width: screenwidth * 0.40,
                        height: screenheight * 0.33,
                      ),
                    ),
                    Positioned(
                      bottom: screenheight * 0.13,
                      left: screenwidth * 0.04,
                      child: Textwidget(
                        data: imagedatalist[index].programName.toString(),
                        isheading1: false,
                        isheading2: false,
                        isheading3: true,
                        isWhiteColor: true,
                      ),
                    ),
                    Positioned(
                      bottom: screenheight * 0.10,
                      left: screenwidth * 0.04,
                      child: Textwidget(
                        data: imagedatalist[index].name.toString(),
                        isheading1: false,
                        isheading2: false,
                        isheading3: true,
                        isWhiteColor: true,
                      ),
                    ),
                    Positioned(
                      bottom: screenheight * 0.07,
                      left: screenwidth * 0.04,
                      child: Textwidget(
                        data: imagedatalist[index].programDay.toString(),
                        isheading1: false,
                        isheading2: false,
                        isheading3: false,
                        isWhiteColor: true,
                      ),
                    ),
                    Positioned(
                      bottom: screenheight * 0.04,
                      left: screenwidth * 0.04,
                      child: Textwidget(
                        data: imagedatalist[index].programTimings.toString(),
                        isheading1: false,
                        isheading2: false,
                        isheading3: false,
                        isWhiteColor: true,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget newsimageCard(BuildContext context, var newsdatalist) {
    return SizedBox(
      height: screenheight * 0.23,
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
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Image.network(
                  newsdatalist[index].coverImageP,
                  fit: BoxFit.fill,
                  width: screenwidth * 0.65,
                ),
              ),
            );
          }),
    );
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
        child: Image.network(item, fit: BoxFit.cover, width: 1000));
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
