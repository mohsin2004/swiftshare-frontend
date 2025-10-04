import 'package:flutter/material.dart';
import '../../../../core/widgets/admin_navigation_drawer.dart';
import '../../../../core/navigation/app_router.dart';

class SystemSettingsScreen extends StatefulWidget {
  const SystemSettingsScreen({super.key});

  @override
  State<SystemSettingsScreen> createState() => _SystemSettingsScreenState();
}

class _SystemSettingsScreenState extends State<SystemSettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = true;
  String _selectedCategory = 'General';

  // Settings state
  bool _enableAutoModeration = true;
  bool _enableEmailNotifications = true;
  bool _enablePushNotifications = false;
  bool _enableAnalytics = true;
  bool _enableP2P = true;
  bool _enableCDN = true;
  String _defaultLanguage = 'English';
  String _timezone = 'UTC';
  int _maxUploadSize = 100;
  int _maxConcurrentStreams = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? const Color(0xFF0A0A0A) : Colors.white,
      drawer: AdminNavigationDrawer(currentRoute: AppRouter.systemSettings),
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
                    _buildSystemSettingsTitle(),
                    const SizedBox(height: 24),
                    _buildActionButtons(),
                    const SizedBox(height: 24),
                    _buildCategorySelector(),
                    const SizedBox(height: 24),
                    _buildSettingsContent(),
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
                  hintText: 'Search settings...',
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

  Widget _buildSystemSettingsTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Settings',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Configure global system settings and preferences',
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
                  Icons.restore,
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'Reset to Defaults',
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
                  Icons.save,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Save Changes',
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

  Widget _buildCategorySelector() {
    final categories = [
      {'name': 'General', 'icon': Icons.settings},
      {'name': 'Features', 'icon': Icons.toggle_on},
      {'name': 'Security', 'icon': Icons.security},
      {'name': 'Storage', 'icon': Icons.storage},
      {'name': 'Notifications', 'icon': Icons.notifications},
      {'name': 'API Keys', 'icon': Icons.key},
      {'name': 'Email Settings', 'icon': Icons.email},
    ];

    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final name = category['name'] as String;
          final icon = category['icon'] as IconData;
          final isSelected = _selectedCategory == name;
          
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = name),
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
                      icon,
                      color: isSelected 
                          ? Colors.white 
                          : (_isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      name,
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

  Widget _buildSettingsContent() {
    switch (_selectedCategory) {
      case 'General':
        return _buildGeneralSettings();
      case 'Features':
        return _buildFeatureSettings();
      case 'Security':
        return _buildSecuritySettings();
      case 'Storage':
        return _buildStorageSettings();
      case 'Notifications':
        return _buildNotificationSettings();
      case 'API Keys':
        return _buildApiKeySettings();
      case 'Email Settings':
        return _buildEmailSettings();
      default:
        return _buildGeneralSettings();
    }
  }

  Widget _buildGeneralSettings() {
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
            'General Settings',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildDropdownSetting('Default Language', _defaultLanguage, [
            'English', 'Spanish', 'French', 'German'
          ], (value) => setState(() => _defaultLanguage = value)),
          const SizedBox(height: 16),
          _buildDropdownSetting('Timezone', _timezone, [
            'UTC', 'EST', 'PST', 'GMT'
          ], (value) => setState(() => _timezone = value)),
          const SizedBox(height: 16),
          _buildTextSetting('Max Upload Size (MB)', _maxUploadSize.toString(), 
            (value) => setState(() => _maxUploadSize = int.tryParse(value) ?? 100)),
          const SizedBox(height: 16),
          _buildTextSetting('Max Concurrent Streams', _maxConcurrentStreams.toString(), 
            (value) => setState(() => _maxConcurrentStreams = int.tryParse(value) ?? 5)),
        ],
      ),
    );
  }

  Widget _buildFeatureSettings() {
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
            'Feature Toggles',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildToggleSetting('Auto Moderation', 'Enable automated content moderation', 
            _enableAutoModeration, (value) => setState(() => _enableAutoModeration = value)),
          const SizedBox(height: 16),
          _buildToggleSetting('Analytics', 'Enable user analytics and tracking', 
            _enableAnalytics, (value) => setState(() => _enableAnalytics = value)),
          const SizedBox(height: 16),
          _buildToggleSetting('P2P Streaming', 'Enable peer-to-peer streaming', 
            _enableP2P, (value) => setState(() => _enableP2P = value)),
          const SizedBox(height: 16),
          _buildToggleSetting('CDN', 'Enable Content Delivery Network', 
            _enableCDN, (value) => setState(() => _enableCDN = value)),
        ],
      ),
    );
  }

  Widget _buildSecuritySettings() {
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
            'Security Settings',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextSetting('Session Timeout (minutes)', '30', (value) {}),
          const SizedBox(height: 16),
          _buildTextSetting('Max Login Attempts', '5', (value) {}),
          const SizedBox(height: 16),
          _buildToggleSetting('Two-Factor Authentication', 'Require 2FA for admin accounts', 
            true, (value) {}),
          const SizedBox(height: 16),
          _buildToggleSetting('IP Whitelist', 'Restrict admin access to specific IPs', 
            false, (value) {}),
        ],
      ),
    );
  }

  Widget _buildStorageSettings() {
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
            'Storage Settings',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextSetting('Storage Quota (GB)', '1000', (value) {}),
          const SizedBox(height: 16),
          _buildTextSetting('Backup Frequency (days)', '7', (value) {}),
          const SizedBox(height: 16),
          _buildToggleSetting('Auto Backup', 'Enable automatic backups', true, (value) {}),
          const SizedBox(height: 16),
          _buildToggleSetting('Compression', 'Enable file compression', true, (value) {}),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
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
            'Notification Settings',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildToggleSetting('Email Notifications', 'Send notifications via email', 
            _enableEmailNotifications, (value) => setState(() => _enableEmailNotifications = value)),
          const SizedBox(height: 16),
          _buildToggleSetting('Push Notifications', 'Send push notifications', 
            _enablePushNotifications, (value) => setState(() => _enablePushNotifications = value)),
          const SizedBox(height: 16),
          _buildToggleSetting('System Alerts', 'Enable system alerts', true, (value) {}),
          const SizedBox(height: 16),
          _buildToggleSetting('User Reports', 'Notify on user reports', true, (value) {}),
        ],
      ),
    );
  }

  Widget _buildApiKeySettings() {
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
            'API Key Management',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildApiKeySetting('API Key', 'sk-1234567890abcdef', () => _regenerateApiKey()),
          const SizedBox(height: 16),
          _buildApiKeySetting('Webhook Secret', 'whsec_1234567890abcdef', () => _regenerateWebhookSecret()),
          const SizedBox(height: 16),
          _buildTextSetting('Rate Limit (requests per minute)', '1000', (value) {}),
        ],
      ),
    );
  }

  Widget _buildEmailSettings() {
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
            'Email Configuration',
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextSetting('SMTP Server', 'smtp.example.com', (value) {}),
          const SizedBox(height: 16),
          _buildTextSetting('SMTP Port', '587', (value) {}),
          const SizedBox(height: 16),
          _buildTextSetting('Username', 'admin@swiftshare.com', (value) {}),
          const SizedBox(height: 16),
          _buildTextSetting('Password', '••••••••', (value) {}),
          const SizedBox(height: 16),
          _buildToggleSetting('Use SSL/TLS', 'Enable secure connection', true, (value) {}),
        ],
      ),
    );
  }

  Widget _buildDropdownSetting(String label, String value, List<String> options, Function(String) onChanged) {
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
              onChanged: (newValue) => onChanged(newValue ?? value),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextSetting(String label, String value, Function(String) onChanged) {
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
          decoration: BoxDecoration(
            color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isDarkMode ? const Color(0xFF3A3A3A) : Colors.grey[200]!,
            ),
          ),
          child: TextField(
            controller: TextEditingController(text: value),
            style: TextStyle(
              color: _isDarkMode ? Colors.white : Colors.black,
              fontSize: 14,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildToggleSetting(String title, String description, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF6B73FF),
          inactiveThumbColor: _isDarkMode ? Colors.grey[600] : Colors.grey[400],
          inactiveTrackColor: _isDarkMode ? Colors.grey[800] : Colors.grey[200],
        ),
      ],
    );
  }

  Widget _buildApiKeySetting(String label, String value, VoidCallback onRegenerate) {
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
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _isDarkMode ? const Color(0xFF3A3A3A) : Colors.grey[200]!,
                  ),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: _isDarkMode ? Colors.grey[600]! : Colors.grey[400]!,
                ),
              ),
              child: GestureDetector(
                onTap: onRegenerate,
                child: Text(
                  'Regenerate',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _regenerateApiKey() {
    // Show success message
  }

  void _regenerateWebhookSecret() {
    // Show success message
  }
}