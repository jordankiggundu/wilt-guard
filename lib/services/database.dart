import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //CREATE
  Future addUser(Map<String, dynamic> userMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userMap);
  }

  //READ
  Future<Stream<QuerySnapshot>> getUsers() async {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  //READ
  Future<Map<String, dynamic>> getUser(String email, String password) async {
    // find a user by email and password
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      return {"exists": true, "data": querySnapshot.docs.first.data()};
    } else {
      return {"exists": false};
    }
  }

  //get uid for user document
  Future<String> getUid(Map<String, dynamic> userMap) async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userMap['email'])
        .get();
    String uid;
    if (querySnapshot.docs.isNotEmpty) {
      uid = querySnapshot.docs.first.id;
      return uid;
    }
    return "false";
  }

  //UPDATE
  Future updateUser(Map<String, dynamic> userMap, String? uid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update(userMap);
  }

  //DELETE
  Future deleteUser(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .delete();
  }
}
