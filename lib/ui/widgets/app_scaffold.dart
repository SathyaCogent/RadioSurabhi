import 'package:flutter/material.dart';

import 'appbar_widget.dart';

class AppScaffold extends StatefulWidget {
  final int index;
  const AppScaffold(
      {Key? key,
      this.child,
      this.heading,
      this.index = 0,
      this.logout = false,
      this.back = false})
      : super(key: key);
  final Widget? child;
  final bool logout, back;
  final String? heading;
  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  /*final List<Widget> viewContainer = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    Myorders(),
  ];*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context),
        ),
        body: widget.child!,
        // bottomNavigationBar: BottomNavBarWidget(widget.index),
      ),
    );
  }
}
