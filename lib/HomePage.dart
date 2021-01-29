import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/search.dart';
import 'About.dart';
import 'Authentication.dart';
import 'NewPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DetailPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Imports for Online database
import 'package:flutter_app/online_db/OnlineDatabase.dart';

// Imports for Offline database
import 'package:flutter_app/local_db/OfflineClientModel.dart';
import 'package:flutter_app/local_db/OfflineDatabase.dart';

// Imports for syncing offline data
import 'package:flutter_app/sync_db/SyncOfflineData.dart';

import 'editPost.dart';
import 'faq.dart';

class HomePage extends StatefulWidget {
  HomePage({
    this.auth,
    this.onSignedOut,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String email;

  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  post: post,
                )));
  }

  navigateToSearch() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  Future getEmail() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    this.email = user.email;
    return this.email;
  }

  // ----------------------------------------------------------------------------//
  // Updated code below ........

  // Scroll controller for online data show
  ScrollController onlineClientDataController;

  // Online database instance
  OnlineDBProvider onlineDatabase;
  Future<List<DocumentSnapshot>> onlineClientData;

  // Scroll controller for offline data show
  //ScrollController offlineClientDataController;

  // Offline database instance
  OfflineDBProvider offlineDatabase;
  Future<List<Client>> offlineClientData;

  // draft database instance
  Future<List<Client>> draftClientData;

  // Database Sync class instance
  SyncOfflineData syncOfflineData;

  // Function to load more online client data on scroll
  onlineClientDataControllerFunction() {
    if (onlineClientDataController.offset >=
            onlineClientDataController.position.maxScrollExtent &&
        !onlineClientDataController.position.outOfRange) {
      setState(() {
        onlineClientData = onlineDatabase.getAdditionalPosts();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // init for offline user data
    onlineClientDataController = ScrollController();
    onlineClientDataController.addListener(onlineClientDataControllerFunction);

    onlineDatabase = OnlineDBProvider.db;
    onlineClientData = onlineDatabase.getInitialPosts();

    //init for online user data
    offlineDatabase = OfflineDBProvider.db;
    offlineClientData = offlineDatabase.getCompleteClients();

    //init for draft user data
    draftClientData = offlineDatabase.getIncompleteClients();

    //start the db syncing process
    syncOfflineData = SyncOfflineData();
    syncOfflineData.start();
  }

  Future<void> refreshOnlineClientData() async {
    //await new Future.delayed(const Duration(seconds: 5));
    setState(() {
      onlineClientData = onlineDatabase.getInitialPosts();
    });
  }

  Future<void> syncofflinedata() async {
    if (await hasConnection()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("Do you want to Sync the data stored offline?"),
              content: new Text(
                  "Syncing data ensures you that you won't be loosing data"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text("Cancel")),
                new FlatButton(
                    onPressed: () {
                      syncOfflineData = SyncOfflineData();
                      syncOfflineData.start();
                      refreshOfflineClientData();
                      Navigator.of(context).pop(true);
                    },
                    child: new Text("Sync"))
              ],
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("No Internet Connection!!🔺"),
              content: new Text(
                  "Data cannot be synced when you are offline. Please try again after getting connected to internet."),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: new Text("OK")),
              ],
            );
          });
    }
  }

  Future<void> refreshOfflineClientData() async {
    setState(() {
      offlineClientData = offlineDatabase.getCompleteClients();
    });
//    syncOfflineData = SyncOfflineData();
//    syncOfflineData.start();
  }

  Future<bool> hasConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // ignore: unnecessary_statements
        return true;
      }
    } on SocketException catch (_) {
      //print('not connected');
      return false;
    }
    return false;
  }

  Future<void> refreshDraftClientData() async {
    setState(() {
      draftClientData = offlineDatabase.getIncompleteClients();
    });
  }

  // version controlling here
  final version = Text(
    'Version Beta\n\n Built By Team Kazi',
    textAlign: TextAlign.center,
    style: TextStyle(
      color: Colors.grey,
      letterSpacing: 3,
    ),
  );

  navigateToEdit(DocumentSnapshot post) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => editPostPage(post)));
  }

  void delete(posts) async {
    final db = Firestore.instance;
    await db.collection('posts').document(posts['timekey']).delete();
  }

  void _showDialog(posts) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Are you sure you want to delete?"),
            content:
                new Text("Once the data is deleted, It is not recoverable"),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: new Text("Cancel")),
              new FlatButton(
                  onPressed: () {
                    delete(posts);
                    Navigator.of(context).pop(true);
                  },
                  child: new Text("Delete"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    getEmail();
    //WillPop scope used to disable the back button in home page
    return WillPopScope(
      //required for disabling back
      onWillPop: () async => false,

      child: MaterialApp(
          title: "MyApp",
          theme: new ThemeData(
            primaryColor: Color.fromRGBO(240, 151, 38, 1),
            primaryColorLight: Color.fromRGBO(111, 196, 242, 1),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: new AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                title: new Text("GhamPower"),
                centerTitle: true,
                actions: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.sync),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      syncofflinedata();
                    },
                  ),
                  new IconButton(
                    icon: new Icon(Icons.search),
                    iconSize: 30,
                    color: Colors.white,
                    onPressed: () {
                      navigateToSearch();
                    },
                  ),
                ],

                //for tabs in header
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.blueGrey,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.cloud_done),
                      text: "Synced data",
                    ),
                    Tab(icon: Icon(Icons.cloud_off), text: "Unsynced data"),
                    Tab(
                      icon: Icon(Icons.drafts),
                      text: "Drafts data",
                    ),
                  ],
                ),
              ),
              drawer: Drawer(
                  child: Container(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    new SizedBox(
                      height: 300,
                      child: DrawerHeader(
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(-3, 2),
                                blurRadius: 10.0,
                              ),
                            ],
                            color: Color.fromRGBO(240, 151, 38, 1),
                          ),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 70,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: new SizedBox(
                                          width: 136.0,
                                          height: 136.0,
                                          child: CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  "assets/logo2.png")),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Gham Power",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: this.email == null
                                      ? Text("loading.",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0))
                                      : Text(
                                          this.email,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0),
                                        ),
                                )
                              ],
                            ),
                          )),
                    ),
                    CustomListTile(Icons.info, "About Us", () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => About()));
                    }),
                    CustomListTile(Icons.wb_incandescent, "FAQ", () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Faq()));
                    }),
                    CustomListTile(Icons.lock, "Log Out", () {
                      _logoutUser();
                    }),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 90.0),
                          child: version,
                        ),
                      ),
                    ),
                  ],
                ),
              )),

              // Starting the code for tab bars...
              body: new TabBarView(
                children: [
                  // Tab for ONLINE database display
                  new Container(
                    // To show data from local db
                    child: FutureBuilder<List<DocumentSnapshot>>(
                      future: onlineClientData,
                      // ignore: missing_return
                      builder: (BuildContext context,
                          AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                        try {
                          if (snapshot.hasData || snapshot.data == null) {
                            if (snapshot.data.length < 1) {
                              // ignore: missing_return
                              return Center(
                                child: Text("No data found"),
                              );
                            }
                            //return new Text(snapshot.data.length.toString());
                            return RefreshIndicator(
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),

                                controller: onlineClientDataController,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot item = snapshot.data[index];
                                  return Card(
                                    child: ListTile(
                                      leading: Container(
                                        width: 55.0,
                                        height: 55.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromRGBO(111, 196, 242, 1),
                                          // image: DecorationImage(
                                          //   image: CachedNetworkImageProvider(
                                          //       item.data['image']),
                                          // ),
                                        ),
                                      ),
                                      title: Text(
                                        item.data['fullName'],
                                        style: TextStyle(
                                          fontSize: 22,
                                          color:
                                              Color.fromRGBO(240, 151, 38, 1),
                                        ),
                                      ),
                                      subtitle: Text(
                                        item.data['date'].toString() +
                                            "\n" +
                                            item.data['time'].toString(),
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      isThreeLine: true,
                                      trailing: Icon(
                                        Icons.keyboard_arrow_right,
                                        color: Color.fromRGBO(240, 151, 38, 1),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 5.0),
                                      onTap: () {
                                        navigateToDetail(item);
                                      },
                                      onLongPress: () {
                                        return showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return SimpleDialog(
                                                elevation: 2,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  side: BorderSide(
                                                    style: BorderStyle.none,
                                                  ),
                                                ),
                                                title: const Text(
                                                  'Select Option ',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Color.fromRGBO(
                                                          240, 151, 38, 1)),
                                                  textAlign: TextAlign.left,
                                                ),
                                                children: <Widget>[
                                                  Center(
                                                    child: Container(
                                                      color: Colors.black12,
                                                      alignment:
                                                          Alignment(0.0, 1),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child:
                                                                MaterialButton(
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  new Icon(
                                                                    Icons.edit,
                                                                    size: 25,
                                                                  ),
                                                                  Text(
                                                                    ' Edit',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ],
                                                              ),
                                                              color: Colors
                                                                  .lightBlueAccent,
                                                              textColor:
                                                                  Colors.white,
                                                              splashColor:
                                                                  Colors.blue,
                                                              colorBrightness:
                                                                  Brightness
                                                                      .light,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 30,
                                                                      bottom:
                                                                          30,
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              height: 45,
                                                              minWidth: 115,
                                                              elevation: 10,
                                                              highlightElevation:
                                                                  10,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);

                                                                navigateToEdit(
                                                                    item);
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child:
                                                                MaterialButton(
                                                              child: Row(
                                                                children: <
                                                                    Widget>[
                                                                  new Icon(
                                                                    Icons
                                                                        .delete,
                                                                    size: 25,
                                                                  ),
                                                                  Text(
                                                                    ' Delete',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ],
                                                              ),
                                                              color: Colors
                                                                  .redAccent,
                                                              textColor:
                                                                  Colors.white,
                                                              splashColor:
                                                                  Colors.blue,
                                                              colorBrightness:
                                                                  Brightness
                                                                      .light,
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 30,
                                                                      bottom:
                                                                          30,
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              height: 45,
                                                              minWidth: 105,
                                                              elevation: 10,
                                                              highlightElevation:
                                                                  10,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(true);

                                                                _showDialog(
                                                                    item);
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            });
                                      },
                                    ),
                                  );
                                }, // ItemBuilder
                              ),
                              onRefresh: refreshOnlineClientData,
                            );
                          } else {
                            // return loading sign widget ... or text
                            //return Center(child: new Image.asset("assets/loading1.gif", scale: 1.8,));
                            return Center(child: CircularProgressIndicator());
                          }
                        } on NoSuchMethodError {
                          return Center(child: CircularProgressIndicator());
                        }
                      }, // builder
                    ),
                  ),

                  // Tab for offline data
                  new Container(
                      child: FutureBuilder<List<Client>>(
                    future: offlineClientData,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Client>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          // built has not started yet
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          //Awaiting result...
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return new RefreshIndicator(
                              child: new ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Client item = snapshot.data[index];

                                  return Card(
                                    child: new ListTile(
                                        leading: Container(
                                          width: 55.0,
                                          height: 55.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(
                                                111, 196, 242, 1),
                                            // image: DecorationImage(
                                            //   image: CachedNetworkImageProvider(
                                            //       item.image),
                                            // ),
                                          ),
                                        ),
                                        title: new Text(item.fullName),
                                        subtitle: Text(
                                          item.date + "\n" + item.time,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        isThreeLine: true,
                                        trailing: const Icon(
                                            Icons.keyboard_arrow_right),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 5.0),
                                        onTap: () {
                                          //DBProvider.db.deleteClient(index.id);
                                        }),
                                  );
                                },
                              ),
                              onRefresh: refreshOfflineClientData,
                            );
                          }
                          break;
                        default:
                          return null;
                      }
                    },
                  )),

                  // Tab for draft data
                  new Container(
                      child: FutureBuilder<List<Client>>(
                    future: draftClientData,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Client>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          // built has not started yet
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          //Awaiting result...
                          return Center(child: CircularProgressIndicator());
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return new RefreshIndicator(
                              child: new ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Client item = snapshot.data[index];

                                  return Card(
                                    child: new ListTile(
                                        leading: Container(
                                          width: 55.0,
                                          height: 55.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromRGBO(
                                                111, 196, 242, 1),
                                            // image: DecorationImage(
                                            //   image: CachedNetworkImageProvider(
                                            //       item.image),
                                            // ),
                                          ),
                                        ),
                                        title: new Text(item.fullName),
                                        subtitle: Text(
                                          item.date + "\n" + item.time,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                        isThreeLine: true,
                                        trailing: const Icon(
                                            Icons.keyboard_arrow_right),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 5.0),
                                        onTap: () {
                                          //DBProvider.db.deleteClient(index.id);
                                        }),
                                  );
                                },
                              ),
                              onRefresh: refreshDraftClientData,
                            );
                          }
                          break;
                        default:
                          return null;
                      }
                    },
                  )),
                ],
              ),

              floatingActionButton: new FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                  backgroundColor: Color.fromRGBO(240, 151, 38, 1),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return new NewPostPage();
                    }));
                  }),
            ),
          )),
    );
  }
}

class CustomListTile extends StatelessWidget {
  IconData icon;
  String text;
  Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200))),
        child: InkWell(
          splashColor: Colors.amberAccent,
          onTap: onTap,
          child: Container(
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
