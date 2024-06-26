import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
}
