import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class StreamWidget extends StatefulWidget {
  const StreamWidget(this.stream, this.body,
      {Key? key, this.loadingWidget, this.showpop = false})
      : super(key: key);

  final Stream stream;
  final Widget Function(BuildContext, Object?) body;
  final Widget? loadingWidget;
  final bool showpop;
  @override
  State<StreamWidget> createState() => _StreamWidgetState();
}

class _StreamWidgetState extends State<StreamWidget> {
  bool popupopen = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (widget.showpop) {
        popupopen = true;
        popup(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget ??
              Center(
                child: Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            HexColor('#46B04A')))),
              );
        } else {
          if (snapshot.hasData && widget.showpop && popupopen) {
            Navigator.of(context).pop();
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              setState(() {
                popupopen = false;
              });
            });
          }

          return snapshot.hasData
              ? SingleChildScrollView(
                  child: widget.body(context, snapshot.data))
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.do_disturb_sharp,
                      size: 100,
                    ),
                    Text("No data found",
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ));
        }
      },
    );
  }

  Future<bool> onBack() async {
    return (navigator()) ?? false;
  }

  navigator() {
    if (popupopen == true) {
      Navigator.of(context).pop();
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        setState(() {
          popupopen = false;
        });
      });
    }
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }

  Future<void> popup(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: onBack,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: HexColor("#F4F4F4"),
                content: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        'Syncing your List',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                            color: HexColor('#1d6d3e'),
                            fontFamily: "Roboto"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Please wait while we restore your details. It would take less then minute',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.grey,
                            fontFamily: "Roboto"),
                      )
                    ])),
              );
            }));
      },
    );
  }
}
