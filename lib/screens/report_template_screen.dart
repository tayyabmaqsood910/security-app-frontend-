import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ReportTemplateScreen extends StatelessWidget {
  const ReportTemplateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.headerBackground,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
            const Text(
              'Report Template List',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Header Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(color: AppColors.cardBackground),
            child: Row(
              children: [
                const Icon(Icons.description, color: Colors.white, size: 60),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Report Template List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'List of available report templates. Click on a row to write a report.',
                        style: TextStyle(
                          color: Colors.white.withAlpha(200),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha(100),
                  Colors.grey.withAlpha(50),
                ],
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Type to search ...',
                hintStyle: TextStyle(
                  color: Colors.white.withAlpha(150),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          // Template List
          Expanded(
            child: ListView(
              children: [
                _buildTemplateItem(context, 'Checklist', ''),
                _buildTemplateItem(
                  context,
                  'Daily Activity Log',
                  '',
                  route: '/daily_log',
                ),
                _buildTemplateItem(
                  context,
                  'End of Shift Report',
                  'To be completed at the end of every shift',
                  route: '/end_of_shift',
                ),
                _buildTemplateItem(
                  context,
                  'Fire watch',
                  'Note: Start a new Fire Watch Log Sheet for each new day of Fire Watch',
                  route: '/fire_watch',
                ),
                _buildTemplateItem(
                  context,
                  'Handover Signature',
                  'If Handover shift is not signed by any guard then there will be penalties. Should be done every takeover and Handover (every shift starting and ending).',
                ),
                _buildTemplateItem(
                  context,
                  'Incident Report',
                  'Complete this report for any incident or offense that occurs on your post.',
                  route: '/incident_report',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(BuildContext context, String title, String subtitle, {String? route}) {
    return InkWell(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.white12, width: 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
