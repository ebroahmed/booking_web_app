import 'package:flutter_riverpod/flutter_riverpod.dart';

// Placeholder: In a real app, this would be a StreamProvider or FutureProvider for FirebaseAuth user
final authProvider = StateProvider<String?>(
  (ref) => null,
); // Holds the current userId or null
