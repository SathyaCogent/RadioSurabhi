import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:radiosurabhi/ui/widgets/app_scaffold.dart';
import 'package:radiosurabhi/ui/widgets/social_button.dart';
import 'package:radiosurabhi/ui/widgets/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUS extends StatelessWidget {
  const ContactUS({Key? key}) : super(key: key);

  @override
  // Future<void> launchUrl(String url) async {
  //   final _canLaunch = await launchUrl(url);

  //   if (url.startsWith("https://www.facebook.com/")) {
  //     const url2 = "https://www.facebook.com/RadioSurabhi";
  //     final intent2 = const AndroidIntent(action: "action_view", data: url2);
  //     final canWork = await intent2.canResolveActivity();
  //     if (canWork!) return intent2.launch();
  //   }
  //   final intent = AndroidIntent(action: "action_view", data: url);
  //   return intent.launch();
  // }

  Widget build(BuildContext context) {
    var screenwidth = MediaQuery.of(context).size.width;
    var screenheight = MediaQuery.of(context).size.height;
    return AppScaffold(
        heading: 'Contact Us',
        appicon: true,
        bottom: true,
        back: true,
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.only(
                    top: 10, left: 20, right: 20, bottom: 10),
                alignment: Alignment.topLeft,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenheight * 0.2,
                        child: Padding(
                          padding: EdgeInsets.only(top: screenheight * 0.04),
                          child: const Textwidget(
                            data: "Reach us",
                            isheading1: false,
                            isheading2: true,
                            isheading3: false,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenheight * 0.02),
                              child: const Textwidget(
                                data: "Radio Surabhi",
                                isheading1: true,
                                isheading2: false,
                                isheading3: false,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenheight * 0.03),
                              child: const Textwidget(
                                data: "2600 MacArthur Blvd",
                                isheading1: false,
                                isheading2: false,
                                isheading3: true,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenheight * 0.01),
                              child: const Textwidget(
                                data: "Lewisville, TX 75067.",
                                isheading1: false,
                                isheading2: false,
                                isheading3: true,
                              ),
                            ),
                            InkWell(
                                onTap: () async {
                                  final Uri launchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'info@radiosurabhi.com',
                                  );
                                  await launchUrl(launchUri);
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: screenheight * 0.03),
                                  child: const Textwidget(
                                    data: "Email: info@radiosurabhi.com",
                                    isheading1: false,
                                    isheading2: false,
                                    isheading3: true,
                                  ),
                                )),
                            InkWell(
                                onTap: () async {
                                  final Uri launchUri = Uri(
                                    scheme: 'tel',
                                    path: '4697010615',
                                  );
                                  await launchUrl(launchUri);
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: screenheight * 0.01),
                                  child: const Textwidget(
                                    data: "Phone: 469-701-0615",
                                    isheading1: false,
                                    isheading2: false,
                                    isheading3: true,
                                  ),
                                )),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenheight * 0.05),
                              child: const Textwidget(
                                data: "Social Links",
                                isheading1: false,
                                isheading2: false,
                                isheading3: true,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenheight * 0.02),
                              child: SizedBox(
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: SizedBox(
                                          width: 30,
                                          child: SvgPicture.asset(
                                            "assets/you.svg",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        onTap: () async {
                                          AndroidIntent intent =
                                              const AndroidIntent(
                                            action: 'action_view',
                                            data:
                                                'https://www.youtube.com/c/RadioSurabhi',
                                          );
                                          await intent.launch();
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: screenwidth * 0.04),
                                        child: InkWell(
                                            onTap: () async {
                                              AndroidIntent intent =
                                                  const AndroidIntent(
                                                action: 'action_view',
                                                data:
                                                    'https://www.facebook.com/RadioSurabhi',
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
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: screenwidth * 0.04),
                                        child: InkWell(
                                            onTap: () async {
                                              AndroidIntent intent =
                                                  const AndroidIntent(
                                                action: 'action_view',
                                                data:
                                                    'https://www.instagram.com/radiosurabhi/',
                                              );
                                              await intent.launch();
                                            },
                                            child: SizedBox(
                                              width: 30,
                                              child: SvgPicture.asset(
                                                "assets/insta.svg",
                                                fit: BoxFit.contain,
                                              ),
                                            )),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      )
                    ]))));
  }
}
