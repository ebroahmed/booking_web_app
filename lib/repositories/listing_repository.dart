import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/listing.dart';

class ListingRepository {
  final _collection = FirebaseFirestore.instance.collection('listings');

  Future<List<Listing>> fetchListings() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => Listing.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<Listing?> getListingById(String id) async {
    final doc = await _collection.doc(id).get();
    if (doc.exists) {
      return Listing.fromMap(doc.id, doc.data()!);
    }
    return null;
  }

  Future<void> addListing(Listing listing) async {
    await _collection.add(listing.toMap());
  }

  Future<void> updateListing(Listing listing) async {
    await _collection.doc(listing.id).update(listing.toMap());
  }

  Future<void> deleteListing(String id) async {
    await _collection.doc(id).delete();
  }
}
