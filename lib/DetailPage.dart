import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/editPost.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Authentication.dart';
import 'HomePage.dart';
import 'Mapping.dart';


class DetailPage extends StatefulWidget {

  final DocumentSnapshot post;
  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}



class _DetailPageState extends State<DetailPage> {
  ScrollController scrollController;


  @override
  void initState() {
    super.initState();
      print(widget.post.data);
//    employment.add(widget.post.data["employment"]);
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override

  Widget build (BuildContext context) {

    void _showDialog(){
      showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              title: new Text("Are you sure you want to delete?"),
              content: new Text("Once the data is deleted, It is not recoverable"),
              actions: <Widget>[
                new FlatButton(onPressed: (){Navigator.pop(context);}, child: new Text("Cancel")),
                new FlatButton(onPressed: (){
                  final db = Firestore.instance;
                  db.collection('posts').document(widget.post.data['timekey']).delete();
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>MappingPage(auth: Auth(),)));
                  }, child: new Text("Delete"))
              ],
            );
          }
      );
    }
    navigateToEdit(DocumentSnapshot post){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>editPostPage(post)));
    }
    void choiceAction(String choice){
      if(choice == Constants.Edit){
        navigateToEdit(widget.post);
      }else if(choice == Constants.Delete){
        _showDialog();
      }

    }
    return Scaffold(

      body: DefaultTabController(
        length: 5,
        child: new NestedScrollView(
            controller: scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
//            leading: Icon(Icons.arrow_back),

              iconTheme: IconThemeData(color: Colors.white),
              actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context){
                    return Constants.choices.map((String choice){
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                )
              ],
              expandedHeight: 230.0,
              floating: false,
              pinned: true,
              flexibleSpace: new FlexibleSpaceBar(
                centerTitle: true,
                title: Text(widget.post.data['fullName'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      backgroundColor: Colors.white54,
                    )),
                  background: Image.network(
                    widget.post.data['image'],
                    fit: BoxFit.cover,
                  ),
              ),
            ),
            SliverPersistentHeader(

              delegate: _SliverAppBarDelegate(

                TabBar(
                  indicatorColor: Colors.white,

                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white54,
                  tabs: [

                    Tab(icon: Icon(Icons.person), text: "Personal",),
                    Tab(icon: Icon(Icons.monetization_on),text: "Economic Condition"),
                    Tab(icon: Icon(Icons.merge_type),text: "Project Type"),
                    Tab(icon: Icon(Icons.local_florist),text: "Farming"),
                    Tab(icon: Icon(Icons.looks),text: "Agriculture"),

                  ],
                ),
              ),
              pinned: true,
            ),
          ];},

          body: new TabBarView(
            children: <Widget>[
              new Container(
                child: ListView(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
                      ListTile(
                        title: Text('Full Name',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['fullName'],style: TextStyle(fontSize: 24),),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('Sex',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['sex'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('Age',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['age'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('Current Address',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['currentaddress'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('Phone',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['phone'],style: TextStyle(fontSize: 24),),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('Email',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['email'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text("Other Details",style: TextStyle(fontSize: 24,color:Color.fromRGBO(240, 151, 38, 1)),),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('State*',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['state'],style: TextStyle(fontSize: 24),),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('District',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['district'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('City',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['city'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('Ward number',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['ward'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('Village',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['village'],style: TextStyle(fontSize: 24),),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('Total Members',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:<Widget>[
                                Text("Earning: "+widget.post.data['earning'],style: TextStyle(fontSize: 24),),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Non-Earning: "+widget.post.data['nonearning'],style: TextStyle(fontSize: 24),),
                              ],
                            ),

                          ],
                        ),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),
                      ListTile(
                        title: Text('Highest Education in Family',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                        subtitle: Text(widget.post.data['highesteducation'],style: TextStyle(fontSize: 24),),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                        onTap: (){

                        },
                        onLongPress: (){},
                      ),

                    ],
                  ).toList(),
                    ),
              ),
              new Container(

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                            child: Container(
                              child: Text("Income other than farming:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1)),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: widget.post.data['employment']!= {}?ListView.builder(
                              primary: false,

                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.post.data['employment'].length,
                              itemBuilder: (BuildContext context, int index){
                                String key = widget.post.data['employment'].keys.elementAt(index);
                                return ListTile(
                                  title: Text("$key",style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                  subtitle: Text("${widget.post.data['employment'][key]}",style: TextStyle(fontSize: 24),),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                  onTap: (){

                                  },
                                  onLongPress: (){},
                                );
                              },
                            ):Container(
                              child: Text("NO other Income",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                            child: Container(

                              child: Text("Expenses Per Month In:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1)),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(

                            child: ListView(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: [
                                  ListTile(
                                    title: Text('Education ',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                    subtitle: Text("Rs. "+widget.post.data['educationexpense'],style: TextStyle(fontSize: 24),),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                    onTap: (){

                                    },
                                    onLongPress: (){},
                                  ),
                                  ListTile(
                                    title: Text('Health',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                    subtitle: Text("Rs. "+widget.post.data['healthexpense'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                    onTap: (){

                                    },
                                    onLongPress: (){},
                                  ),
                                  ListTile(
                                    title: Text('Agriculture / Farming',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                    subtitle: Text("Rs. "+widget.post.data['farmingexpense'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                    onTap: (){

                                    },
                                    onLongPress: (){},
                                  ),
                                  ListTile(
                                    title: Text('Family Expenses',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                    subtitle: Text("Rs. "+widget.post.data['familyexpense'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                    onTap: (){

                                    },
                                    onLongPress: (){},
                                  ),
                                  ListTile(
                                    title: Text('EMI for bank or finance',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                    subtitle: Text("Rs. "+widget.post.data['bankexpense'],style: TextStyle(fontSize: 24),),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                    onTap: (){

                                    },
                                    onLongPress: (){},
                                  ),
                                  ListTile(
                                    title: Text('Finance saving',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                    subtitle: Text("Rs. "+widget.post.data['savingsexpense'],style: TextStyle(fontSize: 24),),

//                        trailing: Icon(Icons.keyboard_arrow_right),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                    onTap: (){

                                    },
                                    onLongPress: (){},
                                  ),
                                  ListTile(
                                    title: Text('Others',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                    subtitle: Text("Rs. "+widget.post.data['otherexpense'],style: TextStyle(fontSize: 24),),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                    onTap: (){

                                    },
                                    onLongPress: (){},
                                  ),
                                ],
                              ).toList(),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              new Container(

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                            child: Container(
                              child: Text("Uses pump to get water:",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1)),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: widget.post.data['pumpuse']!=null?ListView.builder(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.post.data['pumpuse'].length,
                              itemBuilder: (BuildContext context, int index){
                                String key = widget.post.data['pumpuse'].keys.elementAt(index);
                                List strings="${widget.post.data['pumpuse']}".split("Type--");
                                return ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom:8.0),
                                    child: Text("From: "+strings[0].replaceAll("{",''),style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: <Widget>[
                                          Flexible(child: Text("Pump Type: "+strings[1].split(":")[0].replaceAll("}",''),style: TextStyle(fontSize: 24),)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(child: Text("Estimated Monthly Expense: "+"${widget.post.data['pumpuse'][key]}",style: TextStyle(fontSize: 24),)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                  onTap: (){

                                  },
                                  onLongPress: (){},
                                );
                              },
                            ):SizedBox(
                              child: Container(
                                child: Text("NO other Income",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                            child: Container(

                              child: Text("Boring Width: ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1)),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(

                            child: ListView(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: [
                                  ListTile(
                                    title: Text('Width of boring using currently ',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                    subtitle: Text(widget.post.data['boringwidth']+" inches",style: TextStyle(fontSize: 24),),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                    onTap: (){

                                    },
                                    onLongPress: (){},
                                  ),
                                ],
                              ).toList(),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              new Container(

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                            child: Container(
                              child: Text("Information related to cultivable land",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1)),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: widget.post.data['land']!=null?ListView.builder(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.post.data['land'].length,
                              itemBuilder: (BuildContext context, int index){
                                String key = widget.post.data['land'].keys.elementAt(index);
                                List strings="${widget.post.data['land']}".split("In--");
                                return ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom:8.0),
                                    child: Text("Land Type: "+strings[0].replaceAll("{",''),style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,

                                        children: <Widget>[
                                          Flexible(child: Text("Land owner status: "+strings[1].split(":")[0].replaceAll("}",''),style: TextStyle(fontSize: 24),)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(child: Text("Land's Area: "+"${widget.post.data['land'][key]}",style: TextStyle(fontSize: 24),)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),

                                  onLongPress: (){},
                                );
                              },
                            ):SizedBox(
                              child: Container(
                                child: Text("NO Land Data found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                            child: Container(

                              child: Text("Crops details: ",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1)),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: widget.post.data['crops']!=null?ListView.builder(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.post.data['crops'].length,
                              itemBuilder: (BuildContext context, int index){
                                String key = widget.post.data['crops'].keys.elementAt(index);
                                List strings="${widget.post.data['crops']}".split("Type--");
                                return ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(top:8.0),
                                    child: Text("Crop Name: "+strings[0].replaceAll("{",''),style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                  ),
                                  subtitle: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(child: Text("Crops Type: "+strings[1].split(":")[0].replaceAll("}",''),style: TextStyle(fontSize: 24),)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(child: Text("Land Used for production: "+"${widget.post.data['crops'][key]}",style: TextStyle(fontSize: 24),)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                  onTap: (){

                                  },
                                  onLongPress: (){},
                                );
                              },
                            ):SizedBox(
                              child: Container(
                                child: Text("NO Crops related data found",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              new Container(

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                            child: Container(
                              child: Text("Animal Husbandary information",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1)),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: widget.post.data['animals']!=null?ListView.builder(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: widget.post.data['animals'].length,
                              itemBuilder: (BuildContext context, int index){
                                String key = widget.post.data['animals'].keys.elementAt(index);
                                return ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom:8.0),
                                    child: Text("Animal Name: "+"$key",style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                  ),
                                  subtitle: Text("Number of Animal: "+"${widget.post.data['animals'][key]}",style: TextStyle(fontSize: 24),),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                  onTap: (){

                                  },
                                  onLongPress: (){},
                                );
                              },
                            ):SizedBox(
                              child: Container(
                                child: Text("NO other Income",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:18.0,left: 10,right: 10),
                            child: Container(

                              child: Text("Product selling information",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(240, 151, 38, 1)),),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(

                            child: widget.post.data["marketdistance"] !=null?ListView(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: ListTile.divideTiles(
                                context: context,
                                tiles: [
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Text('Nearest market Distance ',style: TextStyle(fontSize: 18,color: Color.fromRGBO(240, 151, 38, 1)),),
                                    ),
                                    subtitle: Text(widget.post.data['marketdistance']+" Kilometers",style: TextStyle(fontSize: 24),),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                                    onTap: (){

                                    },
                                    onLongPress: (){},
                                  ),
                                ],
                              ).toList(),
                            ):SizedBox(
                              child: Container(
                                child: Text("Does not sell products to market",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ],

          )
        ),
      ),


    );

  }


}
class Constants{
  static const String Edit = 'Edit';
  static const String Delete = 'Delete';


  static const List<String> choices = <String>[
    Edit,
    Delete,

  ];
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(

      color: Color.fromRGBO(240, 151, 38, 1),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}