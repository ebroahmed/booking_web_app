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
    return Booking(
      id: id,
      userId: data['userId'] ?? '',
      listingId: data['listingId'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      status: data['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'listingId': listingId,
      'date': date,
      'status': status,
    };
  }
}
