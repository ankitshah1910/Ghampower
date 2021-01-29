import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OnlineDBProvider{

  // for making instance of itself..
  OnlineDBProvider._();

  // static method to store the db var..
  static final OnlineDBProvider db = OnlineDBProvider._();

  // Declearing some vars to use inside this class
  Firestore fireStore = Firestore.instance;
  List<DocumentSnapshot> posts = [];
  String email = "";
  int perPage = 10;
  DocumentSnapshot lastDocument;

  Future<List<DocumentSnapshot>> getInitialPosts() async{
    // Setting up query to fetch data from fireBase
    Query query = this.fireStore.collection("posts").orderBy("timestamp", descending: true).limit(this.perPage);
    QuerySnapshot querySnapshot = await query.getDocuments();

    if(querySnapshot.documents.length > 0){
      this.lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
      //this.posts.addAll(querySnapshot.documents);
      this.posts = querySnapshot.documents;
      this.posts.toSet().toList();
    }

    // Returning the list of post wherever called..
    return this.posts;
  }

  Future<List<DocumentSnapshot>> getAdditionalPosts() async{
    Query query = this.fireStore.collection("posts").orderBy("timestamp",descending: true).startAfter([this.lastDocument.data['timestamp']]).limit(this.perPage);
    QuerySnapshot querySnapshot = await query.getDocuments();

    // fetch the data, update class vars...
    if(querySnapshot.documents.length > 0){
      this.lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
      //this.posts.addAll(querySnapshot.documents);
      this.posts = new List.from(this.posts)..addAll(querySnapshot.documents);
      this.posts.toSet().toList();
    }

    // Finally return back data
    return this.posts;
  }

}// end of class territory