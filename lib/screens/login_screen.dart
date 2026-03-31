import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  UserRole _selectedRole = UserRole.guard;

  void _handleLogin() {
    final username = _usernameController.text.trim().toLowerCase();
    final password = _passwordController.text.trim();
    final authState = Provider.of<AuthState>(context, listen: false);

    if (_selectedRole == UserRole.guard) {
      if (username == 'guard' && password == '1234') {
        authState.login(UserRole.guard, "James Carter");
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        _showError('Invalid Credentials. Please tap the "Guard" toggle above.');
      }
    } else {
      if (username == 'manager' && password == 'admin1234') {
        authState.login(UserRole.manager, "Admin Manager");
        Navigator.pushReplacementNamed(context, '/manager_dashboard');
      } else {
        _showError('Invalid Credentials. Please tap the "Manager" toggle above.');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade800,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                
                // ZB SECURITY Logo Style
                Row(
                  children: [
                    const Text(
                      'ZB',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      color: AppColors.logoRed,
                      child: const Text(
                        'SECURITY',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),

                // BYOD Card (Matched precisely to Image 2 / descriptions)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.vpn_key_rounded, color: Colors.white, size: 36),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'BYOD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Use your username and password or scan your card or key chain',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Version: 5.14.29',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Guard | Manager Toggle Pill
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.inputBackground,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      _buildRoleToggleItem(UserRole.guard, "Guard"),
                      _buildRoleToggleItem(UserRole.manager, "Manager"),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Login Form
                const Text(
                  'Username or Email',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _usernameController,
                  hintText: 'Enter your username',
                ),
                
                const SizedBox(height: 24),
                
                const Text(
                  'Password',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                _buildInputField(
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  isPassword: true,
                  obscureText: _obscurePassword,
                  togglePassword: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                
                const SizedBox(height: 40),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryButton,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleToggleItem(UserRole role, String label) {
    bool isSelected = _selectedRole == role;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedRole = role),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.background : AppColors.textMuted,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? togglePassword,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.textMuted,
                    size: 20,
                  ),
                  onPressed: togglePassword,
                )
              : null,
        ),
      ),
    );
  }
}
