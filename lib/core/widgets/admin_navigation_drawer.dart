import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import '../navigation/app_router.dart';

class AdminNavigationDrawer extends StatefulWidget {
  final String currentRoute;

  const AdminNavigationDrawer({
    super.key,
    required this.currentRoute,
  });

  @override
  State<AdminNavigationDrawer> createState() => _AdminNavigationDrawerState();
}

class _AdminNavigationDrawerState extends State<AdminNavigationDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.animationDuration,
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: Icons.dashboard,
      title: 'Dashboard',
      route: AppRouter.dashboard,
      description: 'Overview and key metrics',
    ),
    NavigationItem(
      icon: Icons.video_library,
      title: 'Content Management',
      route: AppRouter.contentManagement,
      description: 'Manage video content and uploads',
    ),
    NavigationItem(
      icon: Icons.people,
      title: 'User Management',
      route: AppRouter.userManagement,
      description: 'Manage users and permissions',
    ),
    NavigationItem(
      icon: Icons.network_check,
      title: 'Peer & Network',
      route: AppRouter.peerNetwork,
      description: 'Network status and P2P metrics',
    ),
    NavigationItem(
      icon: Icons.analytics,
      title: 'Analytics',
      route: AppRouter.analytics,
      description: 'User engagement and insights',
    ),
    NavigationItem(
      icon: Icons.shield,
      title: 'Moderation',
      route: AppRouter.moderation,
      description: 'Content and user moderation',
    ),
    NavigationItem(
      icon: Icons.group,
      title: 'Watch Parties',
      route: AppRouter.watchParties,
      description: 'Manage watch party sessions',
    ),
    NavigationItem(
      icon: Icons.translate,
      title: 'Subtitles & Localization',
      route: AppRouter.subtitlesLocalization,
      description: 'Manage subtitles and languages',
    ),
    NavigationItem(
      icon: Icons.settings,
      title: 'System Settings',
      route: AppRouter.systemSettings,
      description: 'Global configurations',
    ),
    NavigationItem(
      icon: Icons.assignment,
      title: 'Logs & Audits',
      route: AppRouter.logsAudits,
      description: 'System logs and audit trails',
    ),
    NavigationItem(
      icon: Icons.monitor_heart,
      title: 'System Status',
      route: AppRouter.systemStatus,
      description: 'Service health and performance',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value * 300, 0),
          child: Drawer(
            backgroundColor: AppTheme.surfaceColor,
            width: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width * 0.85 : 300,
            child: SafeArea(
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppTheme.spacingL),
                    decoration: const BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.admin_panel_settings,
                          size: 32,
                          color: AppTheme.textPrimary,
                        ),
                        const SizedBox(height: AppTheme.spacingS),
                        Text(
                          'SwiftShare Admin',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingXS),
                        Text(
                          'Administration Panel',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textPrimary.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                // Navigation Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingS),
                    itemCount: _navigationItems.length,
                    itemBuilder: (context, index) {
                      final item = _navigationItems[index];
                      final isSelected = widget.currentRoute == item.route;
                      
                      return _NavigationTile(
                        item: item,
                        isSelected: isSelected,
                        onTap: () {
                          context.go(item.route);
                          Navigator.of(context).pop();
                        },
                      ).animate(delay: Duration(milliseconds: index * 50))
                        .fadeIn(duration: AppTheme.animationDuration)
                        .slideX(begin: -0.2, end: 0);
                    },
                  ),
                ),
                // Footer
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  child: Column(
                    children: [
                      const Divider(color: AppTheme.textTertiary),
                      const SizedBox(height: AppTheme.spacingS),
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: AppTheme.primaryColor,
                            child: Icon(
                              Icons.person,
                              size: 16,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingS),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Admin User',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'admin@swiftshare.com',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: AppTheme.surfaceColor,
                                  title: const Text('Sign Out'),
                                  content: const Text('Are you sure you want to sign out?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context); // Close dialog
                                        Navigator.pop(context); // Close drawer
                                        context.go(AppRouter.login);
                                      },
                                      child: const Text('Sign Out'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.logout,
                              color: AppTheme.textSecondary,
                            ),
                            tooltip: 'Sign Out',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavigationTile extends StatefulWidget {
  final NavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavigationTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_NavigationTile> createState() => _NavigationTileState();
}

class _NavigationTileState extends State<_NavigationTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppTheme.fastAnimationDuration,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    
    return MouseRegion(
      onEnter: (_) {
        if (!isMobile) {
          setState(() => _isHovered = true);
          _animationController.forward();
        }
      },
      onExit: (_) {
        if (!isMobile) {
          setState(() => _isHovered = false);
          _animationController.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: isMobile ? 1.0 : _scaleAnimation.value,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingS,
                vertical: isMobile ? AppTheme.spacingXS / 2 : AppTheme.spacingXS,
              ),
              decoration: BoxDecoration(
                color: widget.isSelected
                    ? AppTheme.primaryColor.withValues(alpha: 0.1)
                    : _isHovered && !isMobile
                        ? AppTheme.cardColor
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                border: widget.isSelected
                    ? Border.all(
                        color: AppTheme.primaryColor.withValues(alpha: 0.3),
                        width: 1,
                      )
                    : null,
              ),
              child: ListTile(
                leading: Icon(
                  widget.item.icon,
                  color: widget.isSelected
                      ? AppTheme.primaryColor
                      : AppTheme.textSecondary,
                  size: isMobile ? 18 : 20,
                ),
                title: Text(
                  widget.item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: widget.isSelected
                        ? AppTheme.primaryColor
                        : AppTheme.textPrimary,
                    fontWeight: widget.isSelected
                        ? FontWeight.w600
                        : FontWeight.w500,
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
                subtitle: Text(
                  widget.item.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textTertiary,
                    fontSize: isMobile ? 11 : 12,
                  ),
                ),
                onTap: widget.onTap,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 12 : 16,
                  vertical: isMobile ? 8 : 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String title;
  final String route;
  final String description;

  NavigationItem({
    required this.icon,
    required this.title,
    required this.route,
    required this.description,
  });
}
