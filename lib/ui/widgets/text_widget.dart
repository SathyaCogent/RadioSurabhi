import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textwidget extends StatelessWidget {
  final String? data;
  final bool isheading1;
  final bool isheading2;
  final bool isheading3;
  final bool isWhiteColor;

  const Textwidget({
    Key? key,
    this.data,
    this.isheading1 = false,
    this.isheading2 = false,
    this.isheading3 = false,
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
              : isheading1 || isheading2 || isheading3
                  ? Colors.black
                  : Colors.black87,
          fontWeight: isheading1 || isheading2 || isheading3
              ? FontWeight.bold
              : FontWeight.normal,
          fontSize: isheading1
              ? 35
              : isheading2
                  ? 20
                  : isheading3
                      ? 12
                      : 12),
    );
  }
}
