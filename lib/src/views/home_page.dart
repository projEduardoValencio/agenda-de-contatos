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
    loadContacts();
  }

  Future loadContacts() async {
    await cHelper.getAllContacts().then((value) => contacts = value!);
  }

  //BUILDER=====================================================================
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadContacts(),
      initialData: Center(child: CircularProgressIndicator()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return homePageWidget();
        } else if (snapshot.hasError) {
          return Center(
            child: Text("ERROR"),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //WIDGETS====================================================================
  SafeArea homePageWidget() {
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
        body: listContactBuilder(),
      ),
    );
  }

  ListView listContactBuilder() {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return contactCard(context, index, contacts);
      },
      padding: EdgeInsets.all(8.0),
    );
  }
}
