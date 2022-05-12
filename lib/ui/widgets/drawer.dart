import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiosurabhi/ui/screens/aboutus.dart';
import 'package:radiosurabhi/ui/screens/webview.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:radiosurabhi/ui/widgets/social_button.dart';
import '../widgets/social_button.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  DrawerMenuState createState() => DrawerMenuState();
}

class DrawerMenuState extends State<DrawerMenu>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  bool opendrawer = false;
  int _currentsliderindex = 0;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-'
        '675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&'
        's=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  ];
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
    super.initState();
    opendrawer = false;
  }

  var screenwidth, screenheight;
  bool isplaying = false;
  List? singerImage = [
    "assets/images/boy.jpg",
    "assets/images/girl.jpg",
    "assets/images/boy.jpg",
    "assets/images/girl.jpg",
    "assets/images/boy.jpg",
  ];
  Widget imageCard(BuildContext context) {
    return SizedBox(
      height: screenheight * 0.3,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: screenwidth * 0.43,
                height: screenheight * 0.3,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(40)),
                  child: Image.asset(
                    singerImage![index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenwidth = MediaQuery.of(context).size.width;
    screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        //first scaffold

        appBar: AppBar(
          elevation: 0,
          backgroundColor: HexColor("#3b29a1"),
          title: const Text("Radio Surabhi "),
          automaticallyImplyLeading: false,
          //   centerTitle: true,
          leadingWidth: 55,
          leading: Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.0),
              child: Image.asset(
                "assets/App-icon.gif",
              )),
          actions: [
            IconButton(
              onPressed: () {
                //on drawer menu pressed
                if (_drawerscaffoldkey.currentState!.isEndDrawerOpen) {
                  //if drawer is open, then close the drawer
                  Navigator.pop(context);
                  setState(() {
                    opendrawer = false;
                  });
                } else {
                  _drawerscaffoldkey.currentState!.openEndDrawer();
                  //if drawer is closed then open the drawer.
                  setState(() {
                    opendrawer = true;
                  });
                }
              },
              icon: opendrawer
                  ? const Icon(
                      Icons.close,
                      size: 30,
                    )
                  : const Icon(
                      Icons.menu,
                      size: 30,
                    ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        body: Scaffold(
            key: _drawerscaffoldkey,
            endDrawer: Drawer(
                child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor("#3b29a1"),
                  HexColor("#ab3c90"),
                ],
              )),
              child: Column(children: <Widget>[
                Expanded(
                    child: Container(
                        // decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        //   colors: [
                        //     HexColor("#3b29a1"),
                        //     HexColor("#ab3c90"),
                        //   ],
                        // )),
                        child: ListView(
                            padding: const EdgeInsets.all(0.0),
                            children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      const ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text('YOUR HOST',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      const Divider(color: Colors.white),
                      const ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text('SHOWS',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      const Divider(color: Colors.white),
                      const ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text('NEWS',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      /*    Divider(color: Colors.white),
                              ListTile(
                                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                title: Text('kids',
                                    style: TextStyle(fontSize: 15, color: Colors.white)),
                              ),*/
                      const Divider(color: Colors.white),
                      ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        title: const Text('ABOUT US',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                        onTap: () async {
                          // toWebView(context,
                          //     "http://www.radiosurabhi.com/aboutus.html",
                          //     title: 'About Us');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Aboutus()),
                          );
                        },
                      ),
                      const Divider(color: Colors.white),
                      const ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text('SHARE',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      const Divider(color: Colors.white),
                      const ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text('SCHEDULES',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      const Divider(color: Colors.white),
                      const ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text('TESTIMONIALS',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      const Divider(color: Colors.white),
                      const ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        title: Text('HELP',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ),
                      const Divider(color: Colors.white),
                    ]))),
                Container(
                    /*decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      HexColor("#ab3c90"),
                      HexColor("#ab3c90"),
                    ],
                  )),*/
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Column(
                          children: <Widget>[
                            const ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              title: Text('Social Media Connect',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.width * 0.06,
                                left: MediaQuery.of(context).size.width * 0.055,
                              ),
                              child: Row(
                                children: [
                                  const NeuButton(
                                    char: 'G',
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  const NeuButton(
                                    char: 'f',
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  const NeuButton(
                                    char: 'T',
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                  ),
                                  const NeuButton(
                                    char: 'I',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
              ]),
            )),
            body: buildContent(context, screenheight, screenwidth)));
  }

  Widget buildContent(BuildContext context, screenheight, screemwidth) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: screenwidth * 0.95,
                height: screenheight * 0.15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    colors: [HexColor("#1089b8"), HexColor("#569abe")],
                  ),
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(40)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: screenwidth * 0.4,
                                child: const Text(
                                  'Radio Surabhi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                              ),
                              const Text(
                                "100.9 FM HD",
                                style: TextStyle(
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
                                      padding: EdgeInsets.only(
                                          top: screenheight / 70),
                                      child: const Text(
                                        "Live Radio",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: screenheight / 80),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text(
                                            "How to Connect",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                                fontSize: 18),
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
            !isplaying
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0, top: 10),
                        child: Text("Who is my host?"),
                      ),
                      imageCard(context),
                      const Padding(
                        padding: EdgeInsets.only(left: 18.0, top: 10),
                        child: Text("Playback Singers"),
                      ),
                      imageCard(context),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/radio_dashboard_image.jpg",
                            height: screenheight * 0.7,
                            width: screenwidth * 0.97,
                            fit: BoxFit.fill,
                          ),
                        )
                      ],
                    ),
                  ),
            Align(
                alignment: Alignment.bottomCenter,
                // _buildTitle('Top Brands'),
                child: Column(
                  children: [
                    _buildTitle('Our Sponcers'),
                    _buildSlider(),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildSlider() {
    return Container(
        //margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(children: [
      const SizedBox(
        height: 10,
      ),
      CarouselSlider.builder(
          itemCount: imgList.length,
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
            return _buildSliderItem(context, imgList[index]);
          }),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: imgList.asMap().entries.map((entry) {
          //int pageIndex = imgList.indexOf(url);
          return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 30.0,
                height: 5.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 9.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: _currentsliderindex == entry.key
                      ? Colors.red
                      : const Color(0xffc5d2da),
                ),
              ));
        }).toList(),
      ),
    ]));
  }

  Widget _buildSliderItem(BuildContext context, String item) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Image.network(item, fit: BoxFit.cover, width: 1000));
  }

  Widget _buildTitle(String title) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Text(title,
            style: const TextStyle(fontSize: 20, color: Colors.black)));
  }
  /*Widget buildSliders() {
    return Container(
      //padding: EdgeInsets.all(15),
      child: CarouselSlider(
        options: CarouselOptions(
            aspectRatio: 2.4,
            viewportFraction: 1,
            autoPlay: true,
            enlargeCenterPage: true),
        items: imgList.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Image.network(
                url,
                fit: BoxFit.cover,
              );
            },
          );
        }).toList(),
      ),
    );
  }*/

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
