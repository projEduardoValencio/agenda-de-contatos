import 'package:agenda_de_contatos/src/models/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseColumns {
  static const String contactTable = "contactTable";
  static const String idColumn = "idColumn";
  static const String nameColumn = "nameColumn";
  static const String emailColumn = "emailColumn";
  static const String phoneColumn = "phoneColumn";
  static const String imgColumn = "imgColum";
}

class ContatctHelper {
  ContatctHelper.internal();
  // Só podera ser chamado o construtor dentro desta classe
  static final ContatctHelper _istance = ContatctHelper.internal();
  factory ContatctHelper() => _istance;

  //Declarando o banco de dadso
  Database? _db;

  Future<Database> get db async {
    //Verificando se o banco esta inicializado
    if (_db != null) {
      //Se estiver somente retorne o banco
      return _db!;
    } else {
      //caso contrario invocar a funçao
      _db = await initDb();
      return _db!;
    }
  }

  //metodo de criaçao do banco de dados
  Future<Database> initDb() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(databasePath, "contacts.db");

    //Abrir o banco de dados
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      //criando a tabela com os parametros em SQL caso ainda tenha sido criado
      await db.execute(
          "CREATE TABLE ${DataBaseColumns.contactTable}(${DataBaseColumns.idColumn} INTEGER PRIMARY KEY, ${DataBaseColumns.nameColumn} TEXT, ${DataBaseColumns.emailColumn} TEXT, ${DataBaseColumns.phoneColumn} TEXT, ${DataBaseColumns.imgColumn} TEXT)");
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    //abrindo o banco de dados
    Database dbContact = await db;
    //salvando o contato
    contact.id =
        await dbContact.insert(DataBaseColumns.contactTable, contact.toMap());
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    Database dbContact = await db;
    //Buscando no banco o contato com o id
    List<Map> maps = await dbContact.query(
      DataBaseColumns.contactTable,
      columns: [
        DataBaseColumns.idColumn,
        DataBaseColumns.nameColumn,
        DataBaseColumns.emailColumn,
        DataBaseColumns.phoneColumn,
        DataBaseColumns.imgColumn,
      ],
      where: "${DataBaseColumns.idColumn} = ?",
      whereArgs: [id],
    );
    //Se encontrar algum contato passar pela função frommap e retornar o contato
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      //Caso contrario retorne null
      return null;
    }
  }
}