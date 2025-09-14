import 'package:booking_web_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'models/listing.dart';
import 'screens/listing_detail_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booking Web App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == '/listing') {
          final listing = settings.arguments;
          if (listing is! Listing) return null;
          return MaterialPageRoute(
            builder: (_) => ListingDetailScreen(listing: listing),
          );
        }
        if (settings.name == '/profile') {
          return MaterialPageRoute(builder: (_) => const ProfileScreen());
        }
        return null;
      },
    );
  }
}
