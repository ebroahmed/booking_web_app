import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/listing_repository.dart';
import '../models/listing.dart';

final listingRepositoryProvider = Provider<ListingRepository>(
  (ref) => ListingRepository(),
);

final listingsProvider = FutureProvider<List<Listing>>((ref) async {
  final repo = ref.watch(listingRepositoryProvider);
  return repo.fetchListings();
});
