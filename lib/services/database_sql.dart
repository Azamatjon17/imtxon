import 'package:sqflite/sqflite.dart';

class DatabaseSql {
  late Database database;
  final String tableName = "myTable.db";
  final String harajat = "Harajatlar";
  final String daromad = "Daromad";

  Future<void> init() async {
    String dc = await getDatabasesPath();
    database = await openDatabase(
      "$dc/$tableName",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $harajat (id INTEGER PRIMARY KEY  AUTOINCREMENT, summa REAL, kategory TEXT, createdDate TEXT,discription TEXT)',
        );
        await db.execute(
          'CREATE TABLE $daromad (id INTEGER PRIMARY KEY  AUTOINCREMENT, summa REAL, kategory TEXT, createdDate TEXT,discription TEXT)',
        );
      },
    );
  }

  Future<List<Map<String, Object?>>> get(String tabel) async {
    return await database.query(tabel);
  }

  Future<void> add(String tabel, Map<String, dynamic> data) async {
    await database.insert(tabel, data);
  }

  Future<void> delete(String table, int id) async {
    await database.delete(
      table,
      where: "id=$id",
    );
  }

  Future<void> edit(String table, Map<String, dynamic> data) async {
    await database.update(table, data, where: "id=${data["id"]}");
  }
}
