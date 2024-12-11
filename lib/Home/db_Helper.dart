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
  }
  Future<void> FetchData()
  async {
    Database? db=await database ;
    String query="SELECT * FROM budget";
    await db!.rawQuery(query);
  }
}
