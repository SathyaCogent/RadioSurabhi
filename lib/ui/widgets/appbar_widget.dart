import 'package:flutter/material.dart';
import 'package:radiosurabhi/ui/widgets/ripple.dart';

Widget appBarWidget(context) {
  return Container(
    padding: const EdgeInsets.all(10),
    color: Colors.blue,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipRRect(
          borderRadius:const BorderRadius.all(Radius.circular(13)),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              boxShadow:const <BoxShadow>[
                BoxShadow(
                    color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 10),
              ],
            ),
            child: Icon(
              Icons.call,
              size: 45,
              color: Colors.brown[900],
            ),
          ),
        ).ripple(() {}, borderRadius: const BorderRadius.all(Radius.circular(13))),
      const  RotatedBox(
          quarterTurns: 4,
          child: Icon(
            Icons.clear_all,
            color: Colors.black54,
            size: 45,
          ),
        )
      ],
    ),
  );
}
