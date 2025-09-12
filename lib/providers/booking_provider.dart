import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/booking_repository.dart';
import '../models/booking.dart';

final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => BookingRepository(),
);

final bookingProvider = FutureProvider.family<List<Booking>, String>((
  ref,
  userId,
) async {
  final repo = ref.watch(bookingRepositoryProvider);
  return repo.fetchBookingsForUser(userId);
});
