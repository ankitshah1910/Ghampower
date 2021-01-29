import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:intl/intl.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app/submitsplash.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:flutter_app/DialogBox.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Imports for local db
import 'package:page_transition/page_transition.dart';

// Import for image conversion

import 'animation.dart';



class editPostPage extends StatefulWidget{
  final DocumentSnapshot post;
  editPostPage(this.post);


  State<StatefulWidget> createState(){
    return _editPostPageState();
  }
}

class _editPostPageState extends State<editPostPage> with SingleTickerProviderStateMixin{


  TextEditingController editfullNameController;
  TextEditingController editphoneController;
  TextEditingController editemailController;
  TextEditingController editageController;
  TextEditingController editcurrentaddressController;
  TextEditingController editcityController;
  TextEditingController editvillageController;
  TextEditingController editearningController;
  TextEditingController editnonearningController;
  TextEditingController editeducationexpenseController;
  TextEditingController edithealthexpenseController;
  TextEditingController editfarmingexpenseController;
  TextEditingController editfamilyexpenseController;
  TextEditingController editbankexpenseController;
  TextEditingController editsavingsexpenseController;
  TextEditingController editotherfieldController;
  TextEditingController editotherexpenseController;
  TextEditingController editboringwidthController;
  TextEditingController editincomeController;
  TextEditingController editothersfieldController;
  TextEditingController editexpectedexpenseController;
  TextEditingController editlandspaceController;
  TextEditingController editlandspaceforcropsController;
  TextEditingController editanimalquantityController;
  TextEditingController editmarketdistanceController;
  TextEditingController editwardController;


  // Some of the var for this class
  File avatarImgFile;
  String _gender;
  int _stateno;
  int _otherincome;
  int _animalhusbandary;
  int _sellproducts;

  int _usepump;
  String _landtype;
  String _landowner;
  var _firstPress = true ;

  Map<dynamic,dynamic> employment;
  Map<dynamic,dynamic> animal;

  Map<dynamic,dynamic> lands;
  Map<dynamic,dynamic> crops;

  Map<dynamic,dynamic> pump;

  int totalmember=0;
  bool validate1=true;
  bool validate2=false;


  final formKey1 = new GlobalKey<FormState>();
  final formKey2 = new GlobalKey<FormState>();
  final formKey4 = new GlobalKey<FormState>();
  final formKey5 = new GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formkey5 = GlobalKey<FormState>();


  String _selecteddistrict;
  String _highesteducation;
  String _incometype;
  String _animalnumber;

  String _landspace;
  String _landspaceforcrops;
  String _animalname;


  String _landunit;
  String _landunitforcrops;

  String _cropstype;
  String _cropstypevalue;


  String _watersource;
  String _pumptype;


  bool expanded=true;
  // Form controller defining

  String name, path;
  String avatarImgUrl;
  bool upload = false;
  // some vars for form

  //creating instance of DialogBox
  DialogBox dialogBox = new DialogBox();
  Animation<double> _progressAnimation;
  AnimationController _progressAnimcontroller;


  List<String> listprov1=["Bhojpur","Dhankuta","Illam","jhapa","Khotang","Morang","Okhaldhunga","Panchthar","Sankhuwasabha","Solukhumbu","Sunsari","Taplejung","terhathum","Udayapur"];
  List<String> listprov2=["Saptari","Siraha","Dhanusa","Mahottari","Sarlahi","Bara","parsa","Rautahat"];
  List<String> listprov3=["Sindhuli","Ramechhap","Dolakha","Bhaktapur","Dhading","kathmandu","Kavrepalanchowk","Lalitpur","Nuwakot","Rasuwa","Sindhupalchowk","Chitwan","Makwanpur"];
  List<String> listprov4=["Baglung","Gorkha","Kaski","Lamjung","Manang","Mustang","Myagdi","Nawalpur","Parbat","Syangja","Tanahun"];
  List<String> listprov5=["Kapilvastu","Parasi","Rupandehi","Arghakanchi","Gulmi","Palpa","Dang","Pyuthan","Rolpa","East Rukum","Banke","Bardiya"];
  List<String> listprov6=["West Rukum","Salyan","Dolpa","Humla","Jumla","Kalikot","Mugu","Surkhet","Dailekh","Jajarkot"];
  List<String> listprov7=["Kailali","Achham","Doti","Bajhang","Bajura","Kanchanpur","Dadeldhura","Baitadi","Darchula"];
  List<String> educationlevel=["Not Educated","8th Grade","SLC/SEE","+2/Intermediate","Diploma","Bachelors","Masters","Phd","Other vocational training"];
  List<String> landunit=["Bigha / बिघा","Kattha / कठ्ठा","Ropani / रोपनी"];
  List<String> cropstype=["Food Crops / अन्नबली","Vegetable / तरकारी बाली","Pulses Crops / दाल/दलहन बाली","Industrial Crops / औधोगिक बाली"];
  List<String> income=["Jobs / पेशा/नोकरी","Business / व्यवसाय","Remittance / रेमिटेन्स","Others / अन्य"];
  List<String> animalname=["Cow / गाई","Buffalo / भैंसी","Goats / बाख्रा","(Hens/Chickens) / कुखुरा","Ducks / हाँस"];
  List<String> watersource=["River / खोला","Canal / नहर","drainage / कुलो","Ponds / पोखरी","Boring / बोरिङ्ग"];
  List<String> pumptype=["Diesel Pump / डिजल पम्प","Electric Pump / बिजुली पम्प"];
  List<String> cropstypevalues1=["Chaite Rice / चैतेधान","Monsoon Rice / वरषे धान","Maize / मकै","Wheat / गहुँ"];
  List<String> cropstypevalues2=["Potato (आलु)","Tomato / गोलभेडा","Cauliflower / काउली","Cucumber / काँक्रो","Capsicum / खुर्सानी","Mustard / तोरी","Cabbage / बन्दा","Onion / प्याज","Garlic / लसुन","Carrot / गाजर","Brinjal / भण्टा","Lady's Finger / (भिन्दी/रामतोरिया)"];
  List<String> cropstypevalues3=["Lentil(Musuro) / मुसुरो","Pigeon Pea(Rahar) / (रहर/अरहर)","Cowpea / बोडी","Kidney Bean / रज्मा"];
  List<String> cropstypevalues4=["Sugarcane / उखु","Fish / माछा"];





  double growStepWidth, beginWidth, endWidth = 0.0;
  int totalPages = 8;

  _setProgressAnim(double maxWidth, int curPageIndex) {
    setState(() {
      growStepWidth = maxWidth / totalPages;
      beginWidth = growStepWidth * (curPageIndex - 1);
      endWidth = growStepWidth * curPageIndex;

      _progressAnimation = Tween<double>(begin: beginWidth, end: endWidth)
          .animate(_progressAnimcontroller);
    });

    _progressAnimcontroller.forward();
  }
  // function to access phone camera
  Future getImageCamera(BuildContext context) async{
    File tempImage = await ImagePicker.pickImage(source: ImageSource.camera,maxWidth: 500,maxHeight: 650);
    setState(() {
      path = tempImage.path;
      avatarImgFile = tempImage;
      upload = true;
    });
    Navigator.of(context).pop();
  }

