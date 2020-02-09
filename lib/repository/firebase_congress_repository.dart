import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_bloc/model/congressman_model.dart';
import 'package:firebase_bloc/repository/congress_repository.dart';

class FirebaseCongressRepository implements CongressRepository {
  final politicosRef = Firestore.instance.collection('politicos');

  FirebaseCongressRepository({this.ref});

  final CollectionReference ref;

  @override
  Future<List<DocumentSnapshot>> getAllDocuments() async {
    final querySnapshot = await politicosRef.getDocuments();
    return querySnapshot.documents;
  }

  @override
  Future<List<CongressmanModel>> getCongressPeople() async {
    final documents = await getAllDocuments();
    return List.generate(
        documents.length, (i) => CongressmanModel.fromJson(documents[i].data));
  }

  @override
  Future<void> likeCongressmanForUser(int congressmanId, String userId) async {
    final documents =
        await politicosRef.where('id', isEqualTo: congressmanId).getDocuments();
    final docId = documents.documents[0].documentID;
    final congressRef = politicosRef.document(docId);
    final infoCongress = await congressRef.get();
    final likers = infoCongress.data['likers'] ?? [];
    likers.add(userId);
    congressRef.setData({'likers': likers}, merge: true);
  }

  @override
  Future<void> unlikeCongressmanForUser(
      int congressmanId, String userId) async {
    final documents =
        await politicosRef.where('id', isEqualTo: congressmanId).getDocuments();
    final docId = documents.documents[0].documentID;
    final congressRef = politicosRef.document(docId);
    final infoCongress = await congressRef.get();
    final likers = infoCongress.data['likers'] ?? [];
    likers.remove(userId);
    congressRef.setData({'likers': likers}, merge: true);
  }
}
