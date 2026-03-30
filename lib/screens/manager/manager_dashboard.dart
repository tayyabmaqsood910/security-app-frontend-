import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../services/auth_service.dart';

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const _DashboardMain(),
    const _GuardsList(),
    const _DutyAssignment(),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.headerBackground,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'GUARD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 4),
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
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Manager Panel',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  authState.userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
              onPressed: () {
                authState.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
              tooltip: 'Logout',
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          backgroundColor: AppColors.headerBackground,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: AppColors.textMuted,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
            BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Guards'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment_ind_rounded), label: 'Duties'),
          ],
        ),
      ),
    );
  }
}

class _DashboardMain extends StatelessWidget {
  const _DashboardMain();

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Welcome, ${authState.userName}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Monday, Dec 29th 2025',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 14,
          ),
        ),
        
        const SizedBox(height: 32),
        
        // Summary Stat Grid (2x2)
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildStatCard('Total Guards', '120'),
            _buildStatCard('Active On Duty', '85'),
            _buildStatCard('On Break', '12'),
            _buildStatCard('On Leave', '5'),
          ],
        ),
        
        const SizedBox(height: 40),
        
        const Text(
          'LIVE GUARD STATUS',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildGuardStatusRow('James Carter', 'On Duty', 'Main Gate'),
        _buildGuardStatusRow('Sarah Ahmed', 'On Break', 'Building A Lobby'),
        _buildGuardStatusRow('Ali Hassan', 'On Duty', 'Parking Lot'),
        _buildGuardStatusRow('Maria Lopez', 'On Leave', 'N/A'),
        
        const SizedBox(height: 40),
        
        const Text(
          'RECENT ACTIVITY',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        
        _buildActivityRow(Icons.timer_outlined, 'James Carter checked in at Main Gate', '07:05 AM'),
        _buildActivityRow(Icons.gps_fixed, 'Ali Hassan scanned CP-04 Ground Floor', '07:12 AM'),
        _buildActivityRow(Icons.report_problem_outlined, 'Building A Lobby: Fire sensor alert', '07:15 AM'),
      ],
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuardStatusRow(String name, String status, String area) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                area,
                style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ],
          ),
          Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow(IconData icon, String desc, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              desc,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            time,
            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _GuardsList extends StatelessWidget {
  const _GuardsList();

  @override
  Widget build(BuildContext context) {
    final guards = [
      {'name': 'James Carter', 'status': 'On Duty', 'id': 'G-001', 'site': 'Main Gate'},
      {'name': 'Sarah Ahmed', 'status': 'On Break', 'id': 'G-002', 'site': 'Building A Lobby'},
      {'name': 'Ali Hassan', 'status': 'On Duty', 'id': 'G-003', 'site': 'Parking Lot'},
      {'name': 'Maria Lopez', 'status': 'On Leave', 'id': 'G-004', 'site': 'N/A'},
      {'name': 'Robert Chen', 'status': 'Off Duty', 'id': 'G-005', 'site': 'N/A'},
      {'name': 'Linda Wu', 'status': 'On Duty', 'id': 'G-006', 'site': 'Warehouse B'},
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Guards Directory',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search guards by name or ID...',
                  hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted),
                  filled: true,
                  fillColor: AppColors.cardBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: guards.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final guard = guards[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primaryButton,
                      child: Text(
                        guard['name']![0],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guard['name']!,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'ID: ${guard['id']} • ${guard['site']}',
                            style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusChip(guard['status']!),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'On Duty':
        color = Colors.green;
        break;
      case 'On Break':
        color = Colors.orange;
        break;
      case 'On Leave':
        color = Colors.red;
        break;
      default:
        color = AppColors.textMuted;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        status,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _DutyAssignment extends StatelessWidget {
  const _DutyAssignment();

  @override
  Widget build(BuildContext context) {
    final sites = [
      {'name': 'Main Gate', 'guard': 'James Carter', 'shift': '07:00 AM - 03:00 PM'},
      {'name': 'Building A Lobby', 'guard': 'Sarah Ahmed', 'shift': '08:00 AM - 04:00 PM'},
      {'name': 'Parking Lot', 'guard': 'Ali Hassan', 'shift': '06:00 PM - 02:00 AM'},
      {'name': 'Warehouse B', 'guard': 'Linda Wu', 'shift': '10:00 PM - 06:00 AM'},
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Duty Assignments',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded, size: 18),
                label: const Text('New'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.logoRed,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: sites.length,
              itemBuilder: (context, index) {
                final site = sites[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            site['name']!,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const Icon(Icons.location_on_outlined, color: AppColors.logoRed, size: 20),
                        ],
                      ),
                      const Divider(color: AppColors.divider, height: 24),
                      Row(
                        children: [
                          const Icon(Icons.person_outline_rounded, color: AppColors.textMuted, size: 16),
                          const SizedBox(width: 8),
                          const Text('Assigned Guard: ', style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                          Text(site['guard']!, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.schedule_rounded, color: AppColors.textMuted, size: 16),
                          const SizedBox(width: 8),
                          const Text('Current Shift: ', style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
                          Text(site['shift']!, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.divider),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Reassign', style: TextStyle(fontSize: 12)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.divider),
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('View Logs', style: TextStyle(fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

