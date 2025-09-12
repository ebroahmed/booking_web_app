import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking.dart';

class BookingRepository {
  final _collection = FirebaseFirestore.instance.collection('bookings');

  Future<List<Booking>> fetchBookingsForUser(String userId) async {
    final snapshot = await _collection.where('userId', isEqualTo: userId).get();
    return snapshot.docs
        .map((doc) => Booking.fromMap(doc.id, doc.data()))
        .toList();
  }

  Future<void> addBooking(Booking booking) async {
    await _collection.add(booking.toMap());
  }

  Future<void> updateBooking(Booking booking) async {
    await _collection.doc(booking.id).update(booking.toMap());
  }

  Future<void> deleteBooking(String id) async {
    await _collection.doc(id).delete();
  }
}
