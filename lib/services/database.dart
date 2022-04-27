import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/ShoppingCard.dart';

class CardDatabase {
  //create an instance
  static final CardDatabase instance = CardDatabase._init();

  static Database? _database;

  CardDatabase._init();

  //initialize a database
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cards.db');
    return _database!;
  }

  //save database to database paths
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //create database
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final textType = 'TEXT NOT NULL';

    //create table Transaction
    await db.execute('CREATE TABLE $tableCard ('
        '${ShoppingCardFields.id} $idType,'
        '${ShoppingCardFields.name} $textType,'
        '${ShoppingCardFields.barcode} $textType'
        ')');
  }

  //add Card
  Future<ShoppingCard> addCard(ShoppingCard card) async {
    final db = await instance.database;
    final id = await db.insert(tableCard, card.toJson());
    return card.copy(id: id);
  }

  //read Expense
  Future<ShoppingCard?> getCard(int id) async {
    final db = await instance.database;
    final maps = await db.query(tableCard,
        columns: ShoppingCardFields.values,
        where: '${ShoppingCardFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return ShoppingCard.fromJson(maps.first);
    } else {
      return ShoppingCard(id: 0, name: 'Card Name', barcode: barcode);
    }
  }

  //read All Expenses
  Future<List<ShoppingCard>> getCards() async {
    final db = await instance.database;
    final result = await db.query(tableCard);
    return result.map((json) => ShoppingCard.fromJson(json)).toList();
  }

  //update Expense
  Future<int> updateCard(ShoppingCard card) async {
    final db = await instance.database;

    return db.update(tableCard, card.toJson(),
        where: '${ShoppingCardFields.id} = ?', whereArgs: [card.id]);
  }

  //delete Expenses
  Future<int> deleteCard(int id) async {
    final db = await instance.database;
    return await db.delete(tableCard,
        where: '${ShoppingCardFields.id} = ?', whereArgs: [id]);
  }

  //close database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
