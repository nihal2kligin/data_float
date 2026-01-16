import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/listing_provider.dart';
import '../../widgets/listing_card.dart';
import '../pages/detail_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ListingProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFF0076B9),
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: provider.isSearching
                ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      _searchController.clear();
                      provider.toggleSearching(false);
                    },
                  )
                : null,
            title: provider.isSearching
                ? Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(51),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      onChanged: (value) {
                        provider.searchListings(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 24,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            provider.clearSearch();
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  )
                : const Text(
                    'Listings',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
            actions: [
              if (!provider.isSearching)
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    provider.toggleSearching(true);
                  },
                ),
            ],
          ),
          body: _buildBody(provider),
        );
      },
    );
  }

  Widget _buildBody(ListingProvider provider) {
    if (provider.status == ListingStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.status == ListingStatus.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                provider.errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: provider.loadListings,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    final listings = provider.listings;

    if (listings.isEmpty) {
      return const Center(child: Text('No listings found.'));
    }

    return Stack(
      children: [
        ListView.separated(
          padding: const EdgeInsets.only(top: 8, bottom: 80),
          itemCount: listings.length,
          separatorBuilder: (context, index) => const Divider(
            height: 1,
            thickness: 1,
            indent: 12,
            endIndent: 12,
            color: Color(0xFFEEEEEE),
          ),
          itemBuilder: (context, index) {
            final listing = listings[index];
            return ListingCard(
              listing: listing,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(listing: listing),
                  ),
                );
              },
            );
          },
        ),
        if (provider.searchQuery.isNotEmpty)
          Positioned(
            bottom: 30, // Elevated slightly
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF333333),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(51),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  '${listings.length} listings found',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
