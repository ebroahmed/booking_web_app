import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/listings_provider.dart';
import '../widgets/listing_card.dart';
import '../models/listing.dart';
import '../providers/auth_provider.dart';
import 'auth_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(listingsProvider);
    final authAsync = ref.watch(authStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Web App'),
        actions: [
          authAsync.when(
            data: (user) {
              if (user == null) {
                return IconButton(
                  icon: const Icon(Icons.login),
                  tooltip: 'Sign In',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AuthScreen()),
                    );
                  },
                );
              } else {
                return Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.account_circle),
                      tooltip: 'Profile',
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'logout') {
                          await ref.read(authRepositoryProvider).signOut();
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'logout',
                          child: const Text('Sign Out'),
                        ),
                      ],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(user.email ?? 'User'),
                      ),
                    ),
                  ],
                );
              }
            },
            loading: () => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
            error: (e, st) => const SizedBox(),
          ),
        ],
      ),
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
