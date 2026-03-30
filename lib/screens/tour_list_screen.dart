import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TourListScreen extends StatelessWidget {
  const TourListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.headerBackground,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'GUARD ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 18,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              color: AppColors.logoRed,
              child: const Text(
                'PRO',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner Card (Flat, no gradients)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.cardBackground,
            ),
            child: Row(
              children: [
                const Icon(Icons.history_rounded, color: Colors.white, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose a tour to start',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Select an active checkpoint tour',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Tour List
          Expanded(
            child: ListView(
              children: [
                _buildTourItem(context, 'Full Property Tour', '12 Checkpoints'),
                _buildTourItem(context, 'Perimeter Check', '6 Checkpoints'),
                _buildTourItem(context, 'Fire Safety Audit', '15 Checkpoints'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTourItem(BuildContext context, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(
          title, 
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        subtitle: Text(
          subtitle, 
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13)
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
        onTap: () {
          // Future: Start tour
        },
      ),
    );
  }
}
