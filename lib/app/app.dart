import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/theme/app_theme.dart';
import '../shared/widgets/app_bottom_nav.dart';
import '../features/scan_qr/presentation/pages/scan_qr_page.dart';
import '../features/scan_qr/presentation/bloc/scan_bloc.dart';
import '../features/attendance_history/presentation/pages/daily_history_page.dart';
import '../features/attendance_history/presentation/bloc/history_bloc.dart';
import '../features/attendance_history/presentation/bloc/history_event.dart';
import 'di/injection_container.dart';
class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendify',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const _MainShell(),
    );
  }
}
class _MainShell extends StatefulWidget {
  const _MainShell();
  @override
  State<_MainShell> createState() => _MainShellState();
}
class _MainShellState extends State<_MainShell> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          BlocProvider(
            create: (_) => sl<ScanBloc>(),
            child: const ScanQrPage(),
          ),
          BlocProvider(
            create: (_) => sl<HistoryBloc>()
              ..add(LoadDailyHistory(date: DateTime.now())),
            child: const DailyHistoryPage(),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentIndex,
        onTabChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
