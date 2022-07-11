import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/contact_helper.dart';
import '../models/contact_model.dart';
import '../views/contact_page.dart';

//HELPPER INVOCATION============================================================
ContatctHelper cHelper = ContatctHelper();

//WIDGETS=======================================================================
Widget contactCard(BuildContext context, int index, List<Contact> contacts, Function showContactPage, Function update) {
  return GestureDetector(
    child: Card(
      elevation: 2.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(6.0),
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: _imageIcon(contacts, index),
                  fit: BoxFit.none,
                  scale: 11.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contacts[index].name,
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(contacts[index].email)
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    onTap: () {
      //showContactPage(context: context, contact: contacts[index]);
      _showOptions(context, index, contacts, showContactPage, update);
    },
  );
}

// METODOS======================================================================

_imageIcon(List<Contact> contacts, int index) {
  if (contacts[index].img != null || contacts[index].img.isNotEmpty) {
    return AssetImage("assets/images/person.png");
  } else {
    return FileImage(File(contacts[index].img));
  }
}

void _showOptions(BuildContext context, int index, List<Contact> contacts, Function showContactPage, Function update) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  personalFlatButton(
                    titulo: "Ligar",
                    cor: Colors.green,
                    size: 20.0,
                    function: () {},
                  ),
                  personalFlatButton(
                    titulo: "Editar",
                    cor: Colors.blue,
                    size: 20.0,
                    function: () {
                      Navigator.pop(context);
                      showContactPage(context: context, contact: contacts[index]);
                    },
                  ),
                  personalFlatButton(
                    titulo: "Excluir",
                    cor: Colors.red,
                    size: 20.0,
                    function: () {
                      Navigator.pop(context);
                      cHelper.deleteContact(contacts[index].id!.toInt());
                      update(contacts[index]);
                    },
                  ),
                ],
              ),
            );
          },
        );
      });
}

// WIDGETS ==============================================================================

Widget personalFlatButton(
    {required String titulo, required Color cor, required double size, required Function() function}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextButton(
      onPressed: function,
      child: Text(
        titulo,
        style: TextStyle(
          color: cor,
          fontSize: size,
        ),
      ),
    ),
  );
}
