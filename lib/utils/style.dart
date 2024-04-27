import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/size.dart';

Color background = Color.fromARGB(255, 255, 255, 255);
Color userChat = Color.fromARGB(255, 127, 189, 251);
Color resChat = Color.fromARGB(255, 188, 216, 143);
Color chatColor = const Color(0xFF47698A);
var black = Color.fromARGB(255, 0, 0, 0);
Color hintColor = const Color(0xFF47698A);

TextStyle messageText = GoogleFonts.poppins(color: black, fontSize: small);
TextStyle appBarTitle =
    GoogleFonts.poppins(color: black, fontWeight: FontWeight.bold);
TextStyle hintText = GoogleFonts.poppins(color: hintColor, fontSize: small);
TextStyle dateText = GoogleFonts.poppins(color: black, fontSize: 13);
TextStyle promptText = GoogleFonts.poppins(color: black, fontSize: small);
