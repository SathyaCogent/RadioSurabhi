import 'package:flutter/material.dart';
import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return AppScaffold(
      appicon: true,
      back: true,
      heading: 'About Us',
      body: SingleChildScrollView(
        child: Container(
          padding:
              const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
          alignment: Alignment.topLeft,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Textwidget(
                    data: "About us",
                    isheading1: true,
                    isheading2: false,
                    isheading3: false,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Textwidget(
                    data: "Our Story",
                    isheading1: false,
                    isheading2: true,
                    isheading3: false,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                      "Radio Surabhi, the most sought-after Telugu Radio Show in Dallas Metroplex since 2018. We cater to the Telugu speaking Indian community in DFW Metroplex. Hosted on FunAsia the media giant in North America serving exclusively to the South Asian market.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                      "FunAsia has revolutionized the radio into digital media and hence enabling Radio Surabhi, to connect with our listeners on the Radio and also via BigFANTV the app on Apple TV, Android, Roku, Amazon Fire Stick, Samsung Tizen and other iOS and Android devices.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Center(
                    child: imagecard(context, 'assets/images/aboutus01.jpg',
                        screenwidth, screenheight),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                      "With much love from the community, and support from our loyal listeners, we are now taking the big leap in bringing the Telugu community 24 hours of Entertainment from Telugu Cinema, Music, Culture, History and Arts. We promise you well rounded entertainment 24 hours a day and 7 days a week.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                      "We will be a singular voice in delivering our advertisers' message to our listeners.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Textwidget(
                    data: "About our visionary",
                    isheading1: false,
                    isheading2: true,
                    isheading3: false,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                      "Inspired, motivated and influenced by Radio, Drama and Voice overs since childhood Rajeswari is highly passionate about these art forms. From being an introvert to transforming into an influential personality, there is a great story behind. Started off into the Media and Entertainment industry as one of the youngest AIR Hyderabad voice artists, moving into the then budding Satellite television channels as an Anchor, then an Artist and then dubbing Telugu Heroiene's voice for 27 movies in just one year she has created her own mark.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                      "Her high intensity drive to be the best person on stage or wherever she is, drove her into being the most sought after Master of Ceremonies in the USA for major celebrity events since 2006.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                      "Founder/Director of Sarasija Theaters' the first ever Telugu theater in the United States to take on the flickering torch of Telugu Drama and pass it on to light up more torches and shine bright. With full house shows of unique productions Sarasija Theaters stands tall in the world of Telugu Drama.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: imagecard(context, 'assets/images/aboutus02.jpg',
                        screenwidth, screenheight),
                  ),
                ),
                //  Image.asset('assets/images/aboutus02.jpg'),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                      "Her fascination for Voice works and Radio pushed her to put a fullstop to her 22 years of corporate life and start Radio Surabhi. 4 years ago, this show started as a Weekend show only with FunAsia 104.9 FM, with complete dedication and with a group of amazingly talented friends in Dallas today Radio Surabhi is going as a full on 24 hours Live Telugu programming set with a dedicated studio for itself.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                      "Joy, happiness, fun, laughter, entertainment, infotainment, inclusivity it has all in it. We want to be your friend, your partner, your ally, your confidant, your escort …everything…just make us your companion in your daily life.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Textwidget(
                    data: "Benefits of Media Sponsorship",
                    isheading1: false,
                    isheading2: true,
                    isheading3: false,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                      "The extent of benefits you will receive will vary depending on your level of involvement. Based on past experience with sponsors and market research, we can promise you the following possibilities:",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("One- on-one interaction with your target market",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: imagecard(
                        context,
                        'assets/images/aboutus_ononone1.jpg',
                        screenwidth,
                        screenheight),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                      "We’ve reached out to you because we know that your target customers will comprise a large portion of our listener base. Whether it be through recorded advertisement or live announcement during our radio shows or latest technological and revolutionized Radio techniques in the digital world, we give you direct access to the people you can typically only access through online or printed advertising. Take advantage of this personal access to generate better, stronger leads, ensuring increased sales.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("Better customer engagement and loyalty",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: imagecard(
                        context,
                        'assets/images/aboutus_ononone2.jpg',
                        screenwidth,
                        screenheight),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                      "We give plenty of opportunities to get your name up and seen by hundreds of people, whether or not they are our regular listeners who tune in every weekend. You have the chance to have your name plastered across the banner, visible to all listeners across all platforms including our Social Media base. You'll be included in special shows, at the very least, guests will see your brand on the program, Social Media and our website. No matter where they see it, it will be in the context of supporting your cause. They say that all publicity is good publicity, but this is surely the best publicity.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("Better customer engagement and loyalty",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: imagecard(
                        context,
                        'assets/images/aboutus_ononone3.jpg',
                        screenwidth,
                        screenheight),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                      "Not only does it cost 5x more to acquire a new customer than it does to keep an existing customer, but loyal customers spend 67%more than do new ones. Regular contact is key to building these relationships, but short of hosting your own event, how often do you get to interact with your customers outside of your or their place of business? Is an opportunity to get feedback on your business, talk about their needs, and answer questions, and fill them in on any offer or special events on the horizon.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("Great ROI",
                      style: TextStyle(fontSize: 15, height: 1.6)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: imagecard(
                        context,
                        'assets/images/aboutus_ononone4.jpg',
                        screenwidth,
                        screenheight),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                      "Whatever option you choose, ask yourself this: How many chances will you get to advertise to an audience tailored to your offering? You can be sure that every cent of your sponsorship money will be dedicated to this audience, offering a higher return on investment than any ad elsewhere ever offers you.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Textwidget(
                    data: "Reach",
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
                        'assets/images/about_reach_map.jpg',
                        screenwidth,
                        screenheight),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                      "KZMP-FM (104.9 MHz) is a commercial FM radio station licensed to Pilot Point, Texas, and serving the Dallas-Fort Worth Metroplex. KZMP-FM is owned by Estrella Media and operated by FunAsia[1] under a local marketing agreement (LMA). Fun Asia - KZMP-FM is a broadcast radio station from Pilot Point, TX, United States, providing South Asian, Bollywood music, information, talks and entertainment. The station broadcasts mainly in English, but also has programs in other South Asian languages – Hindi, Punjabi, Bengali, Gujarati, Telugu and Persian. KZMP-FM's studios and offices are located in Dallas, while the transmitter is located west of Collinsville in Cooke County.",
                      style: TextStyle(fontSize: 14, height: 1.6)),
                ),
              ]),
        ),
      ),
    );
  }

  Widget imagecard(BuildContext context, String assetname, double screenwidth,
      double screenheight) {
    return Image.asset(
      assetname,
      width: screenwidth * 0.8,
      height: screenheight * 0.3,
      fit: BoxFit.contain,
    );
  }
}
