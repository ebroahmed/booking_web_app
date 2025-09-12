// Listing card widget placeholder
import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: const Text('Listing Title'),
        subtitle: const Text('Listing Description'),
      ),
    );
  }
}
