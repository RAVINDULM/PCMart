// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_app/utils/models/products.dart';

// class DatabaseService {

//   final String uid;
//   DatabaseService({ this.uid });

//   // collection reference
//   final CollectionReference brewCollection = FirebaseFirestore.instance();



//   // get brews stream
//   Stream<List<Products>> get products {
//     return productsCollection.snapshots()
//       .map(_brewListFromSnapshot);
//   }

//   // get user doc stream
//   // Stream<UserData> get userData {
//   //   return brewCollection.document(uid).snapshots()
//   //     .map(_userDataFromSnapshot);
//   // }

// }