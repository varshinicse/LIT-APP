import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lit/pages/avatar_store_page.dart';
import 'package:lit/pages/newsletter_page.dart';
import 'package:lit/pages/socials_page.dart';
import 'package:lit/pages/ir_icon_page.dart';
import 'package:lit/pages/sustainable_luxury.dart';
import 'package:lit/pages/signup_page.dart';
import 'package:lit/pages/game_entrance_page.dart';
import 'package:lit/pages/coming_soon.dart';
import 'package:lit/ecommerce/cart_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int activeIndex = -1;

  final List<Map<String, dynamic>> drawerItems = [
    {
      'icon': Icons.videogame_asset_outlined,
      'label': 'Game Modes',
      'page': const GameEntrancePage(),
    },
    {
      'icon': Icons.storefront_outlined,
      'label': 'Marketplace',
      'page': const SustainableLuxuryPage(),
    },
    {
      'icon': Icons.people_outline,
      'label': 'Socials',
      'page': const ComingSoonPage(),
    },
    {
      'icon': Icons.mail_outline,
      'label': 'Newsletter',
      'page': const NewsletterPage(),
    },
    {
      'icon': Icons.person_pin_circle_outlined,
      'label': 'Avatar Store',
      'page': const ComingSoonPage(),
    },
    {
      'icon': Icons.info_outline,
      'label': 'IR Icon',
      'page': const ComingSoonPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // 🔹 Glassmorphic Background
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 255, 255, 0.06),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔹 Drawer Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/avatar.jpg',
                          height: 48,
                          width: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Jane Anderson',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'jane.anderson@email.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Drawer Items
                ...drawerItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isActive = index == activeIndex;

                  return GestureDetector(
                    onTap: () {
                      setState(() => activeIndex = index);
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item['page']),
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.purpleAccent.withOpacity(0.25)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isActive
                              ? Colors.purpleAccent.withOpacity(0.4)
                              : Colors.transparent,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(item['icon'], color: Colors.white),
                          const SizedBox(width: 16),
                          Text(
                            item['label'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const Spacer(),
                const Divider(color: Colors.white24),

                // Settings Option
                ListTile(
                  leading: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/settings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
