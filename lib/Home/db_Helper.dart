import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper{
  DbHelper._();
  static DbHelper dbHelper=DbHelper._();
  Database? _database;
  Future<Database?> get database async => _database ?? await CreateDatabase();

  Future<Database?> CreateDatabase()async
  {
    log("Called...");
    final path =await getDatabasesPath();
    var dbpath = join(path,"budget.db");
     Database myDatabase = await openDatabase(dbpath,version: 1,onCreate:(db, version) async {
       String query= '''
       CREATE TABLE budget(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       amount REAL,
       isincome INTEGER,
       date TEXT,
       category TEXT
       )
       ''';

       await db.execute(query);
       log("aa gaya bhai log");
     },);
     return myDatabase;
  }
 Future<void> insertRecord(double amount,String category,date,int isincome)
 async {
   Database? db= await database;
   String query='''
   INSERT INTO budget
   (amount, category, date ,isincome)
   VALUES
   (?,?,?,?)
   ''';
   List args=[amount,category,date,isincome];
   int result = await db!.rawInsert(query,args);
   log("insert status $result");
   fetchData();
  }
  Future<List<Map<String, dynamic>>> fetchData() async {
    Database? db = await database;
    String query = "SELECT * FROM budget";
    List<Map<String, dynamic>> result = await db!.rawQuery(query);
    return result;
  }


  Future<void>  deleteData(int id)
  async {
    Database? db=await database;
    String query="DELETE FROM budget WHERE id = ?";
    List args=[id];
    await db!.rawDelete(query,args);
  }

  Future<void> dbUpdateRecord({
    required int id,
    required double amt,
    required String category,
    required int isIncome,
    required String date,
  }) async {
    Database? db = await database;

     String query = '''UPDATE budget SET 
    amount = ?, 
    category = ?, 
    isincome = ?, 
    date = ? 
    WHERE id = ?''';

    List args = [amt, category, isIncome, date, id];

    try{
      final result = await db?.rawUpdate(query, args);
      log("Update status : $result");
    } catch(e) {
      log("Failed to update in table!!! : $e");
    }
  }

  // FILTER BY CATEGORY
  Future<List<Map<String, Object?>>> dbFetchByFilter(int siIncome) async {
    Database? db = await database;

    String query = '''SELECT * FROM budget WHERE $siIncome = isincome''';

    try{
      final result = await db!.rawQuery(query);
      log("Fetch status for $siIncome: $result");
      return result;
    } catch (e) {
      log("Failed to fetch from table for isincome");
    }

    return [];
  }
}

