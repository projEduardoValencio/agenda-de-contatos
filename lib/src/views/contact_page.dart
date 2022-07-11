import 'dart:io';

import 'package:agenda_de_contatos/main.dart';
import 'package:agenda_de_contatos/src/models/contact_model.dart';
import 'package:agenda_de_contatos/src/utils/paths.dart';
import 'package:agenda_de_contatos/src/widgets/home_page_contactCard.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  ContactPage({Key? key, this.contact}) : super(key: key);

  final Contact? contact;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  //VARIAVEIS===============================================================
  late Contact _editedContact;
  bool _userEdited = false;

  //CONTROLADORES
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();

  //OVERRIDE==================================================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.contact == null) {
      _editedContact = Contact.empty();
    } else {
      _editedContact = Contact.fromMap(widget.contact!.toMap());

      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  //BUILD===================================================================
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (!_userEdited) {
            return true;
          }
          final shouldPop = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Voce tem certeza de que deseja sair?"),
                content: Text("As alterações serão perdidas"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: Text("Yes"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text("No"),
                  ),
                ],
              );
            },
          );
          return shouldPop;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(_editedContact.name.isEmpty ? "Novo contato" : _editedContact.name),
            centerTitle: true,
            backgroundColor: Colors.red,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => saveContact(),
            child: Icon(Icons.save),
            backgroundColor: Colors.red,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 15),
                iconImage(),
                SizedBox(height: 15),
                //NOME
                TextField(
                  focusNode: _nameFocus,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Nome",
                  ),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editedContact.name = text;
                    });
                  },
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_emailFocus);
                  },
                ),
                //EMAIL
                TextField(
                  focusNode: _emailFocus,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (text) {
                    _userEdited = true;

                    _editedContact.email = text;
                  },
                  onSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_phoneFocus);
                  },
                ),
                //PHONE
                TextField(
                  focusNode: _phoneFocus,
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: "Phone",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    _userEdited = true;

                    _editedContact.phone = text;
                  },
                  onSubmitted: (_) => saveContact(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //WIDGETS=====================================================================
  GestureDetector iconImage() {
    return GestureDetector(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: verifyImg(),
            fit: BoxFit.none,
            scale: 4.0,
          ),
        ),
      ),
    );
  }

  //METODOS=====================================================================
  verifyImg() {
    if (_editedContact.img.isEmpty) {
      return AssetImage(PersonalPath.person);
    } else {
      return FileImage(File(_editedContact.img));
    }
  }

  saveContact() {
    if (_editedContact.name.isNotEmpty && _editedContact.name != null) {
      Navigator.pop(context, _editedContact);
    } else {
      FocusScope.of(context).requestFocus(_nameFocus);
    }
  }
}
