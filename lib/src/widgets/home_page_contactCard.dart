import 'dart:html' as h;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/contact_model.dart';

Widget contactCard(BuildContext context, int index, List<Contact> contacts) {
  return GestureDetector(
    child: Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Row(
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageIcon(contacts, index),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

imageIcon(List<Contact> contacts, int index) {
  if (contacts[index].img != null || contacts[index].img.isNotEmpty) {
    return AssetImage("assets/images/person.png");
  } else {
    return FileImage(File(contacts[index].img));
  }
}
