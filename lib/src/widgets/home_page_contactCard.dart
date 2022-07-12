import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agenda_de_contatos/src/utils/personal_colors.dart';

import '../helpers/contact_helper.dart';
import '../models/contact_model.dart';
import '../utils/paths.dart';
import '../views/contact_page.dart';

//HELPPER INVOCATION============================================================
ContatctHelper cHelper = ContatctHelper();

//WIDGETS=======================================================================
Widget contactCard(BuildContext context, int index, List<Contact> contacts,
    Function showContactPage, Function update) {
  return GestureDetector(
    child: Card(
      margin: EdgeInsets.only(bottom: 20),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(11.0),
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: verifyImg(contacts, index),
                fit: BoxFit.none,
                scale: 11.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contacts[index].name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    color: MyPersonalColors.primaria,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  contacts[index].email,
                  style: TextStyle(
                    color: MyPersonalColors.cinza,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          Icon(Icons.more_vert),
          SizedBox(
            width: 10,
          )
        ],
      ),
    ),
    onTap: () {
      //showContactPage(context: context, contact: contacts[index]);
      _showOptions(context, index, contacts, showContactPage, update);
    },
  );
}

// METODOS======================================================================

verifyImg(List<Contact> contacts, int index) {
  if (contacts[index].img.isEmpty) {
    return AssetImage(PersonalPath.person);
  } else {
    return FileImage(File(contacts[index].img));
  }
}

void _showOptions(BuildContext context, int index, List<Contact> contacts,
    Function showContactPage, Function update) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      builder: (context) {
        return BottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
          ),
          onClosing: () {},
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    contacts[index].name,
                    style: TextStyle(
                        color: MyPersonalColors.primaria,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    contacts[index].phone,
                    style: TextStyle(
                        color: MyPersonalColors.cinza,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    contacts[index].email,
                    style: TextStyle(
                        color: MyPersonalColors.cinza,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Botao de ligar
                      personalFlatButton(
                        titulo: "Ligar",
                        cor: MyPersonalColors.verde,
                        icone: Icon(Icons.phone, color: MyPersonalColors.verde),
                        size: 20.0,
                        function: () async {
                          Navigator.pop(context);
                          await launchUrl(
                              Uri.parse("tel:${contacts[index].phone}"));
                        },
                      ),
                      Expanded(child: SizedBox()),
                      //Botao de Editar
                      personalFlatButton(
                        titulo: "Editar",
                        cor: MyPersonalColors.primaria,
                        icone:
                            Icon(Icons.edit, color: MyPersonalColors.primaria),
                        size: 20.0,
                        function: () {
                          Navigator.pop(context);
                          showContactPage(
                              context: context, contact: contacts[index]);
                        },
                      ),
                      Expanded(child: SizedBox()),
                      //Botao de Excluir
                      personalFlatButton(
                        titulo: "Apagar",
                        cor: MyPersonalColors.vermelho,
                        icone: Icon(Icons.delete_sharp,
                            color: MyPersonalColors.vermelho),
                        size: 20.0,
                        function: () {
                          Navigator.pop(context);
                          cHelper.deleteContact(contacts[index].id!.toInt());
                          update(contacts[index]);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      });
}

// WIDGETS ==============================================================================

Widget personalFlatButton({
  required String titulo,
  required Color cor,
  required double size,
  required Function() function,
  required Icon icone,
}) {
  final double hmed = 80;
  final double wmed = 120;
  return Container(
    height: hmed,
    width: wmed,
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: function,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icone,
          Text(
            titulo,
            style: TextStyle(
                color: cor, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    ),
  );
}
