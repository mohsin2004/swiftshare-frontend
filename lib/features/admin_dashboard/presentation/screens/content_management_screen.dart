import 'package:flutter/material.dart';
import '../../../../core/widgets/admin_navigation_drawer.dart';
import '../../../../core/navigation/app_router.dart';

class ContentManagementScreen extends StatefulWidget {
  const ContentManagementScreen({super.key});

  @override
  State<ContentManagementScreen> createState() => _ContentManagementScreenState();
}

class _ContentManagementScreenState extends State<ContentManagementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = true;
  String _selectedCategory = 'All';
  String _selectedStatus = 'All';

  final List<ContentItem> _contentItems = [
    ContentItem(
      id: '1',
      title: 'Avengers: Endgame',
      type: 'Movie',
      genre: 'Action',
      duration: '3h 1m',
      resolution: '4K',
      uploadDate: '2024-01-15',
      status: 'Active',
      category: 'Movie',
      views: '2.5M',
    ),
    ContentItem(
      id: '2',
      title: 'Stranger Things S4',
      type: 'Series',
      genre: 'Sci-Fi',
      duration: '8h 30m',
      resolution: '1080p',
      uploadDate: '2024-01-14',
      status: 'Active',
      category: 'Series',
      views: '1.8M',
    ),
    ContentItem(
      id: '3',
      title: 'The Batman',
      type: 'Movie',
      genre: 'Action',
      duration: '2h 56m',
      resolution: '1080p',
      uploadDate: '2024-01-13',
      status: 'Active',
      category: 'Movie',
      views: '1.2M',
    ),
    ContentItem(
      id: '4',
      title: 'Euphoria S2',
      type: 'Series',
      genre: 'Drama',
      duration: '7h 15m',
      resolution: '720p',
      uploadDate: '2024-01-12',
      status: 'Inactive',
      category: 'Series',
      views: '850K',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? const Color(0xFF0A0A0A) : Colors.white,
      drawer: AdminNavigationDrawer(currentRoute: AppRouter.contentManagement),
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
                    _buildDashboardTitle(),
                    const SizedBox(height: 24),
                    _buildFiltersSection(),
                    const SizedBox(height: 24),
                    _buildContentSection(),
                    const SizedBox(height: 16),
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
                  hintText: 'Search content...',
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

  Widget _buildDashboardTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Content Management',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Manage video content, uploads, and streaming library',
          style: TextStyle(
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            fontSize: 14,
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
            'Filters & Actions',
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
                child: _buildDropdown(
                  'Category',
                  _selectedCategory,
                  ['All', 'Movies', 'Series', 'Documentaries'],
                  (value) => setState(() => _selectedCategory = value ?? 'All'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  'Status',
                  _selectedStatus,
                  ['All', 'Active', 'Inactive', 'Pending'],
                  (value) => setState(() => _selectedStatus = value ?? 'All'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showAddContentDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B73FF), // Default theme primary color
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text(
                'Add Content',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
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
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _isDarkMode ? const Color(0xFF3A3A3A) : Colors.grey[300]!,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              style: TextStyle(
                color: _isDarkMode ? Colors.white : Colors.black,
                fontSize: 12,
              ),
              dropdownColor: _isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection() {
    final filteredItems = _contentItems.where((item) {
      final matchesCategory = _selectedCategory == 'All' || 
        item.category == _selectedCategory;
      final matchesStatus = _selectedStatus == 'All' || 
        item.status == _selectedStatus;
      return matchesCategory && matchesStatus;
    }).toList();

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Content Library',
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${filteredItems.length} items',
                style: TextStyle(
                  color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredItems.length,
            itemBuilder: (context, index) => _buildContentListItem(filteredItems[index], index),
          ),
        ],
      ),
    );
  }

  Widget _buildContentListItem(ContentItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF252525) : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isDarkMode ? const Color(0xFF3A3A3A) : Colors.grey[200]!,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 45,
            decoration: BoxDecoration(
              color: _isDarkMode ? const Color(0xFF3A3A3A) : Colors.grey[200],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              _getContentIcon(item.category),
              color: _isDarkMode ? Colors.grey[500] : Colors.grey[600],
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    color: _isDarkMode ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.type} • ${item.genre} • ${item.duration}',
                  style: TextStyle(
                    color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: item.status == 'Active'
                  ? const Color(0xFF4CAF50).withOpacity(0.1) // Green from admin dashboard
                  : const Color(0xFFF57C00).withOpacity(0.1), // Orange for inactive
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              item.status,
              style: TextStyle(
                color: item.status == 'Active' 
                    ? const Color(0xFF4CAF50) // Green from admin dashboard
                    : const Color(0xFFF57C00), // Orange for inactive
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            onSelected: (value) => _handleContentAction(value, item),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
              const PopupMenuItem(
                value: 'toggle_status',
                child: Text('Toggle Status'),
              ),
            ],
            child: Icon(
              Icons.more_vert,
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getContentIcon(String category) {
    switch (category.toLowerCase()) {
      case 'movie':
        return Icons.movie;
      case 'series':
        return Icons.tv;
      case 'documentary':
        return Icons.description;
      default:
        return Icons.video_library;
    }
  }

  void _handleContentAction(String action, ContentItem item) {
    switch (action) {
      case 'edit':
        _editContent(item);
        break;
      case 'delete':
        _deleteContent(item);
        break;
      case 'toggle_status':
        _toggleStatus(item);
        break;
    }
  }

  void _editContent(ContentItem item) {
    // Show edit dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit functionality for "${item.title}"'),
        backgroundColor: const Color(0xFF6B73FF), // Primary theme color
      ),
    );
  }

  void _deleteContent(ContentItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        title: Text(
          'Delete Content',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${item.title}"?',
          style: TextStyle(
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF5252), // Red from theme
            ),
            onPressed: () {
              setState(() {
                _contentItems.removeWhere((content) => content.id == item.id);
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Content deleted successfully'),
                  backgroundColor: Color(0xFFFF5252), // Red from theme
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _toggleStatus(ContentItem item) {
    setState(() {
      final index = _contentItems.indexWhere((content) => content.id == item.id);
      if (index != -1) {
        final newStatus = item.status == 'Active' ? 'Inactive' : 'Active';
        _contentItems[index] = ContentItem(
          id: item.id,
          title: item.title,
          type: item.type,
          genre: item.genre,
          duration: item.duration,
          resolution: item.resolution,
          uploadDate: item.uploadDate,
          status: newStatus,
          category: item.category,
          views: item.views,
        );
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          item.status == 'Active'
              ? 'Content deactivated successfully'
              : 'Content activated successfully',
        ),
        backgroundColor: const Color(0xFF4CAF50), // Green from theme
      ),
    );
  }

  void _showAddContentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        title: Text(
          'Add New Content',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Text(
          'Add content functionality would be implemented here.',
          style: TextStyle(
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Add content functionality coming soon'),
                  backgroundColor: Color(0xFF6B73FF), // Primary theme color
                ),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class ContentItem {
  final String id;
  final String title;
  final String type;
  final String genre;
  final String duration;
  final String resolution;
  final String uploadDate;
  final String status;
  final String category;
  final String views;

  ContentItem({
    required this.id,
    required this.title,
    required this.type,
    required this.genre,
    required this.duration,
    required this.resolution,
    required this.uploadDate,
    required this.status,
    required this.category,
    required this.views,
  });
}