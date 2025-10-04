import 'package:flutter/material.dart';
import '../../../../core/widgets/admin_navigation_drawer.dart';
import '../../../../core/navigation/app_router.dart';

class LogsAuditsScreen extends StatefulWidget {
  const LogsAuditsScreen({super.key});

  @override
  State<LogsAuditsScreen> createState() => _LogsAuditsScreenState();
}

class _LogsAuditsScreenState extends State<LogsAuditsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = true;
  String _selectedLogType = 'System Logs';

  final List<LogEntry> _systemLogs = [
    LogEntry(
      id: '1',
      timestamp: '2024-01-15 14:30:25',
      level: 'INFO',
      service: 'API Gateway',
      message: 'User authentication successful',
      details: 'User ID: 12345, IP: 192.168.1.100',
    ),
    LogEntry(
      id: '2',
      timestamp: '2024-01-15 14:28:15',
      level: 'WARN',
      service: 'Database',
      message: 'Connection pool near capacity',
      details: 'Active connections: 45/50',
    ),
    LogEntry(
      id: '3',
      timestamp: '2024-01-15 14:25:10',
      level: 'ERROR',
      service: 'CDN',
      message: 'Failed to serve content',
      details: 'File not found: /content/movie123.mp4',
    ),
    LogEntry(
      id: '4',
      timestamp: '2024-01-15 14:20:05',
      level: 'INFO',
      service: 'P2P Network',
      message: 'New peer connected',
      details: 'Peer ID: peer_789, Bandwidth: 50Mbps',
    ),
  ];

  final List<AuditEntry> _auditLogs = [
    AuditEntry(
      id: '1',
      timestamp: '2024-01-15 14:30:25',
      user: 'admin@swiftshare.com',
      action: 'User Management',
      details: 'Suspended user: john_doe',
      ip: '192.168.1.100',
    ),
    AuditEntry(
      id: '2',
      timestamp: '2024-01-15 14:28:15',
      user: 'moderator@swiftshare.com',
      action: 'Content Moderation',
      details: 'Approved content: movie_xyz',
      ip: '192.168.1.101',
    ),
    AuditEntry(
      id: '3',
      timestamp: '2024-01-15 14:25:10',
      user: 'admin@swiftshare.com',
      action: 'System Settings',
      details: 'Updated max upload size to 150MB',
      ip: '192.168.1.100',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? const Color(0xFF0A0A0A) : Colors.white,
      drawer: AdminNavigationDrawer(currentRoute: AppRouter.logsAudits),
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
                    _buildLogsTitle(),
                    const SizedBox(height: 24),
                    _buildActionButtons(),
                    const SizedBox(height: 24),
                    _buildFiltersSection(),
                    const SizedBox(height: 24),
                    _buildLogTabs(),
                    const SizedBox(height: 24),
                    _buildLogsList(),
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
                  hintText: 'Search logs...',
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

  Widget _buildLogsTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Logs & Audits',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'System logs and audit trails',
          style: TextStyle(
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]!,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.download,
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Export Logs',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF6B73FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Clear Logs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersSection() {
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
          Text(
            'Filters',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildDropdown('Log Level', 'All', [
                  'All', 'ERROR', 'WARN', 'INFO'
                ]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildDropdown('Service', 'All', [
                  'All', 'API Gateway', 'Database', 'CDN', 'P2P Network'
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isDarkMode ? const Color(0xFF3A3A3A) : Colors.grey[200]!,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
                fontSize: 14,
              ),
              dropdownColor: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
              items: options.map((option) => DropdownMenuItem(
                value: option,
                child: Text(option),
              )).toList(),
              onChanged: (newValue) {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogTabs() {
    final tabs = [
      'System Logs',
      'Admin Actions',
      'User Activity',
      'Security Logs',
    ];

    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = _selectedLogType == tab;
          
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _selectedLogType = tab),
              child: Container(
                width: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? const Color(0xFF6B73FF) 
                      : (_isDarkMode ? const Color(0xFF1A1A1A) : Colors.white),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? const Color(0xFF6B73FF)
                        : (_isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[200]!),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getTabIcon(tab),
                      color: isSelected 
                          ? Colors.white 
                          : (_isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tab,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected 
                            ? Colors.white 
                            : (_isDarkMode ? Colors.grey[300] : Colors.grey[700]),
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  IconData _getTabIcon(String tab) {
    switch (tab) {
      case 'System Logs':
        return Icons.computer;
      case 'Admin Actions':
        return Icons.admin_panel_settings;
      case 'User Activity':
        return Icons.people;
      case 'Security Logs':
        return Icons.security;
      default:
        return Icons.description;
    }
  }

  Widget _buildLogsList() {
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
                _selectedLogType,
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                _selectedLogType == 'System Logs'
                    ? '${_systemLogs.length} entries'
                    : _selectedLogType == 'Admin Actions'
                        ? '${_auditLogs.length} entries'
                        : '0 entries',
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_selectedLogType == 'System Logs')
            _buildSystemLogsList()
          else if (_selectedLogType == 'Admin Actions')
            _buildAuditLogsList()
          else
            _buildEmptyState(),
        ],
      ),
    );
  }

  Widget _buildSystemLogsList() {
    return Column(
      children: _systemLogs.map((log) => _buildSystemLogCard(log)).toList(),
    );
  }

  Widget _buildAuditLogsList() {
    return Column(
      children: _auditLogs.map((audit) => _buildAuditLogCard(audit)).toList(),
    );
  }

  Widget _buildSystemLogCard(LogEntry log) {
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _getLogLevelColor(log.level).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  log.level,
                  style: TextStyle(
                    color: _getLogLevelColor(log.level),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  log.service,
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                log.timestamp,
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            log.message,
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
              fontSize: 12,
            ),
          ),
          if (log.details.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              log.details,
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[400] : Colors.grey[500],
                fontSize: 10,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAuditLogCard(AuditEntry audit) {
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B73FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'AUDIT',
                  style: TextStyle(
                    color: Color(0xFF6B73FF),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  audit.action,
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                audit.timestamp,
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'User: ${audit.user}',
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            audit.details,
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'IP: ${audit.ip}',
            style: TextStyle(
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[500],
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 64,
              color: _isDarkMode ? Colors.grey[600] : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No logs to display',
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select a different log type to view entries',
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[500] : Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getLogLevelColor(String level) {
    switch (level) {
      case 'ERROR':
        return const Color(0xFFFF5252);
      case 'WARN':
        return const Color(0xFFF57C00);
      case 'INFO':
        return const Color(0xFF6B73FF);
      default:
        return _isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;
    }
  }
}

class LogEntry {
  final String id;
  final String timestamp;
  final String level;
  final String service;
  final String message;
  final String details;

  LogEntry({
    required this.id,
    required this.timestamp,
    required this.level,
    required this.service,
    required this.message,
    required this.details,
  });
}

class AuditEntry {
  final String id;
  final String timestamp;
  final String user;
  final String action;
  final String details;
  final String ip;

  AuditEntry({
    required this.id,
    required this.timestamp,
    required this.user,
    required this.action,
    required this.details,
    required this.ip,
  });
}