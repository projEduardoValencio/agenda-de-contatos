import 'package:agenda_de_contatos/src/views/contact_page.dart';
import 'package:agenda_de_contatos/src/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.inter().fontFamily,
        ),
      home: HomePage(),
    );
  }
}
//Add comment
//Comment in NeoVim
