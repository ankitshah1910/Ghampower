// SQLITE CLASSES
import 'package:flutter_app/local_db/OfflineClientModel.dart';
import 'package:flutter_app/local_db/OfflineDatabase.dart';

// FIREBASE CLASSES
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

// SYNCING CLASS
class SyncOfflineData {

  SyncOfflineData._();

  // Offline Database Instance
  OfflineDBProvider offlineDatabase;
  Future<List<Client>> offlineClientData;

  // Online Database Instance
  Firestore onlineDatabase;
  DateTime dbTimeKey;

  SyncOfflineData(){

    // Initializing the offline database
    offlineDatabase = OfflineDBProvider.db;
    offlineClientData = offlineDatabase.getCompleteClients();

    // Initializing the online database
    onlineDatabase = Firestore.instance;
    dbTimeKey = new DateTime.now();

  }

  Future<void> start() async{
    if(offlineClientData != null){

      for(Client each in await offlineClientData){



        Map employment=jsonDecode(each.employment.replaceAll("{", '{"').replaceAll(": ", '":"').replaceAll(", ", '","').replaceAll("}", '"}'));

        Map animals=jsonDecode(each.animals.replaceAll("{", '{"').replaceAll(": ", '":"').replaceAll(", ", '","').replaceAll("}", '"}'));
        print(animals);

        Map pumpuse=jsonDecode(each.pumpuse.replaceAll("{", '{"').replaceAll("\n", "").replaceAll(": ", '":"').replaceAll(", ", '","').replaceAll("}", '"}'));
        print(pumpuse);

        Map land=jsonDecode(each.land.replaceAll("{", '{"').replaceAll("\n", "").replaceAll(": ", '":"').replaceAll(", ", '","').replaceAll("}", '"}'));
        print(land);

        Map crops=jsonDecode(each.crops.replaceAll("{", '{"').replaceAll("\n", "").replaceAll(": ", '":"').replaceAll(", ", '","').replaceAll("}", '"}'));
        print(crops);
//        Map animals=jsonDecode(each.animals);
//        Map crops=jsonDecode(each.crops);
//        Map land=jsonDecode(each.land);
//        Map pumpuse=jsonDecode(each.pumpuse);

        print(employment);
        print(animals);
        print(crops);
        print(land);
        print(pumpuse);

        var data = {
          "id": each.id,
          "fullName": each.fullName,
          "image": "https://firebasestorage.googleapis.com/v0/b/demoapp-9a150.appspot.com/o/Post%20Images%2Favatar.png?alt=media&token=e4b06f7f-743a-400e-a459-1011235cd5bf",
          "phone": each.phone,
          "email": each.email,
          "age": each.age,
          "sex": each.sex,
          "currentaddress": each.currentaddress,

          "city": each.city,
          "village": each.village,
          "earning": each.earning,
          "nonearning": each.nonearning,
          "educationexpense": each.educationexpense,
          "healthexpense": each.healthexpense,
          "farmingexpense": each.farmingexpense,
          "familyexpense": each.familyexpense,

          "bankexpense": each.bankexpense,
          "savingsexpense": each.savingsexpense,
          "others": each.others,
          "otherexpense": each.otherexpense,
          "boringwidth": each.boringwidth,
          "employment": employment,
          "state": each.state,
          "district": each.district,

          "highesteducation": each.highesteducation,
          "crops": crops,
          "animals": animals,
          "land": land,
          "pumpuse": pumpuse,
          "ward": each.ward,
          "marketdistance": each.marketdistance,
          "date": each.date,
          "time": each.time,
          "timekey": dbTimeKey.toString(),
          "timestamp": FieldValue.serverTimestamp(),
          "complete": each.complete,
        };


        print(data);
        await onlineDatabase.collection("posts").document(dbTimeKey.toString()).setData(data);
        await offlineDatabase.deleteClient(each.id);
        await print(" ---- ---- ---- Data synced of : "+each.fullName.toString());
      }
    }

    //await databaseReference.collection("posts").document(dbTimeKey.toString()).setData(data);
  }

}
