import 'dart:convert';

import 'dart:async';
import 'dart:io';

import 'package:MagicNumbers/Models/History.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "RezultHistoryDb2.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE RezultHistoryDb2 ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "startSumma REAL,"
          "countAdd INTEGER,"
          "staf REAL,"
          "addText TEXT,"
          "periodText TEXT,"
          "addSumma REAL,"
          "finalAddSumma REAL,"
          "countMonth INTEGER,"
          "finalSuma REAL,"
          "finalProfit REAL,"
          "accountOpeningFee REAL,"
          "accountActivationFee REAL,"
          "termInMonths INTEGER,"
          "borrowedFunds REAL,"
          "contractAmount REAL,"
          "profitabilityPerMonth REAL,"
          "yieldPerYear REAL,"
          "typeFunc TEXT,"
          "HistoryGraf TEXT"
          ")");
      await db.execute("CREATE TABLE HistoryGraf ("
          "id INTEGER PRIMARY KEY,"
          "idHistory INTEGER,"
          "numberM INTEGER,"
          "countSumma REAL"
          ")");
    });
  }

  newClient(History newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table =
        await db.rawQuery("SELECT MAX(id)+1 as id FROM RezultHistoryDb2");
    int id = table.first["id"];
    //insert to the table using the new id
    String jsonGraf = jsonEncode(newClient.historyGraf);

    var raw = await db.rawInsert(
        "INSERT Into RezultHistoryDb2 (id,name,startSumma,countAdd,staf,addText,periodText,addSumma,finalAddSumma,countMonth,finalSuma,finalProfit,accountOpeningFee,accountActivationFee,termInMonths,borrowedFunds,contractAmount,profitabilityPerMonth,yieldPerYear,typeFunc,HistoryGraf)"
        " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [
          id,
          newClient.name,
          newClient.startSumma,
          newClient.countAdd,
          newClient.staf,
          newClient.addText,
          newClient.periodText,
          newClient.addSumma,
          newClient.finalAddSumma,
          newClient.countMonth,
          newClient.finalSuma,
          newClient.finalProfit,
          newClient.accountOpeningFee,
          newClient.accountActivationFee,
          newClient.termInMonths,
          newClient.borrowedFunds,
          newClient.contractAmount,
          newClient.profitabilityPerMonth,
          newClient.yieldPerYear,
          newClient.typeFunc,
          jsonGraf
        ]);
    return raw;
  }

  // blockOrUnblock(Client client) async {
  //   final db = await database;
  //   Client blocked = Client(
  //       id: client.id,
  //       firstName: client.firstName,
  //       lastName: client.lastName,
  //       blocked: !client.blocked);
  //   var res = await db.update("Client", blocked.toMap(),
  //       where: "id = ?", whereArgs: [client.id]);
  //   return res;
  // }

  // updateClient(Client newClient) async {
  //   final db = await database;
  //   var res = await db.update("Client", newClient.toMap(),
  //       where: "id = ?", whereArgs: [newClient.id]);
  //   return res;
  // }

  // getClient(int id) async {
  //   final db = await database;
  //   var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
  //   return res.isNotEmpty ? Client.fromMap(res.first) : null;
  // }

  // Future<List<Client>> getBlockedClients() async {
  //   final db = await database;

  //   print("works");
  //   // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
  //   var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

  //   List<Client> list =
  //       res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
  //   return list;
  // }

  Future<List<History>> getAllClients() async {
    final db = await database;
    var res = await db.query("RezultHistoryDb2");
    List<History> list =
        res.isNotEmpty ? res.map((c) => History.fromJson(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("RezultHistoryDb2", where: "id = ?", whereArgs: [id]);
  }

  // deleteAll() async {
  //   final db = await database;
  //   db.rawDelete("Delete * from Client");
  // }
}
