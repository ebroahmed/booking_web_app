// Listing detail screen placeholder
import 'package:flutter/material.dart';

class ListingDetailScreen extends StatelessWidget {
  const ListingDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Listing Details')),
      body: const Center(child: Text('Listing Detail Screen')),
    );
  }
}
