import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class DispatchScreen extends StatelessWidget {
  const DispatchScreen({super.key});

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
          // Banner Banner Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.cardBackground,
            ),
            child: Row(
              children: [
                const Icon(Icons.assignment_rounded, color: Colors.white, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dispatch Tasks',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Process active task assignments',
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
          
          // Task List
          Expanded(
            child: ListView(
              children: [
                _buildTaskItem(title: 'Perimeter Check', status: 'PENDING', priority: 'HIGH'),
                _buildTaskItem(title: 'Vehicle Authorization', status: 'IN PROGRESS', priority: 'MEDIUM'),
                _buildTaskItem(title: 'Main Lobby Lockup', status: 'PENDING', priority: 'LOW'),
                _buildTaskItem(title: 'Fire Alarm Test', status: 'COMPLETED', priority: 'MEDIUM', isDone: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem({
    required String title,
    required String status,
    required String priority,
    bool isDone = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(
          isDone ? Icons.check_circle : Icons.circle_outlined, 
          color: isDone ? Colors.green : AppColors.textMuted
        ),
        title: Text(
          title, 
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.bold,
            decoration: isDone ? TextDecoration.lineThrough : null,
          )
        ),
        subtitle: Text(
          '$status - $priority', 
          style: const TextStyle(color: AppColors.textMuted, fontSize: 13)
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
        onTap: () {
          // Future: Task details
        },
      ),
    );
  }
}
