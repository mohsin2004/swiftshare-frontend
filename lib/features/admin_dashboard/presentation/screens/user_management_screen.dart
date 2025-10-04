import 'package:flutter/material.dart';
import '../../../../core/widgets/admin_navigation_drawer.dart';
import '../../../../core/navigation/app_router.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDarkMode = true;
  String _selectedRole = 'All';
  String _selectedStatus = 'All';

  final List<UserItem> _users = [
    UserItem(
      id: '1',
      name: 'John Doe',
      email: 'john@university.edu',
      role: 'Student',
      status: 'Active',
      joinDate: '2024-01-15',
      lastActive: '2 hours ago',
    ),
    UserItem(
      id: '2',
      name: 'Jane Smith',
      email: 'jane.smith@university.edu',
      role: 'Faculty',
      status: 'Active',
      joinDate: '2024-01-14',
      lastActive: '1 day ago',
    ),
    UserItem(
      id: '3',
      name: 'Mike Wilson',
      email: 'mike.w@university.edu',
      role: 'Student',
      status: 'Active',
      joinDate: '2024-01-13',
      lastActive: '3 hours ago',
    ),
    UserItem(
      id: '4',
      name: 'Sarah Jones',
      email: 'sarah@university.edu',
      role: 'Admin',
      status: 'Active',
      joinDate: '2024-01-12',
      lastActive: '30 minutes ago',
    ),
    UserItem(
      id: '5',
      name: 'Tom Brown',
      email: 'tom.brown@university.edu',
      role: 'Student',
      status: 'Suspended',
      joinDate: '2024-01-10',
      lastActive: '5 days ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _isDarkMode ? const Color(0xFF0A0A0A) : Colors.white,
      drawer: AdminNavigationDrawer(currentRoute: AppRouter.userManagement),
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
                    _buildStatsGrid(),
                    const SizedBox(height: 24),
                    _buildFiltersSection(),
                    const SizedBox(height: 24),
                    _buildUserListSection(),
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
                  hintText: 'Search users...',
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
          'User Management',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Manage user accounts, roles, and permissions',
          style: TextStyle(
            color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
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
                '12,543',
                'Registered users',
                Icons.people_outline,
                8.2,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Active Users',
                '11,892',
                '94.8% of total',
                Icons.person,
                12.5,
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
                'Suspended',
                '32',
                '0.3% of users',
                Icons.block,
                -2.4,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'New Today',
                '24',
                '+12% from yesterday',
                Icons.person_add,
                15.7,
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
                  'Role',
                  _selectedRole,
                  ['All', 'Student', 'Faculty', 'Admin'],
                  (value) => setState(() => _selectedRole = value ?? 'All'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  'Status',
                  _selectedStatus,
                  ['All', 'Active', 'Suspended', 'Pending'],
                  (value) => setState(() => _selectedStatus = value ?? 'All'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showAddUserDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B73FF),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.person_add, size: 16),
              label: const Text(
                'Add User',
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

  Widget _buildUserListSection() {
    final filteredUsers = _users.where((user) {
      final matchesRole = _selectedRole == 'All' || user.role == _selectedRole;
      final matchesStatus = _selectedStatus == 'All' || user.status == _selectedStatus;
      return matchesRole && matchesStatus;
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
                'User Directory',
                style: TextStyle(
                  color: _isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${filteredUsers.length} users',
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
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) => _buildUserListItem(filteredUsers[index], index),
          ),
        ],
      ),
    );
  }

  Widget _buildUserListItem(UserItem user, int index) {
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
          CircleAvatar(
            radius: 20,
            backgroundColor: _getRoleColor(user.role),
            child: Text(
              user.name.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
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
                  user.email,
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
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: _getRoleColor(user.role).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              user.role,
              style: TextStyle(
                color: _getRoleColor(user.role),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: user.status == 'Active'
                  ? const Color(0xFF4CAF50).withOpacity(0.1)
                  : const Color(0xFFF57C00).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              user.status,
              style: TextStyle(
                color: user.status == 'Active' 
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFF57C00),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            onSelected: (value) => _handleUserAction(value, user),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'view',
                child: Text('View Profile'),
              ),
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit User'),
              ),
              const PopupMenuItem(
                value: 'suspend',
                child: Text('Suspend'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
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

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Admin':
        return const Color(0xFFFF5252); // Red
      case 'Faculty':
        return const Color(0xFF6B73FF); // Blue
      case 'Student':
        return const Color(0xFF4CAF50); // Green
      default:
        return Colors.grey;
    }
  }

  void _handleUserAction(String action, UserItem user) {
    switch (action) {
      case 'view':
        _showUserProfile(user);
        break;
      case 'edit':
        _editUser(user);
        break;
      case 'suspend':
        _suspendUser(user);
        break;
      case 'delete':
        _deleteUser(user);
        break;
    }
  }

  void _showUserProfile(UserItem user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        title: Text(
          'User Profile',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${user.name}',
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${user.email}',
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Role: ${user.role}',
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${user.status}',
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last Active: ${user.lastActive}',
              style: TextStyle(
                color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _editUser(UserItem user) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit functionality for "${user.name}"'),
        backgroundColor: const Color(0xFF6B73FF),
      ),
    );
  }

  void _suspendUser(UserItem user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        title: Text(
          'Suspend User',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Text(
          'Are you sure you want to suspend "${user.name}"?',
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
              backgroundColor: const Color(0xFFF57C00),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User suspended successfully'),
                  backgroundColor: Color(0xFFF57C00),
                ),
              );
            },
            child: const Text('Suspend'),
          ),
        ],
      ),
    );
  }

  void _deleteUser(UserItem user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        title: Text(
          'Delete User',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${user.name}"? This action cannot be undone.',
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
              backgroundColor: const Color(0xFFFF5252),
            ),
            onPressed: () {
              setState(() {
                _users.removeWhere((u) => u.id == user.id);
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User deleted successfully'),
                  backgroundColor: Color(0xFFFF5252),
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _isDarkMode ? const Color(0xFF1A1A1A) : Colors.white,
        title: Text(
          'Add New User',
          style: TextStyle(
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        content: Text(
          'Add user functionality would be implemented here.',
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
                  content: Text('Add user functionality coming soon'),
                  backgroundColor: Color(0xFF6B73FF),
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

class UserItem {
  final String id;
  final String name;
  final String email;
  final String role;
  final String status;
  final String joinDate;
  final String lastActive;

  UserItem({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.joinDate,
    required this.lastActive,
  });
}