  // function to get image from phone gallery
  Future getImageGallery(BuildContext context) async{
    File tempImage = await ImagePicker.pickImage(source: ImageSource.gallery,maxWidth: 500,maxHeight: 650);

    setState(() {
      path = tempImage.path;
      avatarImgFile = tempImage;
      upload = true;
    });
    Navigator.of(context).pop();
  }

  // function to get default avatar
  Future getImageAvatar(BuildContext context) async{
    setState(() {
      avatarImgFile = null;
      upload = true;
    });
    Navigator.of(context).pop();
  }

  bool validateincome(){
    if((_otherincome==2 && employment.isNotEmpty)|| _otherincome==1){
      print("validate income sucess");

      return true;
    }else{
      setState(() {
        employment.clear();
      });
      return false;
    }
  }
  bool validateusepump(){
    if((_usepump==2 && pump.isNotEmpty)||_usepump==1){
      return true;
    }else{
      setState(() {
        pump.clear();
      });
      return false;
    }
  }
  bool validateanimal(){
    if((_animalhusbandary==2 && animal.isNotEmpty)||_animalhusbandary==1){
      return true;
    }else{
      setState(() {
        pump.clear();
      });
      return false;
    }
  }
  bool validatesellproduct(){
    if((_sellproducts==2 && editmarketdistanceController!=null)||_sellproducts==1){
      return true;
    }else{
      return false;
    }
  }
  // Function to save the form data after validation
  bool validateAndSave(){
    print("invalidate and savwe");
    final form1 = formKey1.currentState;
    if(form1.validate() && lands.isNotEmpty && crops.isNotEmpty && validateincome() && validateanimal() && validateusepump() && validatesellproduct()){
      form1.save();
      return true;
    }else{return false;}
  }
  Future performUpload() async{
    // Check the form validation and save the form data to use
    if(validateAndSave()){
      if(await hasConnection()){
        // do online upload here
        saveDataOnline();
        Navigator.push(context, PageTransition(type: PageTransitionType.rotate, duration: Duration(seconds: 1),child:SplashScreen(submittype: "Online",)));
//        dialogbox("Congrats","Uploaded Online ✌");
//        dialogBox.information(context, "Congrats", "Uploaded Online ✌");

      }
      setState(() {
        _firstPress=true;

      });

    }else{
      dialogBox.information(context, "Opps! Invalid Form 😟", "Please fill all the required form data.");
    }
  }


