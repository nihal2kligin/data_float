import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/listing_model.dart';

enum ListingStatus { initial, loading, loaded, error }

class ListingProvider with ChangeNotifier {
  List<Listing> _allListings = [];
  List<Listing> _filteredListings = [];
  ListingStatus _status = ListingStatus.initial;
  String _errorMessage = '';
  String _searchQuery = '';
  bool _isSearching = false;

  List<Listing> get listings => _filteredListings;
  ListingStatus get status => _status;
  String get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  bool get isSearching => _isSearching;

  ListingProvider() {
    loadListings();
  }

  Future<void> loadListings() async {
    _status = ListingStatus.loading;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString(
        'assets/listings.json',
      );
      final data = await json.decode(response);
      final listingResponse = ListingResponse.fromJson(data);

      _allListings = listingResponse.data;
      _filteredListings = List.from(_allListings);
      _status = ListingStatus.loaded;
    } catch (e) {
      _status = ListingStatus.error;
      _errorMessage = 'Failed to load listings: $e';
    }

    notifyListeners();
  }

  void toggleSearching(bool searching) {
    _isSearching = searching;
    if (!searching) {
      clearSearch();
    }
    notifyListeners();
  }

  void searchListings(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredListings = List.from(_allListings);
    } else {
      _filteredListings = _allListings
          .where(
            (listing) =>
                listing.fullAddress.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _isSearching = false;
    _filteredListings = List.from(_allListings);
    notifyListeners();
  }
}
