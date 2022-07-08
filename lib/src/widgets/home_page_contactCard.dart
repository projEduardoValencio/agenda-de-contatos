import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helpers/contact_helper.dart';
import '../models/contact_model.dart';
import '../views/contact_page.dart';

//HELPPER INVOCATION============================================================
ContatctHelper cHelper = ContatctHelper();

//WIDGETS=======================================================================
Widget contactCard(BuildContext context, int index, List<Contact> contacts,
    Function showContactPage) {
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
      showContactPage(context: context, contact: contacts[index]);
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
