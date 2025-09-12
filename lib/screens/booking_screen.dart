import 'package:flutter/material.dart';
import '../models/listing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/booking_provider.dart';
import '../models/booking.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final Listing listing;
  const BookingScreen({super.key, required this.listing});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  DateTime? _selectedDate;
  bool _loading = false;

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _submitBooking() async {
    if (_selectedDate == null) return;
    setState(() => _loading = true);
    try {
      // In a real app, get userId from auth provider
      const userId = 'demo_user';
      final booking = Booking(
        id: '', // Firestore will auto-generate
        userId: userId,
        listingId: widget.listing.id,
        date: _selectedDate!,
        status: 'pending',
      );
      await ref.read(bookingRepositoryProvider).addBooking(booking);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Booking successful!')));
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Now')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.listing.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text('Select booking date:'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No date selected'
                        : _selectedDate!.toLocal().toString().split(' ')[0],
                  ),
                ),
                ElevatedButton(
                  onPressed: _loading ? null : () => _pickDate(context),
                  child: const Text('Pick Date'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: _loading || _selectedDate == null
                    ? null
                    : _submitBooking,
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
