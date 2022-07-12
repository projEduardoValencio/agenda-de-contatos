import 'dart:io';

import 'package:agenda_de_contatos/main.dart';
import 'package:agenda_de_contatos/src/models/contact_model.dart';
import 'package:agenda_de_contatos/src/utils/paths.dart';
import 'package:agenda_de_contatos/src/utils/personal_colors.dart';
import 'package:agenda_de_contatos/src/widgets/home_page_contactCard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  final ImagePicker picker = ImagePicker();
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
            title: Text(
              _editedContact.name.isEmpty
                  ? "Novo contato"
                  : _editedContact.name,
              style: TextStyle(
                color: MyPersonalColors.cardColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            backgroundColor: MyPersonalColors.primaria,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            toolbarHeight: 80,
            elevation: 6,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => saveContact(),
            child: Icon(Icons.save),
            backgroundColor: Colors.red,
          ),
          backgroundColor: MyPersonalColors.fundo,
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Card(
              color: MyPersonalColors.cardColor,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(right: 12, left: 12, top: 15, bottom: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 15),
                    iconImage(),
                    SizedBox(height: 30),
                    //NOME
                    Container(
                      height: 64,
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        focusNode: _nameFocus,
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Nome",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelStyle: TextStyle(fontSize: 18),
                        ),
                        //estilo do texto
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyPersonalColors.primaria,
                          fontSize: 24,
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //EMAIL
                    Container(
                      height: 64,
                      child: TextField(
                        focusNode: _emailFocus,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelStyle: TextStyle(fontSize: 18),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyPersonalColors.cinza,
                          fontSize: 20,
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //PHONE
                    Container(
                      height: 64,
                      child: TextField(
                        focusNode: _phoneFocus,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "Phone",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          labelStyle: TextStyle(fontSize: 18),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyPersonalColors.cinza,
                          fontSize: 20,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (text) {
                          _userEdited = true;

                          _editedContact.phone = text;
                        },
                        onSubmitted: (_) => saveContact(),
                      ),
                    ),
                  ],
                ),
              ),
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
        width: 160.0,
        height: 160.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: verifyImg(),
            fit: _editedContact.img.isEmpty ? BoxFit.none : BoxFit.cover,
            scale: 4.0,
          ),
        ),
      ),
      onTap: () {
        ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
          if (value == null) {
            return;
          }
          setState(() {
            _editedContact.img = value.path;
          });
        });
      },
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
