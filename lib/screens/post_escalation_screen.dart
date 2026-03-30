import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PostEscalationScreen extends StatelessWidget {
  const PostEscalationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: const TabBar(
            indicatorColor: AppColors.logoRed,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            tabs: [
              Tab(text: 'POST ORDERS'),
              Tab(text: 'ESCALATION'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPostOrdersTab(),
            _buildEscalationTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostOrdersTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInstructionCard(
          title: 'Access Control',
          content: 'Verify all visitor badges upon entry. Ensure the secondary North gate is locked after 8:00 PM.',
        ),
        _buildInstructionCard(
          title: 'Patrol Frequency',
          content: 'Perform high-visibility patrols of the parking lot every 60 minutes. Log all findings in the Daily Activity Log.',
        ),
        _buildInstructionCard(
          title: 'Incident Reporting',
          content: 'Any property damage exceeding \$500 must be reported immediately to the Site Supervisor via phone.',
        ),
        _buildInstructionCard(
          title: 'Uniform Standards',
          content: 'Full tactical gear required. Body camera must be active during all interactions with the public.',
        ),
      ],
    );
  }

  Widget _buildEscalationTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Emergency Contacts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactCard(
          name: 'John Doe',
          role: 'Site Supervisor',
          phone: '(555) 012-3456',
          level: 'Level 1',
        ),
        _buildContactCard(
          name: 'Sarah Smith',
          role: 'Operations Manager',
          phone: '(555) 012-7890',
          level: 'Level 2',
        ),
        _buildContactCard(
          name: 'Robert Wilson',
          role: 'Client Representative',
          phone: '(555) 012-1212',
          level: 'Level 3',
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.withAlpha(30),
            border: Border.all(color: Colors.red.withAlpha(100)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.red),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'In case of life-threatening emergencies, dial 911 BEFORE following the escalation path.',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionCard({required String title, required String content}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required String name,
    required String role,
    required String phone,
    required String level,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(40),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$role • $level',
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  phone,
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
