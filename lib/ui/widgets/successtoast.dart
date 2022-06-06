import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:hexcolor/hexcolor.dart';

class FlutterSuccessToast {
  void offlineToast(BuildContext context, String msg) {
    FToast().removeQueuedCustomToasts();
    FToast().init(context).showToast(
          toastDuration: const Duration(milliseconds: 5000),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  left: BorderSide(color: HexColor('#FF6464'), width: 5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: HexColor('#FF6464'),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30.0))),
                    child: const Icon(
                      Icons.wifi_off,
                      color: Colors.white,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You're offline now",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                    /* Text(
                      "Opps!Internet is disconnected.",
                      style: TextStyle(color: Colors.black, fontSize: 14.0),
                    ),*/
                  ],
                ),
                /*IconButton(
                    onPressed: () {
                      FToast().removeQueuedCustomToasts();
                    },
                    icon: SizedBox(
                        height: 18,
                        width: 18,
                        child: SvgPicture.asset(
                          'assets/images/close.svg',
                        )))*/
              ],
            ),
          ),
          gravity: ToastGravity.TOP,
        );
  }

  void onlineToast(BuildContext context, String msg) {
    FToast().removeQueuedCustomToasts();
    FToast().init(context).showToast(
          toastDuration: const Duration(milliseconds: 5000),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  left: BorderSide(color: HexColor('#46B04A'), width: 5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: HexColor('#46B04A'),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40.0))),
                    child: const Icon(
                      Icons.wifi,
                      color: Colors.white,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "You're online",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Hurray!Internet is connected.",
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                    ),
                  ],
                ),
                /*IconButton(
                    onPressed: () {
                      FToast().removeQueuedCustomToasts();
                    },
                    icon: SizedBox(
                        height: 18,
                        width: 18,
                        child: SvgPicture.asset(
                          'assets/images/closeGreen.svg',
                        )))*/
              ],
            ),
          ),
          gravity: ToastGravity.TOP,
        );
  }
}
