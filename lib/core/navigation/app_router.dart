import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/authentication/login_screen.dart';
import '../../features/authentication/signup_screen.dart';
import '../../features/authentication/forgot_password_screen.dart';
import '../../features/admin_dashboard/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin_dashboard/presentation/screens/content_management_screen.dart';
import '../../features/admin_dashboard/presentation/screens/user_management_screen.dart';
import '../../features/admin_dashboard/presentation/screens/peer_network_screen.dart';
import '../../features/admin_dashboard/presentation/screens/analytics_screen.dart';
import '../../features/admin_dashboard/presentation/screens/moderation_screen.dart';
import '../../features/admin_dashboard/presentation/screens/watch_parties_screen.dart';
import '../../features/admin_dashboard/presentation/screens/subtitles_localization_screen.dart';
import '../../features/admin_dashboard/presentation/screens/system_settings_screen.dart';
import '../../features/admin_dashboard/presentation/screens/logs_audits_screen.dart';
import '../../features/admin_dashboard/presentation/screens/system_status_screen.dart';
import '../../features/user_dashboard/presentation/screens/user_dashboard_screen.dart';

class AppRouter {
  static const String authentication = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';
  static const String userDashboard = '/user-dashboard';
  static const String contentManagement = '/content-management';
  static const String userManagement = '/user-management';
  static const String peerNetwork = '/peer-network';
  static const String analytics = '/analytics';
  static const String moderation = '/moderation';
  static const String watchParties = '/watch-parties';
  static const String subtitlesLocalization = '/subtitles-localization';
  static const String systemSettings = '/system-settings';
  static const String logsAudits = '/logs-audits';
  static const String systemStatus = '/system-status';

  static final GoRouter router = GoRouter(
    initialLocation: authentication,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: authentication,
        name: 'authentication',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: signup,
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: dashboard,
        name: 'dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
      GoRoute(
        path: userDashboard,
        name: 'user-dashboard',
        builder: (context, state) => const UserDashboardScreen(),
      ),
      GoRoute(
        path: contentManagement,
        name: 'content-management',
        builder: (context, state) => const ContentManagementScreen(),
      ),
      GoRoute(
        path: userManagement,
        name: 'user-management',
        builder: (context, state) => const UserManagementScreen(),
      ),
      GoRoute(
        path: peerNetwork,
        name: 'peer-network',
        builder: (context, state) => const PeerNetworkScreen(),
      ),
      GoRoute(
        path: analytics,
        name: 'analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: moderation,
        name: 'moderation',
        builder: (context, state) => const ModerationScreen(),
      ),
      GoRoute(
        path: watchParties,
        name: 'watch-parties',
        builder: (context, state) => const WatchPartiesScreen(),
      ),
      GoRoute(
        path: subtitlesLocalization,
        name: 'subtitles-localization',
        builder: (context, state) => const SubtitlesLocalizationScreen(),
      ),
      GoRoute(
        path: systemSettings,
        name: 'system-settings',
        builder: (context, state) => const SystemSettingsScreen(),
      ),
      GoRoute(
        path: logsAudits,
        name: 'logs-audits',
        builder: (context, state) => const LogsAuditsScreen(),
      ),
      GoRoute(
        path: systemStatus,
        name: 'system-status',
        builder: (context, state) => const SystemStatusScreen(),
      ),
    ],
    errorBuilder: (context, state) {
      // Log error for debugging
      debugPrint('Router Error: ${state.error}');
      debugPrint('Router Location: ${state.uri}');
      return Scaffold(
        backgroundColor: const Color(0xFF181818),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'The page you are looking for does not exist.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Error: ${state.error}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(dashboard),
                child: const Text('Go to Dashboard'),
              ),
            ],
          ),
        ),
      );
    },
  );
}
