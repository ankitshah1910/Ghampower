import 'dart:convert';

Client clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Client.fromMap(jsonData);
}

String clientToJson(Client data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Client {
  int id;
  String image;
  String fullName;
  String sex;
  String age;
  String currentaddress;
  String phone;
  String email;
  String state;
  String district;
  String city;
  String village;
  String ward;
  String earning;
  String nonearning;
  String highesteducation;
  String employment;
  String educationexpense;
  String healthexpense;
  String farmingexpense;
  String familyexpense;
  String bankexpense;
  String savingsexpense;
  String others;
  String otherexpense;
  String pumpuse;
  String boringwidth;
  String land;
  String crops;
  String animals;
  String marketdistance;


  String date;
  String time;
  String timekey;
  String timestamp;



  bool complete;

  Client({
    this.id,
    this.fullName,
    this.image,
    this.phone,
    this.email,
    this.age,
    this.sex,
    this.currentaddress,
    this.date,
    this.time,
    this.city,
    this.village,
    this.earning,
    this.nonearning,
    this.educationexpense,
    this.healthexpense,
    this.farmingexpense,
    this.familyexpense,
    this.bankexpense,
    this.savingsexpense,
    this.others,
    this.otherexpense,
    this.boringwidth,
    this.employment,
    this.state,
    this.district,
    this.highesteducation,
    this.crops,
    this.animals,
    this.land,
    this.pumpuse,
    this.ward,
    this.marketdistance,
    this.timekey,
    this.timestamp,
    this.complete,
  });

  factory Client.fromMap(Map<String, dynamic> json) => new Client(


    id: json["id"],
    fullName: json["full_name"],
    image: json["image"],
    phone: json["phone"],
    email: json["email"],
    age: json["age"],
    sex: json["sex"],
    currentaddress: json["currentaddress"],
    city: json["city"],
    village: json["village"],
    earning: json["earning"],
    nonearning: json["nonearning"],
    educationexpense: json["educationexpense"],
    healthexpense: json["healthexpense"],
    farmingexpense: json["farmingexpense"],

    familyexpense: json["familyexpense"],
    bankexpense: json["bankexpense"],
    savingsexpense: json["savingsexpense"],
    others: json["others"],
    otherexpense: json["otherexpense"],
    boringwidth: json["boringwidth"],
    employment: json["employment"],
    state: json["state"],
    district: json["district"],
    highesteducation: json["highesteducation"],
    crops: json["crops"],
    animals: json["animals"],
    land: json["land"],
    pumpuse: json["pumpuse"],
    ward: json["ward"],
    marketdistance: json["marketdistance"],
    date: json["date"],
    time: json["time"],
    timekey: json["timekey"],
    timestamp: json["timestamp"],
    complete: json["complete"] == 1, // returns true or false from int
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "full_name": fullName,
    "image": image,
    "phone": phone,
    "email": email,
    "age": age,
    "sex": sex,
    "currentaddress": currentaddress,

    "city": city,
    "village": village,
    "earning": earning,
    "nonearning": nonearning,
    "educationexpense": educationexpense,
    "healthexpense": healthexpense,
    "farmingexpense": farmingexpense,
    "familyexpense": familyexpense,


    "bankexpense": bankexpense,
    "savingsexpense": savingsexpense,
    "others": others,
    "otherexpense": otherexpense,
    "boringwidth": boringwidth,
    "employment": employment,
    "state": state,
    "district": district,

    "highesteducation": highesteducation,
    "crops": crops,
    "animals": animals,
    "land": land,
    "pumpuse": pumpuse,
    "ward": ward,
    "marketdistance": marketdistance,
    "date": date,
    "time": time,
    "timekey": timekey,
    "timestamp": timestamp,
    "complete": complete,
  };
}