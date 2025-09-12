import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../providers/booking_provider.dart';
import '../models/booking.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authStateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: authAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(
              child: Text('Please sign in to view your profile.'),
            );
          }
          final bookingsAsync = ref.watch(bookingProvider(user.uid));
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email: ${user.email}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                Text(
                  'Your Bookings:',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: bookingsAsync.when(
                    data: (bookings) {
                      if (bookings.isEmpty) {
                        return const Text('No bookings yet.');
                      }
                      return ListView.builder(
                        itemCount: bookings.length,
                        itemBuilder: (context, index) {
                          final Booking booking = bookings[index];
                          return Card(
                            child: ListTile(
                              title: Text('Listing: ${booking.listingId}'),
                              subtitle: Text(
                                'Date: ${booking.date.toLocal().toString().split(' ')[0]}',
                              ),
                              trailing: Text(booking.status),
                            ),
                          );
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, st) => Text('Error: $e'),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
