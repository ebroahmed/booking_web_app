import 'package:flutter/material.dart';
import '../models/listing.dart';
import 'booking_screen.dart';

class ListingDetailScreen extends StatelessWidget {
  final Listing listing;
  const ListingDetailScreen({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(listing.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                listing.imageUrl,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 100),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              listing.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(listing.description),
            const SizedBox(height: 8),
            Text('Price: \u0024${listing.price.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('Available: ${listing.available ? "Yes" : "No"}'),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: listing.available
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingScreen(listing: listing),
                          ),
                        );
                      }
                    : null,
                child: const Text('Book Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
