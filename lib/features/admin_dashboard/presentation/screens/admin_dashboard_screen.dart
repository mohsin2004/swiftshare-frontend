import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/widgets/admin_navigation_drawer.dart';
import '../../../../core/navigation/app_router.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = true;

  int _totalUsers = 12543;
  int _activeStreams = 2847;
  int _peerConnections = 45123;
  double _bandwidthUsage = 847;
  final double _usersTrend = 12.5;
  final double _streamsTrend = 8.2;
  final double _peerTrend = -2.4;
  final double _bandwidthTrend = 15.7;

  @override
  void initState() {
    super.initState();
    _startDataUpdates();
  }

  void _startDataUpdates() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _totalUsers += math.Random().nextInt(20) - 10;
          _activeStreams += math.Random().nextInt(100) - 50;
          _peerConnections += math.Random().nextInt(500) - 250;
          _bandwidthUsage += (math.Random().nextDouble() * 20) - 10;
        });
        _startDataUpdates();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? const Color(0xFF0A0A0A) : Colors.white,
      drawer: AdminNavigationDrawer(currentRoute: AppRouter.dashboard),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDashboardTitle(),
                    const SizedBox(height: 24),
                    _buildStatsGrid(),
                    const SizedBox(height: 24),
                    _buildChartsSection(),
                    const SizedBox(height: 16), // Reduced bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        return Container(
          height: isMobile ? 60 : 72,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.grey[100],
            border: Border(
              bottom: BorderSide(
                color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: _isDarkMode ? Colors.white : Colors.black,
                  size: isMobile ? 20 : 24,
                ),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              SizedBox(width: isMobile ? 8 : 16),
              Expanded(
                child: Container(
                  height: isMobile ? 36 : 40,
                  decoration: BoxDecoration(
                    color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _isDarkMode ? const Color(0xFF3A3A3A) : Colors.grey[300]!,
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(
                      color: _isDarkMode ? Colors.white : Colors.black,
                      fontSize: isMobile ? 12 : 14,
                    ),
                    decoration: InputDecoration(
                      hintText: isMobile ? 'Search...' : 'Search...',
                      hintStyle: TextStyle(
                        color: _isDarkMode ? Colors.grey[500] : Colors.grey[600],
                        fontSize: isMobile ? 12 : 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: _isDarkMode ? Colors.grey[500] : Colors.grey[600],
                        size: isMobile ? 16 : 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: isMobile ? 8 : 12,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: isMobile ? 4 : 8),
              if (!isMobile) ..._buildDesktopHeaderActions(),
              if (isMobile) ..._buildMobileHeaderActions(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildDesktopHeaderActions() {
    return [
      Flexible(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.dark_mode,
              size: 16,
              color: _isDarkMode ? Colors.white : Colors.black54,
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                });
              },
              child: Container(
                width: 44,
                height: 24,
                decoration: BoxDecoration(
                  color: _isDarkMode ? const Color(0xFF4CAF50) : const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: _isDarkMode ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.light_mode,
              size: 16,
              color: _isDarkMode ? Colors.black54 : Colors.black,
            ),
          ],
        ),
      ),
      const SizedBox(width: 8),
      Stack(
        children: [
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () {},
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
      const CircleAvatar(
        radius: 18,
        backgroundColor: Color(0xFF6B73FF),
        child: Text(
          'AD',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildMobileHeaderActions() {
    return [
      PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          color: _isDarkMode ? Colors.white : Colors.black,
          size: 20,
        ),
        onSelected: (value) {
          switch (value) {
            case 'theme':
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
              break;
            case 'notifications':
              // Handle notifications
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'theme',
            child: Row(
              children: [
                Icon(
                  _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  size: 18,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 8),
                Text(_isDarkMode ? 'Light Mode' : 'Dark Mode'),
              ],
            ),
          ),
          PopupMenuItem(
            value: 'notifications',
            child: Row(
              children: [
                Icon(
                  Icons.notifications_outlined,
                  size: 18,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 8),
                const Text('Notifications'),
              ],
            ),
          ),
        ],
      ),
    ];
  }

  Widget _buildDashboardTitle() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard',
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: isMobile ? 4 : 8),
            Text(
              isMobile 
                  ? "Welcome back! Here's what's happening today."
                  : "Welcome back! Here's what's happening with SwiftShare today.",
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                fontSize: isMobile ? 14 : 16,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatsGrid() {
    return Column(
      children: [
        // First row with 2 cards
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Users',
                _formatNumber(_totalUsers),
                'Active users this month',
                Icons.people_outline,
                _usersTrend,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Active Streams',
                _formatNumber(_activeStreams),
                'Currently streaming',
                Icons.play_circle_outline,
                _streamsTrend,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Second row with 2 cards
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Peer Connections',
                _formatNumber(_peerConnections),
                'Total P2P connections',
                Icons.link,
                _peerTrend,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Bandwidth Usage',
                '${_bandwidthUsage.toInt()} GB',
                'Last 24 hours',
                Icons.storage,
                _bandwidthTrend,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, double trend) {
    return Container(
      height: 120, // Fixed height for consistent horizontal layout
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          if (!_isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header with title and icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.1,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                icon,
                color: _isDarkMode ? Colors.grey[500] : Colors.grey[500],
                size: 16,
              ),
            ],
          ),
          
          // Main value
          Text(
            value,
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          
          // Trend and subtitle section
          Row(
            children: [
              // Trend indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: trend >= 0 
                      ? Colors.green.withOpacity(0.1) 
                      : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trend >= 0 ? Icons.trending_up : Icons.trending_down,
                      color: trend >= 0 ? Colors.green : Colors.red,
                      size: 10,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${trend >= 0 ? '+' : ''}${trend.toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: trend >= 0 ? Colors.green : Colors.red,
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 8),
              
              // Subtitle
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyle(
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[500],
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChartsSection() {
    return Column(
      children: [
        _buildStreamingTrafficChart(),
        const SizedBox(height: 16),
        _buildDeviceTypesChart(),
        const SizedBox(height: 16),
        _buildTopStreamedContent(),
        const SizedBox(height: 16),
        _buildPeerNetworkStatus(),
      ],
    );
  }

  Widget _buildStreamingTrafficChart() {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          if (!_isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daily Streaming Traffic',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Stream count and bandwidth usage over time',
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxHeight <= 0 || constraints.maxWidth <= 0) {
                  return const SizedBox();
                }
                return CustomPaint(
                  painter: LineChartPainter(isDarkMode: _isDarkMode),
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceTypesChart() {
    return Container(
      height: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          if (!_isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Device Types',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Distribution of streaming devices',
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  height: double.infinity,
                  child: Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: CustomPaint(
                        painter: DonutChartPainter(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem('Desktop', '45%', const Color(0xFF8B5CF6)),
                      const SizedBox(height: 12),
                      _buildLegendItem('Mobile', '35%', const Color(0xFF06B6D4)),
                      const SizedBox(height: 12),
                      _buildLegendItem('Tablet', '20%', const Color(0xFF10B981)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, String percentage, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          percentage,
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTopStreamedContent() {
    return Container(
      height: 280, // Optimized height
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          if (!_isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top Streamed Content',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Most popular content this week',
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Ensure minimum dimensions for chart
                if (constraints.maxHeight < 100 || constraints.maxWidth < 100) {
                  return Center(
                    child: Text(
                      'Chart area too small',
                      style: TextStyle(
                        color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  );
                }
                return Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: CustomPaint(
                    painter: BarChartPainter(
                      items: ['Ozark S4', 'Euphoria S2', 'The Batman', 'Stranger Things S4', 'Avengers'],
                      values: [4.2, 3.8, 3.5, 2.9, 2.1],
                      isDarkMode: _isDarkMode,
                    ),
                    size: Size(constraints.maxWidth, constraints.maxHeight),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeerNetworkStatus() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          if (!_isDarkMode)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Size to content
        children: [
          Text(
            'Peer Network Status',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Real-time network performance',
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          _buildNetworkStat('Active Peers', '8,547'),
          const SizedBox(height: 8),
          _buildNetworkStat('Avg Upload', '2.3 MB/s'),
          const SizedBox(height: 8),
          _buildNetworkStat('Network Load', '67%'),
          const SizedBox(height: 8),
          _buildNetworkStat('Cache Hit Rate', '89.2%'),
        ],
      ),
    );
  }

  Widget _buildNetworkStat(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

}

class LineChartPainter extends CustomPainter {
  final bool isDarkMode;

  LineChartPainter({required this.isDarkMode});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint()
      ..color = const Color(0xFF06B6D4)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final gridPaint = Paint()
      ..color = (isDarkMode ? Colors.grey[700] : Colors.grey[300])!.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    // Draw horizontal grid lines
    final gridSteps = 4;
    for (int i = 0; i <= gridSteps; i++) {
      final y = size.height * (i / gridSteps);
      if (y >= 0 && y <= size.height) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      }
    }

    // Draw vertical grid lines
    for (int i = 0; i <= 6; i++) {
      final x = size.width * (i / 6);
      if (x >= 0 && x <= size.width) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      }
    }

    // Points for two lines
    final points1 = _generateSafePoints(size, [0.6, 0.7, 0.2, 0.4, 0.3, 0.5, 0.4]);
    final points2 = _generateSafePoints(size, [0.8, 0.75, 0.7, 0.65, 0.7, 0.75, 0.8]);

    // First line (cyan)
    _drawSafeLine(canvas, points1, paint);

    // Second line (purple)
    paint.color = const Color(0xFF8B5CF6);
    _drawSafeLine(canvas, points2, paint);

    // Points
    paint.style = PaintingStyle.fill;
    paint.color = const Color(0xFF06B6D4);
    for (final point in points1) {
      canvas.drawCircle(point, 3, paint);
    }
    paint.color = const Color(0xFF8B5CF6);
    for (final point in points2) {
      canvas.drawCircle(point, 3, paint);
    }
  }

  List<Offset> _generateSafePoints(Size size, List<double> yValues) {
    final points = <Offset>[];
    for (int i = 0; i < yValues.length; i++) {
      final x = size.width * (i / (yValues.length - 1));
      final y = size.height * yValues[i];
      points.add(Offset(x.clamp(0, size.width), y.clamp(0, size.height)));
    }
    return points;
  }

  void _drawSafeLine(Canvas canvas, List<Offset> points, Paint paint) {
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 5;
    final innerRadius = radius * 0.6;

    if (radius <= 5 || innerRadius <= 0) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius - innerRadius;

    final strokeRadius = (radius + innerRadius) / 2;

    // Desktop - 45% (Purple)
    paint.color = const Color(0xFF8B5CF6);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: strokeRadius),
      -math.pi / 2,
      2 * math.pi * 0.45,
      false,
      paint,
    );

    // Mobile - 35% (Cyan)
    paint.color = const Color(0xFF06B6D4);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: strokeRadius),
      -math.pi / 2 + 2 * math.pi * 0.45,
      2 * math.pi * 0.35,
      false,
      paint,
    );

    // Tablet - 20% (Green)
    paint.color = const Color(0xFF10B981);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: strokeRadius),
      -math.pi / 2 + 2 * math.pi * 0.8,
      2 * math.pi * 0.2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BarChartPainter extends CustomPainter {
  final List<String> items;
  final List<double> values;
  final bool isDarkMode;

  BarChartPainter({
    required this.items,
    required this.values,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0 || items.isEmpty || values.isEmpty) return;

    final gridPaint = Paint()
      ..color = (isDarkMode ? Colors.grey[700] : Colors.grey[300])!.withValues(alpha: 0.3)
      ..strokeWidth = 1;

    // Space for labels - reduced margins
    final chartArea = Size(size.width - 40, size.height - 30);
    final chartOffset = const Offset(30, 5);

    // Draw grid lines
    for (int i = 0; i <= 4; i++) {
      final y = chartOffset.dy + (chartArea.height * (i / 4));
      if (y >= 0 && y <= size.height) {
        canvas.drawLine(
          Offset(chartOffset.dx, y),
          Offset(chartOffset.dx + chartArea.width, y),
          gridPaint,
        );
      }
    }

    if (chartArea.width <= 0 || chartArea.height <= 0) return;

    // Bar dimensions
    final barWidth = chartArea.width / items.length;
    final maxValue = values.reduce(math.max);

    if (maxValue <= 0 || barWidth <= 0) return;

    // Draw bars
    for (int i = 0; i < items.length && i < values.length; i++) {
      final barHeight = (values[i] / maxValue) * (chartArea.height - 15);
      final x = chartOffset.dx + (i * barWidth) + (barWidth * 0.2);
      final y = chartOffset.dy + chartArea.height - barHeight - 10;

      final barPaint = Paint()
        ..color = const Color(0xFF6B73FF).withValues(alpha: 0.7)
        ..style = PaintingStyle.fill;

      if (barWidth > 0 && barHeight > 0 && x >= 0 && y >= 0) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, y, barWidth * 0.6, barHeight),
            const Radius.circular(3),
          ),
          barPaint,
        );
      }
    }

    // Y-axis labels - smaller font
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i <= 4; i++) {
      final value = ((4 - i) * maxValue / 4);
      textPainter.text = TextSpan(
        text: value.toStringAsFixed(1),
        style: TextStyle(
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          fontSize: 8,
        ),
      );
      textPainter.layout();

      final y = chartOffset.dy + (chartArea.height * (i / 4)) - 3;
      if (y >= 0 && y <= size.height - textPainter.height) {
        textPainter.paint(canvas, Offset(2, y));
      }
    }

    // X-axis labels - smaller font
    for (int i = 0; i < items.length; i++) {
      final label = items[i].length > 5 ? '${items[i].substring(0, 5)}...' : items[i];
      textPainter.text = TextSpan(
        text: label,
        style: TextStyle(
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          fontSize: 7,
        ),
      );
      textPainter.layout();

      final x = chartOffset.dx + (i * barWidth) + (barWidth * 0.2);
      final y = chartOffset.dy + chartArea.height + 2;

      if (x >= 0 && x <= size.width - textPainter.width &&
          y >= 0 && y <= size.height - textPainter.height) {
        textPainter.paint(canvas, Offset(x, y));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}