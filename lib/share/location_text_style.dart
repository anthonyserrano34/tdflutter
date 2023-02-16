import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:td_flutter/share/location_style.dart';

class LocationTextStyle {
  static final baseTextStyle =
      GoogleFonts.getFont('Raleway').copyWith(color: LocationStyle.colorPurple);

  static final regularTextStyle = baseTextStyle.copyWith(fontSize: 13);

  static final regularWhiteTextStyle = baseTextStyle.copyWith(
    fontSize: 13,
    color: Colors.white70,
  );

  static final priceTextStyle = baseTextStyle.copyWith(
    fontSize: 16,
    color: Colors.white70,
    fontWeight: FontWeight.bold,
  );

  static final priceGreyTextStyle = priceTextStyle.copyWith(
    color: Colors.grey,
  );

  static final regularGreyTextStyle = regularTextStyle.copyWith(
    color: Colors.grey,
    fontSize: 13,
  );

  static final subtitleBoldTextStyle = baseTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static final boldTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.bold,
  );
}
