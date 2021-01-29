import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/local_db/OfflineClientModel.dart';
import 'package:sqflite/sqflite.dart';

class OfflineDBProvider {
  OfflineDBProvider._();

  static final OfflineDBProvider db = OfflineDBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null){
      print(" --------------------------  Database exists ----------------------------- ");
      return _database;
    }
    // if _database is null we instantiate it
    _database = await initDB();
    print(" --------------------------  Database created ----------------------------- ");
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Ofline.db");

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Client ("
              "id INTEGER PRIMARY KEY,"
              "full_name TEXT,"
              "image TEXT,"
              "phone TEXT,"
              "email TEXT,"
              "age TEXT,"
              "sex TEXT,"
              "district TEXT,"
              "currentaddress TEXT,"
              "city TEXT,"
              "village TEXT,"
              "earning TEXT,"
              "nonearning TEXT,"
              "educationexpense TEXT,"
              "healthexpense TEXT,"
              "farmingexpense TEXT,"
              "familyexpense TEXT,"
              "bankexpense TEXT,"
              "savingsexpense TEXT,"
              "others TEXT,"
              "otherexpense TEXT,"
              "boringwidth TEXT,"
              "employment TEXT,"
              "state TEXT,"
              "highesteducation TEXT,"
              "crops TEXT,"
              "animals TEXT,"
              "land TEXT,"
              "pumpuse TEXT,"
              "ward TEXT,"
              "marketdistance TEXT,"
              "date TEXT,"
              "time TEXT,"
              "timekey TEXT,"
              "timestamp TEXT,"
              "complete BIT"
              ")");
        });
  }

  // Function to create new client / person in db
  newClient(Client newClient) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Client (id,full_name,image,phone,email,age,sex,district,date,time,timekey,timestamp,complete,currentaddress,city,village,earning,nonearning,educationexpense,healthexpense,farmingexpense,familyexpense,bankexpense,savingsexpense,others,otherexpense,boringwidth,employment,state,highesteducation,crops,animals,land,pumpuse,ward,marketdistance)"
            " VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
        [ id,
          newClient.fullName,
          newClient.image,
          newClient.phone,
          newClient.email,
          newClient.age,
          newClient.sex,
          newClient.district,
          newClient.date,
          newClient.time,
          newClient.timekey,
          newClient.timestamp,
          newClient.complete,
          newClient.currentaddress,
          newClient.city,
          newClient.village,
          newClient.earning,
          newClient.nonearning,
          newClient.educationexpense,
          newClient.healthexpense,
          newClient.farmingexpense,
          newClient.familyexpense,
          newClient.bankexpense,
          newClient.savingsexpense,
          newClient.others,
          newClient.otherexpense,
          newClient.boringwidth,
          newClient.employment,
          newClient.state,
          newClient.highesteducation,
          newClient.crops,
          newClient.animals,
          newClient.land,
          newClient.pumpuse,
          newClient.ward,
          newClient.marketdistance,
        ]
    );
    print(raw);
    return raw;
  }

  // function to toggle complete column in db
  toggleComplete(Client client) async {
    final db = await database;
    Client complete = Client(

        id: client.id,
        fullName: client.fullName,
        image: client.image,
        phone: client.phone,
        email: client.email,
        age: client.age,
        sex: client.sex,
        district: client.district,
        date: client.date,
        time: client.time,
        timekey: client.timekey,
        timestamp: client.timestamp,
        complete: !client.complete,
        currentaddress: client.currentaddress,
        city: client.city,
        village: client.village,
        earning: client.earning,
        nonearning: client.nonearning,
        educationexpense: client.educationexpense,
        healthexpense: client.healthexpense,
        farmingexpense: client.farmingexpense,
        familyexpense: client.familyexpense,
        bankexpense: client.bankexpense,
        savingsexpense: client.savingsexpense,
        others: client.others,
        otherexpense: client.otherexpense,
        boringwidth: client.boringwidth,
        employment: client.employment,
        state: client.state,
        highesteducation: client.highesteducation,
        crops: client.crops,
        animals: client.animals,
        land: client.land,
        pumpuse: client.pumpuse,
        ward: client.ward,
        marketdistance: client.marketdistance);

    var result = await db.update("Client", complete.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    //print("Toggled Complete");
    return result;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var result = await db.update("Client", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return result;
  }

  getClient(int id) async {
    final db = await database;
    var result = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return result.isNotEmpty ? Client.fromMap(result.first) : null;
  }

  // Unused in main.dart yet ...
  Future<List<Client>> getCompleteClients() async {
    final db = await database;
    var result = await db.query("Client", where: "complete = ? ", orderBy: "id DESC",whereArgs: [1]);
    List<Client> list =
    result.isNotEmpty ? result.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }


  Future<List<Client>> getIncompleteClients() async {
    final db = await database;
    var result = await db.query("Client", where: "complete = ? ", orderBy: "id DESC",whereArgs: [0]);

    List<Client> list =
    result.isNotEmpty ? result.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  // Function to get the all the rows in local database ...
  Future<List<Client>> getAllClients() async {
    final db = await database;
    var result = await db.query("Client", orderBy: "id DESC");
    List<Client> list =
    result.isNotEmpty ? result.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  // Function to delete the client with id ...
  deleteClient(int id) async {
    final db = await database;
    return db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  // Function to delete all client ... unused in main.dart file yet
  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}