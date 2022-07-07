import 'package:agenda_de_contatos/src/helpers/contact_helper.dart';
import 'package:agenda_de_contatos/src/models/contact_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //VARIAVEIS====================================================================
  ContatctHelper cHelper = ContatctHelper();

  //OVERRIDES===================================================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // cHelper.saveContact(
    //   Contact(
    //     name: "Leonardo",
    //     email: "leonardo@gmail.com",
    //     phone: "14 5555 5555",
    //     img: "leo.image.png",
    //   ),
    // );
    cHelper.getAllContacts().then((value) => print(value));
  }

  //BUILDER=====================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
