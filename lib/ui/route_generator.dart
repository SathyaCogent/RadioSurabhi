import 'package:flutter/material.dart';
import 'package:radiosurabhi/ui/routerarguments/newshomepageview_args.dart';

import 'package:radiosurabhi/ui/screens/aboutus.dart';
import 'package:radiosurabhi/ui/screens/archives.dart';
import 'package:radiosurabhi/ui/screens/audioWebView.dart';
import 'package:radiosurabhi/ui/screens/contactus.dart';
import 'package:radiosurabhi/ui/screens/help.dart';
import 'package:radiosurabhi/ui/screens/news.dart';
import 'package:radiosurabhi/ui/screens/news_homepageview.dart';
import 'package:radiosurabhi/ui/screens/shows.dart';
import 'package:radiosurabhi/ui/screens/splash_screen.dart';
import 'package:radiosurabhi/ui/screens/yourhost.dart';
import 'package:radiosurabhi/ui/screens/yourhost_homepageview.dart';
import 'package:radiosurabhi/ui/widgets/audio.dart';

import 'routerarguments/yourhomepageview_args.dart';
import 'screens/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/homepage':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/yourhost':
        return MaterialPageRoute(builder: (_) => const Yourhost());
      case '/yourhosthomepageview':
        final yourhosthomepageviewargs =
            settings.arguments as YourHostHomePageViewArgs;
        YourHostHomePageViewArgs yourhostviewargs = yourhosthomepageviewargs;
        return MaterialPageRoute(
            builder: (_) => Yourhosthomepageview(
                  hostdata: yourhostviewargs.hostDetail,
                ));
      case '/archives':
        return MaterialPageRoute(builder: (_) => const Archives());
      case '/newspage':
        return MaterialPageRoute(builder: (_) => const NewsListPage());
      case '/testimonials':
        return MaterialPageRoute(
            builder: (_) => const Archives(
                  istestimonials: true,
                ));
      case '/newshomepageview':
        NewsHomePageViewArgs newsviewargs =
            settings.arguments as NewsHomePageViewArgs;
        return MaterialPageRoute(
            builder: (_) => Newshomepageview(
                  newsdata: newsviewargs.newsData,
                ));
      case '/aboutus':
        return MaterialPageRoute(builder: (_) => const Aboutus());
      case '/contactus':
        return MaterialPageRoute(builder: (_) => const ContactUS());
      case '/helppage':
        return MaterialPageRoute(builder: (_) => const HelpPage());
      case '/showspage':
        return MaterialPageRoute(builder: (_) => const ShowsPage());
      case '/audiopagewebview':
        return MaterialPageRoute(builder: (_) => const AudioWebViewPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Page not Found'),
        ),
      );
    });
  }
}

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }
}
