import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/listing_provider.dart';
import 'presentation/pages/list_page.dart';

void main() {
  runApp(const PropertyListingApp());
}

class PropertyListingApp extends StatelessWidget {
  const PropertyListingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ListingProvider())],
      child: MaterialApp(
        title: 'Property Listings',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF0076B9),
            primary: const Color(0xFF0076B9),
          ),
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF0076B9),
            foregroundColor: Colors.white,
            titleTextStyle: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        home: const ListPage(),
      ),
    );
  }
}
