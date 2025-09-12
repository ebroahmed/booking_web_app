import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String userId;
  final String listingId;
  final DateTime date;
  final String status;

  Booking({
    required this.id,
    required this.userId,
    required this.listingId,
    required this.date,
    required this.status,
  });

  factory Booking.fromMap(String id, Map<String, dynamic> data) {
    final dynamic dateField = data['date'];
    DateTime dateValue;
    if (dateField is Timestamp) {
      dateValue = dateField.toDate();
    } else if (dateField is DateTime) {
      dateValue = dateField;
    } else {
      dateValue = DateTime.now();
    }
    return Booking(
      id: id,
      userId: data['userId'] ?? '',
      listingId: data['listingId'] ?? '',
      date: dateValue,
      status: data['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'listingId': listingId,
      'date': Timestamp.fromDate(date),
      'status': status,
    };
  }
}
