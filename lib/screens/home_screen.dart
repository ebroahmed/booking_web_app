import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/listings_provider.dart';
import '../widgets/listing_card.dart';
import '../models/listing.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Web App')),
      body: listingsAsync.when(
        data: (listings) {
          if (listings.isEmpty) {
            return const Center(child: Text('No listings available.'));
          }
          return ListView.builder(
            itemCount: listings.length,
            itemBuilder: (context, index) {
              final Listing listing = listings[index];
              return ListingCard(listing: listing);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
