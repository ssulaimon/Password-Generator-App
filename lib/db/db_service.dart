import 'package:flutterleaner/model/password_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHelper {
  Future<Database> intializeDataBase() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'myPassword.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE GeneratedPasswords (id INTEGER PRIMARY KEY AUTOINCREMENT, password TEXT NOT NULL, title TEXT NOT NULL)");
      },
      version: 1,
    );
  }

  Future<int> insertPasswordToDatabase(
      {required PasswordModel passwordModel}) async {
    Database db = await intializeDataBase();

    try {
      await db.insert(
        'GeneratedPasswords',
        {'password': passwordModel.password, 'title': passwordModel.title},
      );
      return 1;
    } catch (error) {
      return 2;
    }
  }

  Future<List<PasswordModel>> getSavedPasswordsFromDataBase() async {
    Database db = await intializeDataBase();
    List<Map<String, dynamic>> passwords = await db.query('GeneratedPasswords');
    return passwords
        .map(
          (
            data,
          ) =>
              PasswordModel.fromJson(
            data: data,
          ),
        )
        .toList();
  }

  Future<Database> intializePinDataBase() async {
    String path = await getDatabasesPath();
    return await openDatabase(join(path, 'password.db'),
        onCreate: (database, version) {
      database.execute(
          'CREATE TABLE Pin (id INTEGER PRIMARY KEY, pin INTEGER NOT NULL)');
    }, version: 1);
  }

  Future<int> createPin({required int pin, required int id}) async {
    Database database = await intializePinDataBase();
    try {
      database.insert('Pin', {'pin': pin, 'id': id});
      return 1;
    } catch (error) {
      return 2;
    }
  }

  Future<int?> myPin() async {
    Database database = await intializePinDataBase();
    try {
      List<Map<String, dynamic>> pin = await database.query('Pin');
      return pin[0]['pin'];
    } catch (error) {
      return null;
    }
  }

  Future<int> updatePin({required int id, required int pin}) async {
    Database database = await intializePinDataBase();
    try {
      database.update(
          'Pin',
          {
            "pin": pin,
          },
          where: "id = ?",
          whereArgs: [id]);
      return 1;
    } catch (e) {
      return 2;
    }
  }
}
