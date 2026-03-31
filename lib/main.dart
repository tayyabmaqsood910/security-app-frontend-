import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/tour_list_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/dispatch_screen.dart';
import 'screens/post_escalation_screen.dart';
import 'screens/manager/manager_dashboard.dart';
import 'services/auth_service.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthState())],
      child: const ZBSecurityApp(),
    ),
  );
}

class ZBSecurityApp extends StatelessWidget {
  const ZBSecurityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ZB Security',
      builder: (context, child) {
        if (child == null) {
          return const SizedBox.shrink();
        }
        return _AppWithGlobalHeader(child: child);
      },
      theme: ThemeData(
        fontFamily: 'Inter',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.headerBackground,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: AppColors.textMuted),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/tours': (context) => const TourListScreen(),
        '/schedule': (context) => const ScheduleScreen(),
        '/dispatch': (context) => const DispatchScreen(),
        '/post_escalation': (context) => const PostEscalationScreen(),
        '/manager_dashboard': (context) => const ManagerDashboard(),
        // Placeholder routes for secondary features
        '/gps': (context) => _PlaceholderScreen(title: 'GPS SCAN'),
        '/incident_report': (context) =>
            _PlaceholderScreen(title: 'INCIDENT REPORT'),
      },
    );
  }
}

class _AppWithGlobalHeader extends StatelessWidget {
  final Widget child;
  const _AppWithGlobalHeader({required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            height: 76,
            color: AppColors.headerBackground,
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/app_logo.png',
              height: 56,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title Feature coming soon',
          style: const TextStyle(color: AppColors.textMuted),
        ),
      ),
    );
  }
}
