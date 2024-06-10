import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethod {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addAllProduct(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Makanan")
        .doc(id)
        .set(userInfoMap);
  }

  // Future addProduct(
  //     Map<String, dynamic> userInfoMap, String categoryname) async {
  //   return await FirebaseFirestore.instance
  //       .collection(categoryname)
  //       .add(userInfoMap);
  // }

  Stream<QuerySnapshot> getMakananKategori(String category) {
    return FirebaseFirestore.instance
        .collection("Makanan")
        .where("Category", isEqualTo: category)
        .snapshots();
  }

  // Future<Stream<QuerySnapshot>> getProducts(String category) async {
  //   return await FirebaseFirestore.instance.collection(category).snapshots();
  // }

  Future<QuerySnapshot> search(String updatedname) async {
    return await FirebaseFirestore.instance
        .collection("Makanan")
        .where("SearchKey",
            isEqualTo: updatedname.substring(0, 1).toUpperCase())
        .get();
  }

  Future<Stream<QuerySnapshot>> getMakanan() async {
    return await FirebaseFirestore.instance.collection("Makanan").snapshots();
  }

  Future updateMakanan(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Makanan")
        .doc(id)
        .update(updateInfo);
  }

  Future updateUser(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update(updateInfo);
  }

  Future<void> deleteMakanan(String id) async {
    try {
      print("Deleting document with id: $id");
      await FirebaseFirestore.instance.collection("Makanan").doc(id).delete();
      print("Document successfully deleted!");
    } catch (e) {
      print("Error deleting document: $e");
    }
  }
}
