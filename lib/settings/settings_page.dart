import 'package:flutter/material.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import '../widgets/notification_bell.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int currentIndex = -1;

  void _onNavTapped(int index) {
    setState(() => currentIndex = index);
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/scan');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
        ),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 0),
            child: NotificationBell(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: _onNavTapped,
        isMarketplace: false,
      ),
      body: Stack(
        children: [
          // 🔹 Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 20),

                // 🔹 SETTINGS Text
                Center(
                  child: Text(
                    "SETTINGS",
                    style: GoogleFonts.kronaOne(
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 🔹 Back Row
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Avatar + Delete + Upload
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/avatar3.jpg',
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Spacer(),
                    _buildIconButton(Icons.delete_outline_rounded, Colors.redAccent),
                    const SizedBox(width: 12),
                    _buildIconButtonWithText(Icons.cloud_upload, "Upload"),
                  ],
                ),

                const SizedBox(height: 24),
                const Divider(color: Colors.white70, height: 0.3),
                const SizedBox(height: 20),

                // 🔹 Settings List
                _buildSection(
                  'Account',
                  'Security, profile, login info',
                  Icons.person_outline,
                      () => Navigator.pushNamed(context, '/accountSettings'),
                ),
                _buildSection(
                    'Privacy & Control',
                    'Visibility, permissions, data access',
                    Icons.verified_user_outlined,
                    () => Navigator.pushNamed(context, '/privacyControlSettings')
                ),
                _buildSection(
                    'Language & Country',
                    'Localization settings',
                    Icons.language,
                    () => Navigator.pushNamed(context, '/languageCountrySettings')
                ),
                _buildSection(
                    'Notifications',
                    'Alerts for updates, orders, messages',
                    Icons.notifications_outlined,
                    () => Navigator.pushNamed(context, '/notificationSettings')
                ),
                _buildSection(
                    'Subscription Plan',
                    'Manage your Premium status',
                    Icons.subscriptions_outlined,
                    () => Navigator.pushNamed(context, '/subscriptionSettings')
                ),
                _buildSection(
                    'Order Preferences',
                    'Shipping, payment, preferences',
                    Icons.shopping_cart_outlined,
                    () => Navigator.pushNamed(context, '/orderPreferencesSettings')
                ),
                _buildSection(
                    'Return & Cancellation',
                    'Manage post-order changes',
                    Icons.keyboard_return,
                    () => Navigator.pushNamed(context, '/returnCancellationSettings')
                ),
                _buildSection(
                    'Support & Legal',
                    'Help, support, and legal documents',
                    Icons.support_agent_outlined,
                    () => Navigator.pushNamed(context, '/supportLegalSettings')
                ),

                const SizedBox(height: 16),

                ListTile(
                  contentPadding: const EdgeInsets.only(left: 8.0, right: 16.0),
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.06),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.15),
                                      width: 1.2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Confirm Logout",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        "Are you sure you want to log out?",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 28),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          // Cancel Button
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(),
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white70,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                                side: BorderSide(
                                                  color: Colors.white.withOpacity(0.2),
                                                ),
                                              ),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 16),
                                              child: Text("Cancel"),
                                            ),
                                          ),

                                          // Logout Button
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.pushReplacementNamed(context, '/signin');
                                            },
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.redAccent,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                                side: const BorderSide(color: Colors.redAccent),
                                              ),
                                            ),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 16),
                                              child: Text("Logout"),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },

                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, Color color) {
    return Container(
      height: 40, // ✅ Ensure height matches upload button
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white60.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x99FFFFFF).withOpacity(0.3),
            blurRadius: 30,
          ),
        ],
      ),
      child: Center( // ✅ Vertically center the icon
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _buildIconButtonWithText(IconData icon, String label) {
    return Container(
      height: 40, // ✅ Same height as delete button
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white60.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0x99FFFFFF).withOpacity(0.3),
            blurRadius: 30,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.white70, fontSize: 13),
      ),
      onTap: onTap,
    );
  }

}
