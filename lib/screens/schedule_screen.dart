import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/app_colors.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _currentMonth = DateTime(2025, 12, 1);

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  String _getMonthRange() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    
    final DateFormat formatter = DateFormat('MMM d');
    String range = '${formatter.format(firstDay)}st – ${formatter.format(lastDay)}';
    
    // Add ordinal suffix logic for a more authentic look
    String startDay = DateFormat('d').format(firstDay);
    String endDay = DateFormat('d').format(lastDay);
    
    String getSuffix(int day) {
      if (day >= 11 && day <= 13) return 'th';
      switch (day % 10) {
        case 1: return 'st';
        case 2: return 'nd';
        case 3: return 'rd';
        default: return 'th';
      }
    }

    return '${DateFormat('MMM').format(firstDay)} ${startDay}${getSuffix(int.parse(startDay))} – '
           '${DateFormat('MMM').format(lastDay)} ${endDay}${getSuffix(int.parse(endDay))}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.headerBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const Text(
              'TRACK ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                fontSize: 18,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              color: AppColors.logoRed,
              child: const Text(
                'TIK',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Range Header with functional navigation
          Container(
            color: const Color(0xFF2D353F),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                  onPressed: _previousMonth,
                ),
                Column(
                  children: [
                    Text(
                      _getMonthRange(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '204 Hours',
                      style: TextStyle(
                        color: Colors.white.withAlpha(180),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 24),
                  onPressed: _nextMonth,
                ),
              ],
            ),
          ),
          
          // Schedule List (Mocking data for the selected month)
          Expanded(
            child: _currentMonth.month == 12 && _currentMonth.year == 2025
                ? ListView(
                    children: [
                      _buildScheduleItem(date: '2025-12-01'),
                      _buildScheduleItem(date: '2025-12-02'),
                      _buildScheduleItem(date: '2025-12-04'),
                      _buildScheduleItem(date: '2025-12-05'),
                      _buildScheduleItem(date: '2025-12-08'),
                    ],
                  )
                : Center(
                    child: Text(
                      'No shifts scheduled for ${DateFormat('MMMM yyyy').format(_currentMonth)}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem({required String date}) {
    DateTime dt = DateTime.parse(date);
    String day = DateFormat('EEEE').format(dt);
    String formattedDate = DateFormat('MMM d, yyyy').format(dt);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2D353F),
        border: Border(left: BorderSide(color: Colors.red.shade400, width: 4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white38),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              formattedDate,
              style: TextStyle(
                color: Colors.white.withAlpha(150),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.white70, size: 16),
                const SizedBox(width: 8),
                Text(
                  '18:00 - 06:00 (12.00 hrs)',
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white70, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Main Entrance Post',
                  style: TextStyle(
                    color: Colors.white.withAlpha(200),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
