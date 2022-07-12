import 'package:agenda_de_contatos/src/helpers/contact_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agenda_de_contatos/src/models/contact_model.dart';
import 'package:agenda_de_contatos/src/views/contact_page.dart';
import 'package:agenda_de_contatos/src/widgets/home_page_contactCard.dart';
import 'package:agenda_de_contatos/src/utils/personal_colors.dart';
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

  //METODO ESPECIAL=====================================================================
  Future loadContacts() async {
    return contacts = await cHelper.getAllContacts() ??
        [Contact(name: 'name', email: 'email', phone: 'phone', img: 'img')];
  }

  //BUILDER=====================================================================
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadContacts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return homePageWidget();
        } else if (snapshot.hasError) {
          return const Center(
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
    print("heelo ");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("CONTATOS", style: GoogleFonts.inter(color: MyPersonalColors.cardColor,fontWeight:FontWeight.bold,fontSize: 20,),),
          backgroundColor: MyPersonalColors.primaria,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          toolbarHeight: 80,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showContactPage(context: context);
          },
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
        return contactCard(
            context, index, contacts, showContactPage, deleteAndSetState);
      },
      padding: EdgeInsets.only(left: 13, right:13, top:20),
    );
  }

  //METODOS=====================================================================
  Future<void> deleteAndSetState(Contact? contact) async {
    if (contact == null) {
      List<Contact> l = await cHelper.getAllContacts() ?? [];
      setState(() {
        contacts = l;
      });
      return;
    }
    cHelper.deleteContact(contact.id!.toInt());
    List<Contact> l = await cHelper.getAllContacts() ?? [];
    setState(() {
      contacts = l;
    });
  }

  Future<void> loadAndSetState() async {
    List<Contact> l = await cHelper.getAllContacts() ?? [];
    setState(() {
      contacts = l;
    });
  }

  Future<void> showContactPage(
      {required BuildContext context, Contact? contact}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(contact: contact),
      ),
    );
    if (recContact != null) {
      if (contact != null) {
        await cHelper.updateContact(recContact);
        loadAndSetState();
      } else {
        await cHelper.saveContact(recContact);
        loadAndSetState();
      }
    }

    List<Contact> l = await cHelper.getAllContacts() ?? [];
    setState(() {
      contacts = l;
    });
  }
}
