import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future<void> createUserData(
    String name,
    String image,
    String address,
    String city,
    String contactNo,
    String postcode,
    String state,
    String uid,
  ) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'image': image,
      'address': address,
      'city': city,
      'contactNo': contactNo,
      'postcode': postcode,
      'state': state,
    });
  }

  Future updateUserData(String image, String address, String city,
      String contactNo, String postcode, String state, String uid) async {
    return await userCollection.doc(uid).update({
      'image': image,
      'address': address,
      'city': city,
      'contactNo': contactNo,
      'postcode': postcode,
      'state': state,
    });
  }

  Future getUserdata() async {
    List itemsList = [];

    try {
      await userCollection.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
