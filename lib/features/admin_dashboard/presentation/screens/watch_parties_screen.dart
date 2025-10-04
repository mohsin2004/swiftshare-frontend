import 'package:flutter/material.dart';
import '../../../../core/widgets/admin_navigation_drawer.dart';
import '../../../../core/navigation/app_router.dart';

class WatchPartiesScreen extends StatefulWidget {
  const WatchPartiesScreen({super.key});

  @override
  State<WatchPartiesScreen> createState() => _WatchPartiesScreenState();
}

class _WatchPartiesScreenState extends State<WatchPartiesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = true;

  final List<WatchParty> _activeParties = [
    WatchParty(
      id: '1',
      title: 'Marvel Movie Night',
      host: 'john_doe',
      content: 'Avengers: Endgame',
      participants: 8,
      maxParticipants: 10,
      startTime: '2024-01-15 20:00',
      status: 'Active',
    ),
    WatchParty(
      id: '2',
      title: 'Horror Movie Marathon',
      host: 'jane_smith',
      content: 'The Conjuring',
      participants: 5,
      maxParticipants: 8,
      startTime: '2024-01-15 22:00',
      status: 'Scheduled',
    ),
    WatchParty(
      id: '3',
      title: 'Anime Night',
      host: 'anime_fan',
      content: 'Attack on Titan S4',
      participants: 12,
      maxParticipants: 15,
      startTime: '2024-01-15 21:30',
      status: 'Active',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? const Color(0xFF0A0A0A) : Colors.white,
      drawer: AdminNavigationDrawer(currentRoute: AppRouter.watchParties),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWatchPartiesTitle(),
                    const SizedBox(height: 24),
                    _buildCreatePartyButton(),
                    const SizedBox(height: 24),
                    _buildStatsGrid(),
                    const SizedBox(height: 24),
                    _buildActiveParties(),
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
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
              size: 20,
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 36,
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
                  fontSize: 12,
                ),
                decoration: InputDecoration(
                  hintText: 'Search watch parties...',
                  hintStyle: TextStyle(
                    color: _isDarkMode ? Colors.grey[500] : Colors.grey[600],
                    fontSize: 12,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: _isDarkMode ? Colors.grey[500] : Colors.grey[600],
                    size: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
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
        ],
      ),
    );
  }

  Widget _buildWatchPartiesTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Watch Parties',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Manage watch party sessions and user participation',
          style: TextStyle(
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildCreatePartyButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.add,
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Create Watch Party',
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF6B73FF),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'Create',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
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
                'Active Parties',
                '12',
                'Currently running',
                Icons.group,
                3.0,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Total Participants',
                '156',
                'Users in parties',
                Icons.people,
                24.0,
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
                'Scheduled Parties',
                '8',
                'Upcoming events',
                Icons.schedule,
                2.0,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Avg. Party Size',
                '6.5',
                'Participants per party',
                Icons.analytics,
                0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, double trend) {
    return Container(
      height: 120,
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
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: trend >= 0 
                      ? const Color(0xFF4CAF50).withOpacity(0.1)
                      : const Color(0xFFFF5252).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      trend >= 0 ? Icons.trending_up : Icons.trending_down,
                      color: trend >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFFF5252),
                      size: 10,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${trend >= 0 ? '+' : ''}${trend.toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: trend >= 0 ? const Color(0xFF4CAF50) : const Color(0xFFFF5252),
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
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

  Widget _buildActiveParties() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Active Watch Parties',
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${_activeParties.length} parties',
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: _activeParties.map((party) => _buildPartyCard(party)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPartyCard(WatchParty party) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isDarkMode ? const Color(0xFF3A3A3A) : Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      party.title,
                      style: TextStyle(
                        color: _isDarkMode ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Host: ${party.host} • ${party.content}',
                      style: TextStyle(
                        color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getStatusColor(party.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  party.status,
                  style: TextStyle(
                    color: _getStatusColor(party.status),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.people,
                size: 14,
                color: _isDarkMode ? Colors.grey[500] : Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Text(
                '${party.participants}/${party.maxParticipants} participants',
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  fontSize: 10,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.schedule,
                size: 14,
                color: _isDarkMode ? Colors.grey[500] : Colors.grey[500],
              ),
              const SizedBox(width: 4),
              Text(
                party.startTime,
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B73FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'View Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _isDarkMode ? Colors.grey[600]! : Colors.grey[400]!,
                  ),
                ),
                child: Text(
                  'Moderate',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.more_vert,
                color: _isDarkMode ? Colors.grey[500] : Colors.grey[500],
                size: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return const Color(0xFF4CAF50);
      case 'Scheduled':
        return const Color(0xFF6B73FF);
      case 'Ended':
        return _isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;
      default:
        return _isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;
    }
  }
}

class WatchParty {
  final String id;
  final String title;
  final String host;
  final String content;
  final int participants;
  final int maxParticipants;
  final String startTime;
  final String status;

  WatchParty({
    required this.id,
    required this.title,
    required this.host,
    required this.content,
    required this.participants,
    required this.maxParticipants,
    required this.startTime,
    required this.status,
  });
}