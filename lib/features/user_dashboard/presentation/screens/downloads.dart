import 'user_dashboard_screen.dart';
import 'package:flutter/material.dart';

// Simple Dashboard Top Bar Widget
class DashboardTopBar extends StatelessWidget {
  final String title;
  final bool showBackButton;
  const DashboardTopBar({super.key, required this.title, this.showBackButton = true});

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
          if (showBackButton)
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                // Check if we can pop, if not, we're at the root
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  // If we can't pop, navigate back to the main dashboard
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserDashboardScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          if (showBackButton)
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

class DownloadsScreen extends StatelessWidget {
  final bool showAppBar;
  const DownloadsScreen({super.key, this.showAppBar = false});

  @override
  Widget build(BuildContext context) {
    // Dummy data for demonstration
    final double usedStorage = 2.5; // GB
    final double totalStorage = 8.0; // GB
    final int downloadedItems = 5;
    final bool isOnline = true;
    final List<Map<String, String>> downloads = [
      {
        'title': 'Inception',
        'size': '1.2 GB',
        'image': 'https://m.media-amazon.com/images/I/51oDg+e1XlL._AC_SY679_.jpg'
      },
      {
        'title': 'Campus Life Hack #1',
        'size': '500 MB',
        'image': 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80'
      },
      {
        'title': 'Stranger Things S4E3',
        'size': '800 MB',
        'image': 'https://m.media-amazon.com/images/I/81l3rZK4lnL._AC_SY679_.jpg'
      },
      {
        'title': 'Dune',
        'size': '1 GB',
        'image': 'https://m.media-amazon.com/images/I/91zR1Zp5AqL._AC_SY679_.jpg'
      },
      {
        'title': 'Study Tips',
        'size': '200 MB',
        'image': 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?auto=format&fit=crop&w=400&q=80'
      },
    ];
    return Container(
      color: const Color(0xFF181818),
      child: Column(
        children: [
          if (showAppBar)
            const DashboardTopBar(title: 'Downloads')
          else
            // Simple header for when used in PageView
            Container(
              height: 60,
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
              child: const Row(
                children: [
                  Text(
                    'Downloads',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // Storage Used Bar
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6B73FF), Color(0xFF9575FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B73FF).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Storage Used', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            const SizedBox(height: 8),
                            Stack(
                              children: [
                                Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                Container(
                                  height: 8,
                                  width: 180 * (usedStorage / totalStorage),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('${usedStorage.toStringAsFixed(1)} GB of ${totalStorage.toStringAsFixed(1)} GB used', style: const TextStyle(color: Colors.white, fontSize: 12)),
                            const SizedBox(height: 4),
                            Text('$downloadedItems items downloaded', style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF6B73FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Manage Storage', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 16),
                // Online/Offline Bar
                OnlineStatusBar(isOnline: isOnline),

                SizedBox(height: 24),
                // Downloaded Content List
                const Text('Your Downloads', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 16),
                ...downloads.map((item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF2A2A2A),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item['image']!,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.play_circle_fill, color: Color(0xFF6B73FF), size: 32),
                        ),
                      ),
                    ),
                    title: Text(item['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                    subtitle: Text(item['size']!, style: TextStyle(color: Colors.grey[400])),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.play_arrow, color: Colors.white, size: 18),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// OnlineStatusBar widget for online/offline status
class OnlineStatusBar extends StatelessWidget {
  final bool isOnline;
  const OnlineStatusBar({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    final IconData icon = isOnline ? Icons.wifi : Icons.wifi_off;
    final Color iconColor = isOnline ? Colors.green : Colors.red;
    final Color barColor = isOnline ? const Color(0xFF1A1A1A) : const Color(0xFF2A2A2A);
    final String statusText = isOnline
        ? 'You are online'
        : 'You are offline. Only downloaded content is available.';
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: barColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOnline ? const Color(0xFF4CAF50).withOpacity(0.3) : const Color(0xFFFF5252).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Text(statusText, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}