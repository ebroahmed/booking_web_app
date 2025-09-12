import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class UserRepository {
  final _collection = FirebaseFirestore.instance.collection('users');

  Future<User?> getUserById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return User.fromMap(doc.id, doc.data()!);
    }
    return null;
  }

  Future<void> addUser(User user) async {
    await _collection.doc(user.id).set(user.toMap());
  }

  Future<void> updateUser(User user) async {
    await _collection.doc(user.id).update(user.toMap());
  }

  Future<void> deleteUser(String id) async {
    await _collection.doc(id).delete();
  }
}
