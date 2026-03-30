import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:torch_light/torch_light.dart';
import '../theme/app_colors.dart';
import '../services/auth_service.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isFlashlightOn = false;
  bool isWatchModeOn = false;

  void _showTimeClockMenu() {
    _showGenericMenu(
      title: 'Time Clock',
      items: [
        'Clock In',
        'Clock Out',
        'Start Break',
        'End Break',
        'View History',
      ],
      onItemSelected: (title) {
        // Handle time clock navigation
      },
    );
  }

  void _showReportsMenu() {
    _showGenericMenu(
      title: 'Reports & Logs',
      items: [
        'Daily Activity Report',
        'Incident Report',
        'Maintenance Report',
        'Visitor Log',
        'Fire Watch Log',
      ],
      onItemSelected: (title) {
        // Handle reports navigation
      },
    );
  }

  void _showMessageBoardMenu() {
    _showGenericMenu(
      title: 'Message Board',
      items: [
        'New Messages',
        'Sent Messages',
        'Drafts',
        'Trash',
      ],
      onItemSelected: (title) {
        // Handle messages navigation
      },
    );
  }

  void _showSettingsMenu() {
    _showGenericMenu(
      title: 'Settings',
      items: [
        'Camera Setting',
        'Synchronization Status',
        'System Diagnostics',
        'Session Settings',
        'Barcode Scanner Settings',
        'Local Settings',
        'Storage Settings',
        'Privacy Policy',
        'Log Out',
      ],
      onItemSelected: (title) {
        if (title == 'Log Out') {
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        }
      },
    );
  }

  void _showGenericMenu({
    required String title,
    required List<String> items,
    required Function(String) onItemSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)), // Flat style
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.divider, height: 1),
              ...items.map((item) => ListTile(
                    title: Text(
                      item,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    trailing: const Icon(Icons.chevron_right, color: AppColors.textMuted),
                    onTap: () {
                      Navigator.pop(context);
                      onItemSelected(item);
                    },
                  )),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.headerBackground,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
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
              ],
            ),
            const Text(
              'Version 5.14.29',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        authState.userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authState.siteName,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                ],
              ),
            ),

            // Shift Status Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SHIFT STATUS',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Shift Time: Mon Dec 29th 07:00 - Mon Dec 29th 19:00',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Site Description / Additional Notes',
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            // Toggle clock in/out
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2D3748),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Text(
                                'Clock In',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Grid Tiles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
                children: [
                  _buildGridItem(
                    iconData: Icons.timer_outlined,
                    label: 'TIME CLOCK',
                    isSpecial: true,
                    specialType: 'clock',
                    onTap: _showTimeClockMenu,
                  ),
                  _buildGridItem(
                    iconData: Icons.calendar_month,
                    label: 'SCHEDULE & ATTENDANCE',
                    isSpecial: true,
                    specialType: 'calendar',
                    onTap: () => Navigator.pushNamed(context, '/schedule'),
                  ),
                  _buildGridItem(
                    iconData: Icons.gps_fixed,
                    label: 'CHECKPOINTS',
                    isSpecial: true,
                    specialType: 'globe',
                    onTap: () => Navigator.pushNamed(context, '/tours'),
                  ),
                  _buildGridItem(
                    iconData: Icons.location_on,
                    label: 'GPS SCAN',
                    onTap: () => Navigator.pushNamed(context, '/gps'),
                  ),
                  _buildGridItem(
                    iconData: Icons.description,
                    label: 'REPORTS',
                    isSpecial: true,
                    specialType: 'report',
                    onTap: _showReportsMenu,
                  ),
                  _buildGridItem(
                    iconData: Icons.report_problem,
                    label: 'INCIDENT REPORT',
                    onTap: () => Navigator.pushNamed(context, '/incident_report'),
                  ),
                  _buildGridItem(
                    iconData: Icons.folder,
                    label: 'POST ORDERS',
                    isSpecial: true,
                    specialType: 'folder',
                    onTap: () => Navigator.pushNamed(context, '/post_escalation'),
                  ),
                  _buildGridItem(
                    iconData: Icons.mail_outline,
                    label: 'MESSAGES',
                    isSpecial: true,
                    specialType: 'mail',
                    onTap: _showMessageBoardMenu,
                  ),
                  _buildGridItem(
                    iconData: Icons.inventory_2,
                    label: 'DISPATCH TASKS',
                    isSpecial: true,
                    specialType: 'dispatch',
                    onTap: () => Navigator.pushNamed(context, '/dispatch'),
                  ),
                  _buildGridItem(
                    iconData: Icons.phone_android,
                    label: 'EMERGENCY',
                    iconColor: Colors.white,
                    onTap: () => Navigator.pushNamed(context, '/post_escalation'),
                  ),
                  _buildGridItem(
                    iconData: Icons.flashlight_on,
                    label: 'FLASHLIGHT',
                    isSpecial: true,
                    specialType: 'flashlight',
                    onTap: () async {
                      try {
                        if (isFlashlightOn) {
                          await TorchLight.disableTorch();
                        } else {
                          await TorchLight.enableTorch();
                        }
                        setState(() {
                          isFlashlightOn = !isFlashlightOn;
                        });
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Flashlight is not available on this device.')),
                          );
                        }
                      }
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.camera_alt,
                    label: 'WATCH MODE',
                    isSpecial: true,
                    specialType: 'camera',
                    onTap: () {
                      setState(() {
                        isWatchModeOn = !isWatchModeOn;
                      });
                    },
                  ),
                  _buildGridItem(
                    iconData: Icons.settings,
                    label: 'SETTINGS',
                    isSpecial: true,
                    specialType: 'settings',
                    onTap: _showSettingsMenu,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem({
    required IconData iconData,
    required String label,
    Color iconColor = Colors.white,
    bool isSpecial = false,
    String? specialType,
    VoidCallback? onTap,
  }) {
    Widget icon = Icon(iconData, color: iconColor, size: 55);

    if (isSpecial) {
       if (specialType == 'flashlight') {
        icon = Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFlashlightOn ? Colors.yellow.shade700 : AppColors.headerBackground,
            border: Border.all(
              color: isFlashlightOn ? Colors.yellow.shade100 : Colors.grey.shade400, 
              width: 2
            ),
          ),
          child: Center(
            child: Text(
              isFlashlightOn ? 'ON' : 'OFF',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        );
      } else if (specialType == 'calendar') {
        icon = Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 55),
            Positioned(
              top: 25,
              child: Text(
                '14',
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      } else if (specialType == 'clock') {
        icon = Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.timer_outlined, color: Colors.white, size: 55),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: AppColors.accentDot,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      } else if (specialType == 'camera') {
        icon = Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.camera_alt, color: Colors.white, size: 55),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isWatchModeOn ? Colors.green : AppColors.accentDot,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      } else if (specialType == 'mail') {
        icon = Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.mail_outline, color: Colors.white, size: 55),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        );
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gridItemBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
