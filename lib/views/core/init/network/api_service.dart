import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantist_project/views/base/service/base_service.dart';
import 'package:plantist_project/views/core/init/network/base_result.dart';

class ApiService extends BaseService {

  Future<BaseResult> getDocumentById(
      String collectionName, String documentId) async {
    try {
      DocumentSnapshot<BaseResult> documentSnapshot = (await firestore
          .collection(collectionName)
          .doc(documentId)
          .get()) as DocumentSnapshot<BaseResult>;

      return BaseResult(success: true, message: "", data: documentSnapshot.data());
    } catch (e) {
      print("Hata: $e");
      rethrow;
    }
  }

  // Örnek: Koleksiyona yeni bir belge ekleme
  Future<void> addDocument(String collectionName, Map<String, dynamic> data) async {
    try {
      await firestore.collection(collectionName).add(data);
    } catch (e) {
      print("Hata: $e");
      rethrow;
    }
  }

  // Örnek: Koleksiyondaki belgeleri getirme
  Future<BaseResult> getCollectionStream(String collectionName) async{
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection(collectionName).get();

      List<Map<String, dynamic>> documents = querySnapshot.docs.map((doc) => doc.data()).toList();
      return BaseResult(data: documents, success: true, message: '');
  }
}
