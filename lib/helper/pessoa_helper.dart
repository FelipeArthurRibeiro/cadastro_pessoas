import 'package:exe_4/model/pessoa.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PessoaHelper {
  static Database? _db;

  static Future<Database?> get db async {
    if(db != null){
      return db;
    } else{
      _db = await openDatabase(
        join(await getDatabasesPath(), "cadastro.db"),
        onCreate: (db, version){
          return db.execute('CREATE TABLE pessoas(id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT, telefone TEXT, email TEXT, estado_civil INTEGER)',
          );
        },
        version: 1
      );
    }
  }

  static Future<Pessoa> insert(Pessoa pessoa) async{
    Database? database = await db;
    pessoa.id = await database!.insert(
      'pessoas',
      pessoa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return pessoa;
  }

  static Future<List<Pessoa>> selectAll() async{
    Database? database = await db;
    final List<Map<String, dynamic>> maps = await database!.query('pessoas');

    List<Pessoa> listaPessoas = [];
    for(final element in maps){
      listaPessoas.add(Pessoa.fromMap(element));
    }
    return listaPessoas;
  }

  static Future<void> update(Pessoa pessoa) async {
    Database? database = await db;
    await database!.update(
        'pessoas',
        pessoa.toMap(),
        where: 'id = ?',
        whereArgs: [pessoa.id]
    );
  }

  static Future<void> deleteById(int id) async {
    Database? database = await db;
    await database!.delete(
        'pessoas',
        where: 'id = ?',
        whereArgs: [id],
    );
  }
}