import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  //CREATE
  Future addUser( Map<String, dynamic> userMap, String id ) async {
    return await FirebaseFirestore.instance
        .collection("users").doc(id).set(userMap);
  }
  //READ
  Future <Stream<QuerySnapshot>> getUsers() async {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  //READ
  Future<bool> getUser(String email, String password) async {
    // Assuming you want to find a user by email and password
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();
    print(querySnapshot.docs.first);
    if (querySnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
  //UPDATE
  Future updateUser( Map<String, dynamic> userMap, String id ) async {
    return await FirebaseFirestore.instance
        .collection("users").doc(id).update(userMap);
  }
  //DELETE
  Future deleteUser(String id ) async {
    return await FirebaseFirestore.instance
        .collection("users").doc(id).delete();
  }
}