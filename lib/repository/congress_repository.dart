import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_bloc/model/congressman_model.dart';

abstract class CongressRepository {
  Future<List<DocumentSnapshot>> getAllDocuments();
  Future<List<CongressmanModel>> getCongressPeople();
  Future<void> likeCongressmanForUser(int congressmanId, String userId);
  Future<void> unlikeCongressmanForUser(int congressmanId, String userId);
}
