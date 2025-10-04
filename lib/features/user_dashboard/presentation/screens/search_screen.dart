import 'user_dashboard_screen.dart';
import 'package:flutter/material.dart';

// Simple Dashboard Top Bar Widget
class DashboardTopBar extends StatelessWidget {
  final String title;
  const DashboardTopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1A),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF2A2A2A),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recentSearches = [
      'Inception', 'Campus Life Hack', 'Stranger Things', 'Dune', 'Study Tips'
    ];
    final trendingVideos = [
      {'title': 'The Batman', 'views': '2.3M views'},
      {'title': 'Dune', 'views': '1.8M views'},
      {'title': 'Campus Life Hack #1', 'views': '1.2M views'},
    ];
    final categories = [
      'Movies', 'Series', 'Shorts', 'Live', 'Documentary', 'Comedy', 'Drama'
    ];

    return Container(
      color: const Color(0xFF181818),
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const DashboardTopBar(title: 'Search'),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search movies, shows...',
                hintStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),

          // Recent Searches
          SizedBox(height: 24),
          Text('Recent Searches', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: recentSearches.map((search) => Chip(
              label: Text(search, style: TextStyle(color: Colors.white)),
              backgroundColor: Color(0xFF2A2A2A),
            )).toList(),
          ),

          // Trending on Campus
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Trending on Campus', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: Text('See all', style: TextStyle(color: Color(0xFF6B73FF))),
              ),
            ],
          ),
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: trendingVideos.map((video) => Container(
                width: 120,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_circle_filled, color: Colors.white, size: 40),
                    SizedBox(height: 8),
                    Text(video['title']!, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(video['views']!, style: TextStyle(color: Colors.grey[400])),
                  ],
                ),
              )).toList(),
            ),
          ),

          // Browse by Category
          SizedBox(height: 32),
          Text('Browse by Category', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: categories.map((cat) => Chip(
              label: Text(cat, style: TextStyle(color: Colors.white)),
              backgroundColor: Color(0xFF6B73FF),
            )).toList(),
          ),
        ],
      ),
    );
  }
}
