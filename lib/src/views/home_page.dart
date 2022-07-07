import 'package:agenda_de_contatos/src/helpers/contact_helper.dart';
import 'package:agenda_de_contatos/src/models/contact_model.dart';
import 'package:agenda_de_contatos/src/widgets/home_page_contactCard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //VARIAVEIS====================================================================
  ContatctHelper cHelper = ContatctHelper();
  late List<Contact> contacts;

  //OVERRIDES===================================================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Carregar a lista de contatos
    cHelper.getAllContacts().then((value) => contacts = value!);
  }

  //BUILDER=====================================================================
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contatos"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Colors.red,
        ),
        body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return contactCard(context, index);
          },
          padding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }
}
