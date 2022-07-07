import '../helpers/contact_helper.dart';

class Contact {
  int? id;
  late String name;
  late String email;
  late String phone;
  late String img;

  Contact.fromMap(Map map) {
    id = map[DataBaseColumns.idColumn];
    name = map[DataBaseColumns.nameColumn];
    email = map[DataBaseColumns.emailColumn];
    phone = map[DataBaseColumns.phoneColumn];
    img = map[DataBaseColumns.imgColumn];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      DataBaseColumns.nameColumn: name,
      DataBaseColumns.emailColumn: email,
      DataBaseColumns.phoneColumn: phone,
      DataBaseColumns.imgColumn: img,
    };
    //If the object alredy had id, not change just update values and stay that id
    if (id != null) {
      map[DataBaseColumns.idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }
}