  Future<bool> hasConnection() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // ignore: unnecessary_statements
        return true;
      }
    }on SocketException catch (_) {
      //print('not connected');
      return false;
    }
    return false;
  }

  saveDataOnline() async{
    //---------------- for client image to upload online --------------------//
    if(this.upload==true){
      print("called");
      // create the firebase conn. instance to upload the image file
      final StorageReference postImageRef = FirebaseStorage.instance.ref().child("Post Images");

      // Getting the time to make file name unique
      var timeKey = new DateTime.now();

      // Getting the image file ready to upload
      final StorageUploadTask uploadTask = postImageRef.child(timeKey.toString() + ".jpg").putFile(avatarImgFile);

      // Finally uploading the image and getting the online url of the uploaded img
      var imageUrl = await(await uploadTask.onComplete).ref.getDownloadURL();

      // Changing the global 'avatarImgUrl' from default to current whatever.
      this.avatarImgUrl = imageUrl.toString();
    } // else uses the default link of avatar declared globally

    //---------------- for rest of data to upload online --------------------//

    // Now creating the db instance of firebase to upload rest of data
    final databaseReference = Firestore.instance;
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    // create a var to send data to db
    var data = {
      "image": this.avatarImgUrl,
      "fullName": this.editfullNameController.text,
      "sex": this._gender,
      "age": this.editageController.text,
      "currentaddress": this.editcurrentaddressController.text,
      "phone": this.editphoneController.text,
      "email": this.editemailController.text,

      "state":this._stateno.toString(),
      "district":this._selecteddistrict,
      "city": this.editcityController.text,
      "ward": this.editwardController.text,
      "village": this.editvillageController.text,

      "earning": this.editearningController.text,
      "nonearning": this.editnonearningController.text,
      "highesteducation":this._highesteducation,

      "employment":this.employment,

      "educationexpense": this.editeducationexpenseController.text,
      "healthexpense": this.edithealthexpenseController.text,
      "farmingexpense": this.editfarmingexpenseController.text,
      "familyexpense": this.editfamilyexpenseController.text,
      "bankexpense": this.editbankexpenseController.text,
      "savingsexpense": this.editsavingsexpenseController.text,
      "others": this.editotherfieldController.text,
      "otherexpense": this.editotherexpenseController.text,

      "pumpuse":this.pump,
      "boringwidth": this.editboringwidthController.text,

      "land":this.lands,

      "crops":this.crops,

      "animals":this.animal,

      "marketdistance": this.editmarketdistanceController.text,

      "date": date,
      "time": time,
      "timekey": widget.post.data["timekey"],
      "timestamp": widget.post.data["timestamp"],
    };

    // upload the data finally
    await databaseReference.collection("posts")
        .document(widget.post.data['timekey'])
        .updateData(data);  }

  Map<String, Widget> _children() => {
    "Male": Text('Male 👨‍'),
    "Female": Text('Female 👩'),
    "Others": Text('Others 🙊')
  };
  Map<int, Widget> _yesno() => {
    1: Text('No ❌'),
    2: Text('Yes ✔')
  };
  Map<String, Widget> landtype() => {
    "Dry / सुख्खा": Text('Dry / सुख्ख'),
    "Fertile / सिचत": Text('Fertile / सिचत')
  };
  Map<String, Widget> landowner() => {
    "Own / आफ्नै ": Text('Own / आफ्नै '),
    "Rent / भाडामा": Text('Rent / भाडामा')
  };
  Map<int, Widget> _state() => {
    1: Text("1"),
    2: Text("2"),
    3: Text("3"),
    4: Text("4"),
    5: Text("5"),
    6: Text("6"),
    7: Text("7"),
  };
  
  goToHomePage(){
    Navigator.of(context).pop(true);
  }



  @override

  Widget build(BuildContext context) {
    

    var mediaQD = MediaQuery.of(context);
    var maxWidth = mediaQD.size.width;

    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: new Text("Add Data", style: TextStyle(color: Colors.white,fontSize: 25),),
        centerTitle: true,

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Row(
                children: <Widget>[
                  AnimatedProgressBar(
                    animation: _progressAnimation,
                  ),
                  Expanded(
                    child: Container(
                      height: 8.0,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                    ),
                  )
                ],
              )
          ),
        ),
      ),

      body:GestureDetector(
        onTap: () {

          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: this.formKey1,
          child: PageView(
            physics: ClampingScrollPhysics(),

            onPageChanged: (i) {

              //index i starts from 0!
              _progressAnimcontroller.reset(); //reset the animation first
              _setProgressAnim(maxWidth, i + 1);
            },
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  reverse: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        const SizedBox(height: 0.0,),
                        Padding(

                          padding: const EdgeInsets.only(top: 8),
                          child: Align(
                            alignment: Alignment.center,

                            child: CircleAvatar(

                              radius: 96,
                              backgroundColor: Colors.blueGrey,
                              child: ClipOval(

                                child: new SizedBox(

                                  width: 180.0,
                                  height: 180.0,
                                  child: (avatarImgFile!=null)?Image.file(avatarImgFile, fit: BoxFit.fill,):CircleAvatar(backgroundImage: NetworkImage(avatarImgUrl),backgroundColor: Color.fromRGBO(240, 151, 38, 1) ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 0,left: 0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_a_photo,
                                  size: 30.0,
                                ),
                                onPressed: (){
                                  _onButtonPressed();
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                            controller: this.editfullNameController,
                            decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'पुरा नाम/Full Name',
                                prefixIcon: Icon(Icons.perm_identity)
                            ),
                            style: new TextStyle(fontSize: 14, color: Colors.amber,),

                            validator: (value){
                              return value.isEmpty ? 'Full Name is required' : null;
                            }),
                        const SizedBox(height: 15,),

                        Row(

                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Gender: "),
                            ),

                            Expanded(
                              flex: 70,
                              child: MaterialSegmentedControl(

                                children: _children(),
                                selectionIndex: _gender,
                                borderColor: Colors.grey,
                                selectedColor: Color.fromRGBO(240, 151, 38, 1),
                                unselectedColor: Colors.white,
                                borderRadius: 20.0,
                                onSegmentChosen: (index) {
                                  setState(() {
                                    _gender = index;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                            controller: this.editageController,
                            maxLength: 2,

                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'उमेर/Age',
                                prefixIcon: Icon(Icons.cake)
                            ),
                            style: new TextStyle(fontSize: 14, color: Colors.amber,),

                            validator: (value) {
                              return value.isEmpty ? 'Age is required' : null;
                            }),
                        const SizedBox(height: 10,),
                        TextFormField(
                            controller: this.editcurrentaddressController,
                            decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'हालकोठेगााना/Current Address',
                                prefixIcon: Icon(Icons.map)
                            ),
                            style: new TextStyle(fontSize: 14, color: Colors.amber,),

                            validator: (value){
                              return value.isEmpty ? 'Current Address is required' : null;
                            }),
                        const SizedBox(height: 15,),
                        TextFormField(
                            controller: this.editphoneController,
                            maxLength: 10,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'फाेन/Phone',
                                prefixIcon: Icon(Icons.phone)
                            ),
                            style: new TextStyle(fontSize: 14, color: Colors.amber,),

                            validator: (value){
                              return value.isEmpty ? 'Phone is required' : null;
                            }),

                        const SizedBox(height: 10,),
                        TextFormField(
                          controller: this.editemailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'र्इमेल/Email',
                              prefixIcon: Icon(Icons.email)
                          ),
                          style: new TextStyle(fontSize: 14, color: Colors.amber,),
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  reverse: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Other personal data:",style: TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10.0,),


                        Row(

                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("State / प्रदेश : ",style: TextStyle(fontSize: 16),),
                            ),

                            Expanded(
                              flex: 70,
                              child: MaterialSegmentedControl(

                                children: _state(),
                                selectionIndex: _stateno,
                                borderColor: Colors.grey,
                                selectedColor: Color.fromRGBO(240, 151, 38, 1),
                                unselectedColor: Colors.white,
                                borderRadius: 20.0,
                                onSegmentChosen: (index) {
                                  setState(() {
                                    _selecteddistrict=null;
                                    _stateno = index;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),

                        Container(
                          decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.map,color: Colors.grey,),
                              ),
                              DropdownButton(

                                icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                hint: Text('Select District / जिल्ला छन्नु होस्। '), // Not necessary for Option 1
                                style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                underline: SizedBox.fromSize(),
                                value: widget.post.data["district"]!=""?widget.post.data["district"]:_selecteddistrict,

                                onChanged: (newValue) {
                                  setState(() {
                                    _selecteddistrict = newValue;
                                  });
                                },
                                items: _stateno==1?listprov1.map((location) {
                                  return DropdownMenuItem(

                                    child: new Text(location,),
                                    value: location,
                                  );
                                }).toList():_stateno==2?listprov2.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList():_stateno==3?listprov3.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList():_stateno==4?listprov4.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList():_stateno==5?listprov5.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList():_stateno==6?listprov6.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList():_stateno==7?listprov7.map((location) {
                                  return DropdownMenuItem(
                                    child: new Text(location),
                                    value: location,
                                  );
                                }).toList():null,

                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15,),
                        TextFormField(
                            controller: this.editcityController,
                            decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'City/स्थानीयिनकाय',
                                prefixIcon: Icon(Icons.location_city)
                            ),
                            style: new TextStyle(fontSize: 18, color: Colors.amber,),

                            validator: (value) {
                              return value.isEmpty ? 'City is required' : null;
                            }),
                        const SizedBox(height: 10,),
                        TextFormField(
                            controller: this.editwardController,
                            keyboardType: TextInputType.numberWithOptions(),

                            decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'Ward Number / वडानम्बर ',
                                prefixIcon: Icon(Icons.format_list_numbered)
                            ),
                            style: new TextStyle(fontSize: 18, color: Colors.amber,),

                            validator: (value){
                              return value.isEmpty ? 'Ward Number is required' : null;
                            }),
                        const SizedBox(height: 15,),
                        TextFormField(
                            controller: this.editvillageController,

                            decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'Locality or Village Name /टोल अथवा गाउँको नाम*',
                                prefixIcon: Icon(Icons.local_florist)
                            ),
                            style: new TextStyle(fontSize: 18, color: Colors.amber,),

                            validator: (value){
                              return value.isEmpty ? 'Locality or village name is required' : null;
                            }),

                        const SizedBox(height: 15,),
                        //partition line
                        Container(
                          height: 2.0,
                          width: 1.0,
                          color: Colors.grey,
                          margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                        ),
                        const SizedBox(height: 10,),
                        //partition line ends
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Center(child: Text("Family Members:",style: TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize: 25,letterSpacing: 2),)),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex:70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Earning members/आय आजर्न गर्ने:",style: TextStyle(fontSize: 18),),
                              ),
                            ),

                            Expanded(
                              flex: 30,
                              child: TextFormField(
                                  controller: this.editearningController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                      prefixIcon: Icon(Icons.person)
                                  ),
                                  style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                  validator: (value){
                                    return value.isEmpty ? 'Field is required' : null;
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Non-Earning members/आय आजर्न नगर्ने :",style: TextStyle(fontSize: 18),),
                              ),
                            ),

                            Expanded(
                              flex: 30,
                              child: TextFormField(
                                  controller: this.editnonearningController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                      prefixIcon: Icon(Icons.person)
                                  ),
                                  style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                  validator: (value){
                                    return value.isEmpty ? 'Field is required' : null;
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          height: 2.0,
                          width: 1.0,
                          color: Colors.grey,
                          margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Center(child: Text("Highest Education",style: TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize: 25,letterSpacing: 2),)),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.filter_frames,color: Colors.grey,),
                              ),
                              DropdownButton(

                                  icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                  hint: Text('Highest Education from family'), // Not necessary for Option 1
                                  style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                  underline: SizedBox.fromSize(),
                                  value: widget.post.data["highesteducation"]!=""?widget.post.data["highesteducation"]:_highesteducation,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _highesteducation = newValue;
                                    });
                                  },
                                  items: educationlevel.map((education) {
                                    return DropdownMenuItem(
                                      child: new Text(education,),
                                      value: education,
                                    );
                                  }).toList()
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  reverse: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Family Income/परिवार को आम्दनी :",style: TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10.0,),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Do you have any income other than agriculture / \nकृिष बाहेकको आम्दानी श्रोत छ?",style: TextStyle(fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 70,
                              child: MaterialSegmentedControl(

                                children: _yesno(),
                                selectionIndex: _otherincome,
                                borderColor: Colors.grey,
                                selectedColor: Color.fromRGBO(240, 151, 38, 1),
                                unselectedColor: Colors.white,
                                borderRadius: 20.0,
                                onSegmentChosen: (index) {
                                  setState(() {
                                    _otherincome = index;
                                  });
                                },
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            _otherincome==2 ?
                            Container(
                                child: Expanded(
                                  child: Form(
                                    key: _formKey,

                                    child: Column(
                                      children: <Widget>[
                                        listtile(),

                                        new ExpansionTile(

                                          onExpansionChanged: onexpansionchanged,

                                          initiallyExpanded: true,
                                          title: Container(
                                            width: 65.0,
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(240, 151, 38, 1),
                                              image: DecorationImage(
                                                image: expanded==false?AssetImage('assets/add.png'):AssetImage('assets/cancel.png'),

                                              ),
                                            ),
                                          ),
                                          trailing: Text(""),
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: Container(
                                                decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.format_list_numbered,color: Colors.grey,),
                                                    ),
                                                    DropdownButton(
                                                      icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                                      hint: Text('Income from type'), // Not necessary for Option 1
                                                      style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                                      underline: SizedBox.fromSize(),

                                                      value: _incometype,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _incometype = newValue;
                                                        });
                                                      },
                                                      items: income.map((income) {
                                                        return DropdownMenuItem(

                                                          child: new Text(income,),
                                                          value: income,
                                                        );
                                                      }).toList(),


                                                    ),
                                                  ],
                                                ),

                                              ),
                                            ),
                                            _incometype!=null?_incometype=="Others / अन्य "?Padding(
                                              padding: EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: TextFormField(
                                                  controller: this.editothersfieldController,
                                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'अन्य /others',
                                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                                  ),
                                                  style: new TextStyle(fontSize: 14, color: Colors.amber,),

                                                  onSaved:(newValue){
                                                    setState(() {
                                                      _incometype = this.editothersfieldController.text;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return value.isEmpty ? 'if you select others this field is required' : null;
                                                  }),
                                            ):SizedBox():SizedBox(),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: TextFormField(
                                                  enabled: _incometype==null?false:true,
                                                  controller: this.editincomeController,
                                                  maxLength: 7,

                                                  keyboardType: TextInputType.numberWithOptions(),
                                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'अनुमािनत मािषक रकम/income (in rupees)',
                                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                                  ),
                                                  style: new TextStyle(fontSize: 14, color: Colors.amber,),

                                                  validator: (value) {
                                                    return value.isEmpty ? 'Income amount is required' : null;
                                                  }),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                color: Color.fromRGBO(240, 151, 38, 1),
                                                child: Text("Add",style: TextStyle(fontSize: 20),),
                                                onPressed: () {
                                                  setState(() {
                                                    expanded=false;
                                                  });
                                                  final form = _formKey.currentState;
                                                  if(form.validate()==true){
                                                    setState(() {
                                                      expanded=false;
                                                    });
                                                    employment.addAll({
                                                      _incometype:this.editincomeController.text
                                                    });
                                                    this.editincomeController = new TextEditingController();
                                                    this._incometype=null;
                                                    print(employment);
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        //-------------build listtile with dismissible here----------------
                                        //-------------listtile end-------------------
                                      ],
                                    ),
                                  ),
                                )
                            ) : SizedBox(),
                          ],
                        ),

                        const SizedBox(height: 10,),

                        const SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  reverse: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Center(child: Text("Monthly Expense / पारिवारिक खर्च",style: TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex:70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Education / शिक्षा :",style: TextStyle(fontSize: 18),),
                              ),
                            ),

                            Expanded(
                              flex: 30,
                              child: TextFormField(
                                  controller: this.editeducationexpenseController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                  ),
                                  style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                  validator: (value){
                                    return value.isEmpty ? 'Education Expense is required' : null;
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex:70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Health / स्वास्थ्य  :",style: TextStyle(fontSize: 18),),
                              ),
                            ),

                            Expanded(
                              flex: 30,
                              child: TextFormField(
                                  controller: this.edithealthexpenseController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                  ),
                                  style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                  validator: (value){
                                    return value.isEmpty ? 'health expense is required' : null;
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex:70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("For farming / कृषि कर्मको लागि  :",style: TextStyle(fontSize: 18),),
                              ),
                            ),

                            Expanded(
                              flex: 30,
                              child: TextFormField(
                                  controller: this.editfarmingexpenseController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                  ),
                                  style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                  validator: (value){
                                    return value.isEmpty ? 'Farming Expense is required' : null;
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex:70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Family Expense / घर खर्च :",style: TextStyle(fontSize: 18),),
                              ),
                            ),

                            Expanded(
                              flex: 30,
                              child: TextFormField(
                                  controller: this.editfamilyexpenseController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                  ),
                                  style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                  validator: (value){
                                    return value.isEmpty ? 'Family Expense is required' : null;
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex:70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Bank's or finance's EMI /\n बैंक वा सहकारिको इ.एम.आइ  :",style: TextStyle(fontSize: 18),),
                              ),
                            ),

                            Expanded(
                              flex: 30,
                              child: TextFormField(
                                  controller: this.editbankexpenseController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                  ),
                                  style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                  validator: (value){
                                    return value.isEmpty ? 'Bank Expense is required' : null;
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex:70,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("bank's or Finance's Saving /\nबैंक वा सहकारिको बाचत:",style: TextStyle(fontSize: 18),),
                              ),
                            ),

                            Expanded(
                              flex: 30,
                              child: TextFormField(
                                  controller: this.editsavingsexpenseController,
                                  keyboardType: TextInputType.number,
                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                  ),
                                  style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                  validator: (value){
                                    return value.isEmpty ? 'Bank Saving expense is required' : null;
                                  }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 70,
                              child: TextFormField(
                                controller: this.editotherfieldController,
                                keyboardType: TextInputType.text,
                                decoration: new InputDecoration(labelText: "Others",
                                    prefixIcon: Icon(Icons.text_fields)
                                ),
                                style: new TextStyle(fontSize: 18, color: Colors.amber,),
                              ),
                            ),

                            Expanded(
                              flex: 30,
                              child: TextFormField(
                                controller: this.editotherexpenseController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                    prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                ),
                                style: new TextStyle(fontSize: 18, color: Colors.amber,),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),

                        const SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  reverse: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Project type / प्रोजेक्टको प्रकार :",style: TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10.0,),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Do you use pump ko get water / \nपानी तन्नको लागि पम्पको प्रयोग गर्नुहुन्छ?",style: TextStyle(fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 70,
                              child: MaterialSegmentedControl(

                                children: _yesno(),
                                selectionIndex: _usepump,
                                borderColor: Colors.grey,
                                selectedColor: Color.fromRGBO(240, 151, 38, 1),
                                unselectedColor: Colors.white,
                                borderRadius: 20.0,
                                onSegmentChosen: (index) {
                                  setState(() {
                                    _usepump = index;
                                  });
                                },
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            _usepump==2 ?
                            Container(
                                child: Expanded(
                                  child: Form(
                                    key: _formKey1,

                                    child: Column(
                                      children: <Widget>[
                                        listtilepump(),

                                        new ExpansionTile(
                                          onExpansionChanged: onexpansionchanged,

                                          initiallyExpanded: true,
                                          title: Container(
                                            width: 65.0,
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(240, 151, 38, 1),
                                              image: DecorationImage(
                                                image: expanded==false?AssetImage('assets/add.png'):AssetImage('assets/cancel.png'),

                                              ),
                                            ),
                                          ),
                                          trailing: Text(""),
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: Container(
                                                decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.format_list_numbered,color: Colors.grey,),
                                                    ),
                                                    DropdownButton(
                                                      icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                                      hint: Text('Source of Water'), // Not necessary for Option 1
                                                      style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                                      underline: SizedBox.fromSize(),

                                                      value: _watersource,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _watersource = newValue;
                                                        });
                                                      },
                                                      items: watersource.map((income) {
                                                        return DropdownMenuItem(

                                                          child: new Text(income,),
                                                          value: income,
                                                        );
                                                      }).toList(),


                                                    ),
                                                  ],
                                                ),

                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: Container(
                                                decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.format_list_numbered,color: Colors.grey,),
                                                    ),
                                                    DropdownButton(

                                                      icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                                      hint: Text('Pump type / पम्पको प्रकार'), // Not necessary for Option 1
                                                      style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                                      underline: SizedBox.fromSize(),

                                                      value: _pumptype,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _pumptype = newValue;
                                                        });
                                                      },
                                                      items: pumptype.map((income) {
                                                        return DropdownMenuItem(

                                                          child: new Text(income,),
                                                          value: income,
                                                        );
                                                      }).toList(),


                                                    ),
                                                  ],
                                                ),

                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0,left: 40,right: 40,bottom: 0),
                                              child: TextFormField(
                                                  enabled: _pumptype==null?false:true,
                                                  controller: this.editexpectedexpenseController,
                                                  maxLength: 7,

                                                  keyboardType: TextInputType.numberWithOptions(),
                                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'अनुमािनत मािषक खर्चा/expense (in rupees)',
                                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                                  ),
                                                  style: new TextStyle(fontSize: 14, color: Colors.amber,),

                                                  validator: (value) {
                                                    return value.isEmpty ? 'Expected monthly expense amount is required' : null;
                                                  }),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: RaisedButton(
                                                color: Color.fromRGBO(240, 151, 38, 1),
                                                child: Text("Add",style: TextStyle(fontSize: 20),),
                                                onPressed: () {
                                                  final form = _formKey1.currentState;
                                                  if(form.validate()==true){
                                                    setState(() {
                                                      expanded=false;
                                                    });
                                                    pump.addAll({
                                                      _watersource+("\nType--"+_pumptype):this.editexpectedexpenseController.text
                                                    });
                                                    this.editexpectedexpenseController = new TextEditingController();
                                                    this._watersource=null;
                                                    this._pumptype=null;

                                                    print(pump);
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        //-------------build listtile with dismissible here----------------
                                        //-------------listtile end-------------------
                                      ],
                                    ),
                                  ),
                                )
                            ) : SizedBox(),

                          ],
                        ),
                        Container(
                          height: 2.0,
                          width: 1.0,
                          color: Colors.grey,
                          margin: const EdgeInsets.only(left: 0.0, right: 0.0),
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Current Width of boring (inches) / हालको बोरिङ्गको चौडाइ (ईन्चमा):",style: TextStyle(fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10.0,),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 50,right: 50),
                            child: TextFormField(
                                controller: this.editboringwidthController,
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                    prefixIcon: Icon(Icons.looks_two)
                                ),
                                style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                validator: (value){
                                  return value.isEmpty ? 'Boring Width is required' : null;
                                }),
                          ),
                        ),

                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),


              Container(
                child: SingleChildScrollView(
                  reverse: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Information related to cultivable land \nखेति योग्य जग्गा सम्बन्धि जानकारी :",style: TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize: 25,letterSpacing: 2,),textAlign: TextAlign.center,)),
                        ),

                        Row(
                          children: <Widget>[

                            Container(
                                child: Expanded(
                                  child: Form(
                                    key: _formKey2,

                                    child: Column(
                                      children: <Widget>[

                                        new ExpansionTile(
                                          onExpansionChanged: onexpansionchanged,

                                          initiallyExpanded: true,
                                          title: Container(
                                            width: 65.0,
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(240, 151, 38, 1),
                                              image: DecorationImage(
                                                image: expanded==false?AssetImage('assets/add.png'):AssetImage('assets/cancel.png'),

                                              ),
                                            ),
                                          ),
                                          trailing: Text(""),
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 70,
                                                    child: MaterialSegmentedControl(

                                                      children: landtype(),
                                                      selectionIndex: _landtype,
                                                      borderColor: Colors.grey,
                                                      selectedColor: Color.fromRGBO(240, 151, 38, 1),
                                                      unselectedColor: Colors.white,
                                                      borderRadius: 20.0,
                                                      onSegmentChosen: (Value) {
                                                        setState(() {
                                                          _landtype = Value;
                                                        });
                                                      },
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 70,
                                                    child: MaterialSegmentedControl(

                                                      children: landowner(),
                                                      selectionIndex: _landowner,
                                                      borderColor: Colors.grey,
                                                      selectedColor: Color.fromRGBO(240, 151, 38, 1),
                                                      unselectedColor: Colors.white,
                                                      borderRadius: 20.0,
                                                      onSegmentChosen: (Value) {
                                                        setState(() {
                                                          _landowner = Value;
                                                        });
                                                      },
                                                    ),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: TextFormField(
                                                  keyboardType: TextInputType.numberWithOptions(),
                                                  controller: this.editlandspaceController,
                                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'जग्गाको क्षेत्रफल / Land Space',
                                                      prefixIcon: Icon(Icons.format_list_numbered)
                                                  ),
                                                  style: new TextStyle(fontSize: 14, color: Colors.amber,),

                                                  onSaved:(newValue){
                                                    setState(() {
                                                      _landspace = this.editlandspaceController.text;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return value.isEmpty ? 'Total Space of Land is required' : null;
                                                  }),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: Container(
                                                decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                                                child: Row(
                                                  children: <Widget>[

                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.local_activity,color: Colors.grey,),
                                                    ),
                                                    DropdownButton(
                                                      icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                                      hint: Text('Land Unit'), // Not necessary for Option 1
                                                      style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                                      underline: SizedBox.fromSize(),

                                                      value: _landunit,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _landunit = newValue;
                                                        });
                                                      },
                                                      items: landunit.map((Items) {
                                                        return DropdownMenuItem(

                                                          child: Container(
                                                              child: new Text(Items,)),
                                                          value: Items,
                                                        );
                                                      }).toList(),


                                                    ),
                                                  ],
                                                ),

                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                color: Color.fromRGBO(240, 151, 38, 1),
                                                child: Text("Add",style: TextStyle(fontSize: 20),),
                                                onPressed: () {

                                                  final form = _formKey2.currentState;
                                                  if(form.validate()==true){
                                                    lands.addAll({
                                                      _landtype+("\nIn-- "+_landowner):this.editlandspaceController.text+(" "+_landunit)
                                                    });
                                                    this.editlandspaceController = new TextEditingController();
                                                    this._landunit=null;
                                                    this._landtype=null;
                                                    this._landowner=null;
                                                    setState(() {
                                                      expanded=false;
                                                    });
                                                    print(lands);
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        //-------------build listtile with dismissible here----------------
                                        listtilelands(),
                                        //-------------listtile end-------------------
                                      ],
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),

                        const SizedBox(height: 10,),

                        const SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),
              ),

              Container(
                child: SingleChildScrollView(
                  reverse: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Information related to Crops \nअन्न बलीको जानकारी :",style: TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize: 25,letterSpacing: 2,),textAlign: TextAlign.center,)),
                        ),

                        Row(
                          children: <Widget>[

                            Container(
                                child: Expanded(
                                  child: Form(
                                    key: _formKey3,

                                    child: Column(
                                      children: <Widget>[

                                        new ExpansionTile(
                                          onExpansionChanged: onexpansionchanged,

                                          initiallyExpanded: true,
                                          title: Container(
                                            width: 65.0,
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(240, 151, 38, 1),
                                              image: DecorationImage(
                                                image: expanded==false?AssetImage('assets/add.png'):AssetImage('assets/cancel.png'),

                                              ),
                                            ),
                                          ),
                                          trailing: Text(""),
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: Container(
                                                decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                                                child: Row(
                                                  children: <Widget>[

                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.local_activity,color: Colors.grey,),
                                                    ),
                                                    DropdownButton(
                                                      icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                                      hint: Text('Crops Type / बालीको प्रकार'), // Not necessary for Option 1
                                                      style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                                      underline: SizedBox.fromSize(),

                                                      value: _cropstype,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _cropstypevalue=null;
                                                          _cropstype = newValue;
                                                        });
                                                      },
                                                      items: cropstype.map((Items) {
                                                        return DropdownMenuItem(

                                                          child: Container(
                                                              child: new Text(Items,)),
                                                          value: Items,
                                                        );
                                                      }).toList(),


                                                    ),
                                                  ],
                                                ),

                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: _cropstype!=null?Container(
                                                decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                                                child: Row(
                                                  children: <Widget>[

                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.local_activity,color: Colors.grey,),
                                                    ),
                                                    DropdownButton(
                                                      icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                                      hint: Text('Crops Type / बालीको प्रकार'), // Not necessary for Option 1
                                                      style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                                      underline: SizedBox.fromSize(),

                                                      value: _cropstypevalue,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _cropstypevalue = newValue;
                                                        });
                                                      },
                                                      items: _cropstype=="Food Crops / अन्नबली"?cropstypevalues1.map((Items) {
                                                        return DropdownMenuItem(

                                                          child: Container(
                                                              child: new Text(Items,)),
                                                          value: Items,
                                                        );
                                                      }).toList():_cropstype=="Vegetable / तरकारी बाली"?cropstypevalues2.map((Items) {
                                                        return DropdownMenuItem(

                                                          child: Container(
                                                              child: new Text(Items,)),
                                                          value: Items,
                                                        );
                                                      }).toList():_cropstype=="Pulses Crops / दाल/दलहन बाली"?cropstypevalues3.map((Items) {
                                                        return DropdownMenuItem(

                                                          child: Container(
                                                              child: new Text(Items,)),
                                                          value: Items,
                                                        );
                                                      }).toList():_cropstype=="Industrial Crops / औधोगिक बाली"?cropstypevalues4.map((Items) {
                                                        return DropdownMenuItem(

                                                          child: Container(
                                                              child: new Text(Items,)),
                                                          value: Items,
                                                        );
                                                      }).toList():null,


                                                    ),
                                                  ],
                                                ),

                                              ):SizedBox(),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: TextFormField(
                                                  enabled: _cropstypevalue==null?false:true,

                                                  keyboardType: TextInputType.numberWithOptions(),
                                                  controller: this.editlandspaceforcropsController,
                                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'जग्गाको क्षेत्रफल / Land Space',
                                                      prefixIcon: Icon(Icons.format_list_numbered)
                                                  ),
                                                  style: new TextStyle(fontSize: 14, color: Colors.amber,),

                                                  onSaved:(newValue){
                                                    setState(() {
                                                      _landspaceforcrops = this.editlandspaceforcropsController.text;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return value.isEmpty ? 'Total Space of Land for specified crops is required' : null;
                                                  }),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: Container(
                                                decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                                                child: Row(
                                                  children: <Widget>[

                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.local_activity,color: Colors.grey,),
                                                    ),
                                                    DropdownButton(

                                                      icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                                      hint: Text('Land Unit'), // Not necessary for Option 1
                                                      style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                                      underline: SizedBox.fromSize(),

                                                      value: _landunitforcrops,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _landunitforcrops = newValue;
                                                        });
                                                      },
                                                      items: landunit.map((Items) {
                                                        return DropdownMenuItem(

                                                          child: Container(
                                                              child: new Text(Items,)),
                                                          value: Items,
                                                        );
                                                      }).toList(),


                                                    ),
                                                  ],
                                                ),

                                              ),
                                            ),


                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                color: Color.fromRGBO(240, 151, 38, 1),
                                                child: Text("Add",style: TextStyle(fontSize: 20),),
                                                onPressed: () {

                                                  final form = _formKey3.currentState;
                                                  if(form.validate()==true){
                                                    crops.addAll({
                                                      _cropstypevalue+("\nType--"+_cropstype):this.editlandspaceforcropsController.text+(" "+_landunitforcrops)
                                                    });
                                                    this.editlandspaceforcropsController = new TextEditingController();
                                                    this._cropstypevalue=null;
                                                    this._cropstype=null;
                                                    this._landunitforcrops=null;
                                                    setState(() {
                                                      expanded=false;
                                                    });
                                                    print(crops);
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        //-------------build listtile with dismissible here----------------
                                        listtilecrops(),
                                        //-------------listtile end-------------------
                                      ],
                                    ),
                                  ),
                                )
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: SingleChildScrollView(
                  reverse: false,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Other Informations / अन्य जानकारी :",style: TextStyle(color: Color.fromRGBO(240, 151, 38, 1),fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10.0,),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Are you involved in animal husbandary / \nगाई बस्तु पाल्नुभएको छ ?",style: TextStyle(fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 70,
                              child: MaterialSegmentedControl(

                                children: _yesno(),
                                selectionIndex: _animalhusbandary,
                                borderColor: Colors.grey,
                                selectedColor: Color.fromRGBO(240, 151, 38, 1),
                                unselectedColor: Colors.white,
                                borderRadius: 20.0,
                                onSegmentChosen: (index) {
                                  setState(() {
                                    _animalhusbandary = index;
                                  });
                                },
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            _animalhusbandary==2 ?
                            Container(
                                child: Expanded(
                                  child: Form(
                                    key: _formKey4,

                                    child: Column(
                                      children: <Widget>[
                                        new ExpansionTile(
                                          onExpansionChanged: onexpansionchanged,
                                          initiallyExpanded: true,
                                          title: Container(
                                            width: 65.0,
                                            height: 65.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromRGBO(240, 151, 38, 1),
                                              image: DecorationImage(
                                                image: expanded==false?AssetImage('assets/add.png'):AssetImage('assets/cancel.png'),

                                              ),
                                            ),
                                          ),
                                          trailing: Text(""),
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: Container(
                                                decoration:BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(20)),

                                                child: Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Icon(Icons.format_list_numbered,color: Colors.grey,),
                                                    ),
                                                    DropdownButton(
                                                      icon: Icon(Icons.keyboard_arrow_down),iconSize: 30,isDense: false,iconDisabledColor: Colors.white12,iconEnabledColor: Color.fromRGBO(240, 151, 38, 1),
                                                      hint: Text('Animal Name / गाई बस्तुको नाम '), // Not necessary for Option 1
                                                      style: new TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),
                                                      underline: SizedBox.fromSize(),

                                                      value: _animalname,
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          _animalname = newValue;
                                                        });
                                                      },
                                                      items: animalname.map((name) {
                                                        return DropdownMenuItem(

                                                          child: new Text(name,),
                                                          value: name,
                                                        );
                                                      }).toList(),


                                                    ),
                                                  ],
                                                ),

                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 8.0,left: 40,right: 40),
                                              child: TextFormField(
                                                  enabled: _animalname!=null?true:false,
                                                  keyboardType: TextInputType.numberWithOptions(),
                                                  controller: this.editanimalquantityController,
                                                  decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),labelText: 'संख्या / Number of animals',
                                                      prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                                  ),
                                                  style: new TextStyle(fontSize: 14, color: Colors.amber,),

                                                  onSaved:(newValue){
                                                    setState(() {
                                                      _animalnumber = this.editanimalquantityController.text;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    return value.isEmpty ? 'Animal number is required' : null;
                                                  }),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                color: Color.fromRGBO(240, 151, 38, 1),
                                                child: Text("Add",style: TextStyle(fontSize: 20),),
                                                onPressed: () {

                                                  final form = _formKey4.currentState;
                                                  if(form.validate()==true){
                                                    setState(() {
                                                      expanded=false;
                                                    });
                                                    animal.addAll({
                                                      _animalname:this.editanimalquantityController.text
                                                    });
                                                    this.editanimalquantityController = new TextEditingController();
                                                    this._animalname=null;
                                                    print(animal);
                                                  }
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        //-------------build listtile with dismissible here----------------
                                        listtileanimal(),

                                        //-------------listtile end-------------------
                                      ],
                                    ),
                                  ),
                                )
                            ) : SizedBox(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(child: Text("Do you sell your agri products in market/\nतपाईंले आफ्नो कृषि उपज बजारमा बेचने गर्नुहुन्छ?",style: TextStyle(fontSize: 25,letterSpacing: 2),textAlign: TextAlign.center,)),
                        ),
                        const SizedBox(height: 10.0,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 70,
                              child: MaterialSegmentedControl(

                                children: _yesno(),
                                selectionIndex: _sellproducts,
                                borderColor: Colors.grey,
                                selectedColor: Color.fromRGBO(240, 151, 38, 1),
                                unselectedColor: Colors.white,
                                borderRadius: 20.0,
                                onSegmentChosen: (index) {
                                  setState(() {
                                    _sellproducts = index;
                                  });
                                },
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 10),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _sellproducts==2?Row(
                            children: <Widget>[
                              Expanded(
                                flex:70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("निजकैको बजारदुरी (किलोमिटरमा) / Nearest Market Distance(In Kilometer):",style: TextStyle(fontSize: 18),),
                                ),
                              ),

                              Expanded(
                                flex: 30,
                                child: TextFormField(
                                    controller: this.editmarketdistanceController,
                                    keyboardType: TextInputType.number,
                                    decoration: new InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                                        prefixIcon: Icon(FontAwesomeIcons.rupeeSign)
                                    ),
                                    style: new TextStyle(fontSize: 18, color: Colors.amber,),

                                    validator: (value){
                                      return value.isEmpty ? 'Market distance is required' : null;
                                    }),
                              ),
                            ],
                          ):SizedBox(),
                        ),
                        const SizedBox(height: 10),

                        const SizedBox(height: 10,),

                      ],
                    ),
                  ),
                ),
              ),
            ],

          ),
        ),
      ),

      floatingActionButton: new FloatingActionButton.extended(
        onPressed: (){
          if(_firstPress){
            _firstPress=false;

            this.performUpload();
          }
        },
        label: Text('Save'),
        icon: new Icon(Icons.file_upload),
        tooltip: 'Next',
      ),

    );
  }

  @override
  void initState() {
    super.initState();



    editfullNameController = new TextEditingController(text: widget.post.data['fullName']);
    editphoneController = new TextEditingController(text: widget.post.data['phone']);
    editemailController = new TextEditingController(text: widget.post.data['email']);
    editageController = new TextEditingController(text: widget.post.data['age']);
    editcurrentaddressController = new TextEditingController(text: widget.post.data['currentaddress']);
     editcityController = new TextEditingController(text: widget.post.data['city']);
     editvillageController = new TextEditingController(text: widget.post.data['village']);
     editearningController = new TextEditingController(text: widget.post.data['earning']);
     editnonearningController = new TextEditingController(text: widget.post.data['nonearning']);
     editeducationexpenseController = new TextEditingController(text: widget.post.data['educationexpense']);
     edithealthexpenseController = new TextEditingController(text: widget.post.data['healthexpense']);
     editfarmingexpenseController = new TextEditingController(text: widget.post.data['farmingexpense']);
     editfamilyexpenseController = new TextEditingController(text: widget.post.data['familyexpense']);
     editbankexpenseController = new TextEditingController(text: widget.post.data['bankexpense']);
     editsavingsexpenseController = new TextEditingController(text: widget.post.data['savingsexpense']);
     editotherfieldController = new TextEditingController(text: widget.post.data['otherexpense']);
     editotherexpenseController = new TextEditingController(text: widget.post.data['otherexpense']);
     editboringwidthController = new TextEditingController(text: widget.post.data['boringwidth']);
     editincomeController = new TextEditingController();
     editothersfieldController = new TextEditingController();
     editexpectedexpenseController = new TextEditingController();
     editlandspaceController = new TextEditingController();
     editlandspaceforcropsController = new TextEditingController();
     editanimalquantityController = new TextEditingController();
     editmarketdistanceController = new TextEditingController(text: widget.post.data['marketdistance']);
     editwardController = new TextEditingController(text: widget.post.data['ward']);

    avatarImgUrl=widget.post.data["image"];

//    _selecteddistrict=widget.post.data["district"];
//    _highesteducation=widget.post.data["highesteducation"];


     _gender=widget.post.data["sex"];
     _stateno=int.parse(widget.post.data["state"]);
     if(widget.post.data["employment"]!={}){
       _otherincome=2;
     }
     if(widget.post.data["animals"]!={}){
       _animalhusbandary=2;
     }
    if(widget.post.data["marketdistance"]!=""||widget.post.data["marketdistance"]!=null||!widget.post.data["marketdistance"]){
      _sellproducts=2;
    }
    if(widget.post.data["pumpuse"]!={}){
      _usepump=2;
    }




    employment=widget.post.data["employment"];
    animal=widget.post.data["animals"];
    lands=widget.post.data["land"];
    crops=widget.post.data["crops"];
    pump=widget.post.data["pumpuse"];


    _progressAnimcontroller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _progressAnimation = Tween<double>(begin: beginWidth, end: endWidth)
        .animate(_progressAnimcontroller);

    _setProgressAnim(5, 5);
  }

  void onexpansionchanged(bool val){
    setState(() {
      expanded=val;
    });
    print(expanded);
  }
  void _onButtonPressed(){
    showModalBottomSheet(context: context, builder: (context){
      return Column(
        children: <Widget>[
          ListTile(

            title: Text("Please select an option",style: TextStyle(fontSize: 25,color: Colors.amber),textAlign: TextAlign.center,),
            onTap: (){
              // do nothing
            },
          ),
          Card(child: ListTile(
            leading: Icon(Icons.camera),
            title: Text("Capture from Camera",style: TextStyle(fontSize: 20),),
            subtitle: Text('Note: The app will need access to your camera',style: TextStyle(fontSize: 10),),
            trailing: Icon(Icons.arrow_right),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
            onTap: (){
              getImageCamera(context);
            },
          )),
          Card(child:ListTile(
            leading: Icon(Icons.add_photo_alternate),
            title: Text("Select from Gallery",style: TextStyle(fontSize: 20),),
            subtitle: Text('Note: The app will need access to your Gallery photos',style: TextStyle(fontSize: 10),),
            trailing: Icon(Icons.arrow_right),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
            onTap: (){
              getImageGallery(context);
            },
          )),
          Card(child:ListTile(
            leading: CircleAvatar(backgroundImage: AssetImage("assets/avatar.png"),backgroundColor: Colors.amber,) ,
            title: Text("Use default avatar",style: TextStyle(fontSize: 20),),
            subtitle: Text('Note: you will reset the image to its original avatar',style: TextStyle(fontSize: 10),),
            trailing: Icon(Icons.arrow_right),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
            onTap: (){
              getImageAvatar(context);
            },
          )),
        ],
      );
    });
  }

  Widget listtile(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: employment.length,
      itemBuilder: (BuildContext context, int index) {
        String key = employment.keys.elementAt(index);
        final item = employment[index];
        return new Column(
          children: <Widget>[
            Card(
              child: Dismissible(

                background: Container(color: Colors.red),
                key: new Key(item),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  setState(() {
                    employment.remove(key);
                  });
                  // Show a snackbar. This snackbar could also contain "Undo" actions.
                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text("Data deleted"),backgroundColor: Color.fromRGBO(240, 151, 38, 1),));
                },
                child: new ListTile(
                  title: new Text("Source: $key",style: TextStyle(fontSize: 25,color: Color.fromRGBO(240, 151, 38, 1)),),
                  subtitle: new Text("Income amount: Rs. ${employment[key]}",style: TextStyle(fontSize: 25),),
                  trailing: Text("swipe\nto\ndelete",style: TextStyle(color: Colors.redAccent),),

                ),
              ),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
  Widget listtileanimal(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: animal.length,
      itemBuilder: (BuildContext context, int index) {
        String key = animal.keys.elementAt(index);
        final item = animal[index];

        return new Column(
          children: <Widget>[
            Card(
              child: Dismissible(
                background: Container(color: Colors.red),
                key: Key(item),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  setState(() {
                    animal.remove(key);
                  });
                  // Show a snackbar. This snackbar could also contain "Undo" actions.
                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text("Data deleted"),backgroundColor: Color.fromRGBO(240, 151, 38, 1),));
                },
                child: new ListTile(
                  title: new Text("Animal Name: $key",style: TextStyle(fontSize: 25,color: Color.fromRGBO(240, 151, 38, 1)),),
                  subtitle: new Text("Animal number: ${animal[key]}",style: TextStyle(fontSize: 25),),
                  trailing: Text("swipe\nto\ndelete",style: TextStyle(color: Colors.redAccent),),

                ),
              ),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  Widget listtilepump(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: pump.length,
      itemBuilder: (BuildContext context, int index) {
        String key = pump.keys.elementAt(index);
        final items = pump[index];

        return new Column(
          children: <Widget>[
            Card(
              child: Dismissible(
                background: Container(color: Colors.red),
                key: Key(items),
                onDismissed: (direction) {
                  // Remove the item from the data source.
                  setState(() {
                    pump.remove(key);
                  });
                  // Show a snackbar. This snackbar could also contain "Undo" actions.
                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text("Data deleted"),backgroundColor: Color.fromRGBO(240, 151, 38, 1),));
                  print(pump);
                },
                child: new ListTile(
                  title: new Text("Source: $key",style: TextStyle(fontSize: 25,color: Color.fromRGBO(240, 151, 38, 1)),),
                  subtitle: new Text("Expected expense: Rs. ${pump[key]}",style: TextStyle(fontSize: 25),),
                  trailing: Text("swipe\nto\ndelete",style: TextStyle(color: Colors.redAccent),),

                ),
              ),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  Widget listtilelands(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: lands.length,
      itemBuilder: (BuildContext context, int index) {
        String key = lands.keys.elementAt(index);
        final items = lands[index];

        return new Column(
          children: <Widget>[
            Card(
              child: Dismissible(
                background: Container(color: Colors.red),
                key: Key(items),
                onDismissed: (direction) {

                  // Remove the item from the data source.
                  setState(() {
                    lands.remove(key);
                  });
                  // Show a snackbar. This snackbar could also contain "Undo" actions.
                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text("data deleted"),backgroundColor: Color.fromRGBO(240, 151, 38, 1),));
                  print(lands);
                },
                child: new ListTile(
                  title: new Text("Type: $key",style: TextStyle(fontSize: 25,color: Color.fromRGBO(240, 151, 38, 1)),),
                  subtitle: new Text("Total Land: ${lands[key]}",style: TextStyle(fontSize: 25),),
                  trailing: Text("swipe\nto\ndelete",style: TextStyle(color: Colors.redAccent),),

                ),
              ),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }


  Widget listtilecrops(){
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: crops.length,
      itemBuilder: (BuildContext context, int index) {
        String key = crops.keys.elementAt(index);
        final items = crops[index];

        return new Column(
          children: <Widget>[
            Card(
              child: Dismissible(
                background: Container(color: Colors.red),
                key: Key(items),
                onDismissed: (direction) {

                  // Remove the item from the data source.
                  setState(() {
                    crops.remove(key);
                  });
                  // Show a snackbar. This snackbar could also contain "Undo" actions.
                  Scaffold
                      .of(context)
                      .showSnackBar(SnackBar(content: Text("data deleted"),backgroundColor: Color.fromRGBO(240, 151, 38, 1),));
                  print(crops);
                },
                child: new ListTile(
                  title: new Text("Crop Name: $key",style: TextStyle(fontSize: 25,color: Color.fromRGBO(240, 151, 38, 1)),),
                  subtitle: new Text("Total Land used: ${crops[key]}",style: TextStyle(fontSize: 25),),
                  trailing: Text("swipe\nto\ndelete",style: TextStyle(color: Colors.redAccent),),

                ),
              ),
            ),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

}

