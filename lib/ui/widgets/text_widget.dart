import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textwidget extends StatelessWidget {
  final String? data;
  final bool isheading1;
  final bool isheading2;
  final bool isheading3;
  final bool isheading4;
  final bool isWhiteColor;

  const Textwidget({
    Key? key,
    this.data,
    this.isheading1 = false,
    this.isheading2 = false,
    this.isheading3 = false,
    this.isheading4 = false,
    this.isWhiteColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data!,
      softWrap: true,
      style: GoogleFonts.roboto(
          color: isWhiteColor
              ? Colors.white
              : isheading1 || isheading2 || isheading3 || isheading4
                  ? Colors.black
                  : Colors.black87,
          fontWeight: isheading1 || isheading2 || isheading3 || isheading4
              ? FontWeight.bold
              : FontWeight.normal,
          fontSize: isheading1
              ? MediaQuery.of(context).size.width * 0.05
              : isheading2
                  ? MediaQuery.of(context).size.width * 0.045
                  : isheading3
                      ? MediaQuery.of(context).size.width * 0.030
                      : isheading4
                          ? 14
                          : MediaQuery.of(context).size.width * 0.025),
    );
  }
}
