import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/notification_bell.dart';
import 'package:lit/widgets/common_button.dart';

class FriendSuggestionsPage extends StatefulWidget {
  const FriendSuggestionsPage({super.key});

  @override
  State<FriendSuggestionsPage> createState() => _FriendSuggestionsPageState();
}

class _FriendSuggestionsPageState extends State<FriendSuggestionsPage> {
  String selectedTab = 'Friend list';
  final TextEditingController _search = TextEditingController();

  final List<Map<String, String>> allUsers = const [
    {'name': 'LuxuryinTaste', 'avatar': 'assets/images/avatar1.jpg'},
    {'name': 'Gamer65', 'avatar': 'assets/images/avatar2.jpg'},
    {'name': 'Beautyeve', 'avatar': 'assets/images/avatar3.jpg'},
    {'name': 'Liya James', 'avatar': 'assets/images/avatar4.jpg'},
    {'name': 'Gamer65', 'avatar': 'assets/images/avatar5.jpg'},
    {'name': 'Beautyeve', 'avatar': 'assets/images/avatar6.jpg'},
    {'name': 'Liya James', 'avatar': 'assets/images/avatar7.jpg'},
    {'name': 'Gamer65', 'avatar': 'assets/images/avatar8.jpg'},
  ];

  List<Map<String, String>> get filtered {
    final q = _search.text.trim().toLowerCase();
    if (q.isEmpty) return allUsers;
    return allUsers.where((u) => (u['name'] ?? '').toLowerCase().contains(q)).toList();
  }

  Widget _buildToggleButton(String label) {
    final isSelected = selectedTab == label;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                gradient: const RadialGradient(
                  center: Alignment(0.08, 0.08),
                  radius: 7.98,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(147, 51, 234, 0.4),
                  ],
                  stops: [0.0, 0.5],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(color: Color(0x66000000), offset: Offset(0, 4), blurRadius: 4),
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color.fromRGBO(147, 51, 234, 0.4), width: 1),
              ),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
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
        title: Image.asset('assets/images/logo.png', height: 40),
        actions: const [Padding(padding: EdgeInsets.only(right: 12), child: NotificationBell())],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (i) {
          if (i == 0) Navigator.pushReplacementNamed(context, '/home');
          if (i == 1) Navigator.pushReplacementNamed(context, '/scan');
          if (i == 2) Navigator.pushReplacementNamed(context, '/profile');
        },
        isGame: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/background.png', fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.65)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                          SizedBox(width: 6),
                          Text('Back', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'FRIENDS',
                    style: GoogleFonts.kronaOne(
                      fontSize: 22,
                      color: Colors.white,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  const SizedBox(height: 22),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildToggleButton('Friend list'),
                      const SizedBox(width: 12),
                      _buildToggleButton('Pending Request'),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0x569333EA), width: 1),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Color(0xFFBFA9DD), size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _search,
                            onChanged: (_) => setState(() {}),
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'luxuryintatse',
                              hintStyle: TextStyle(color: Color(0xFFBFA9DD)),
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _search.clear()),
                          child: const Icon(Icons.close, color: Color(0xFFBFA9DD), size: 18),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (_, i) {
                        final name = filtered[i]['name']!;
                        final avatar = filtered[i]['avatar']!;
                        return Row(
                          children: [
                            CircleAvatar(radius: 22, backgroundImage: AssetImage(avatar)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => _showPlayerPopup(context, {'name': name, 'avatar': avatar}),
                                child: Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showRequestSentPopup(name, avatar),
                              child: Image.asset('assets/images/Vector-2.png', width: 22, height: 22),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _togglePill(String label) {
    final bool isSelected = selectedTab == label;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF6B21A8), Color(0xFF9333EA)],
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          border: Border.all(
            color: const Color(0x809333EA),
            width: 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 10, offset: const Offset(0, 3))]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _showPlayerPopup(BuildContext context, Map<String, dynamic> player) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const RadialGradient(
                        center: Alignment(0, -0.3),
                        radius: 1.3,
                        colors: [
                          Color.fromRGBO(255, 255, 255, 0.08),
                          Color.fromRGBO(255, 255, 255, 0.02),
                        ],
                      ),
                      border: Border.all(color: Colors.white.withOpacity(0.15)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(player['avatar']),
                              radius: 26,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      player['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Icon(Icons.person_add_alt_1, size: 18, color: Colors.white),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Text('Beginner', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                    const SizedBox(width: 6),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundImage: const AssetImage('assets/images/india-flag.png'),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 0.03),
                                    border: Border.all(color: const Color(0xFF8A6FCF), width: 0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(color: const Color(0x59CFCFCF).withOpacity(0.1), offset: const Offset(0, 1)),
                                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(2, 2)),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Player Stats', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white)),
                                      Divider(color: Color(0xFF8A6FCF), thickness: 0.4, height: 10),
                                      SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _StatColumn(value: '16', label: 'Games Played', valueColor: Color(0xFFA46BF5)),
                                          _StatColumn(value: '21', label: 'Games won', valueColor: Color(0xFFA46BF5)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 0.03),
                                    border: Border.all(color: const Color(0xFF8A6FCF), width: 0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(color: const Color(0x59CFCFCF).withOpacity(0.1), offset: const Offset(0, 1)),
                                      BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(2, 2)),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('Badges', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white)),
                                      Divider(color: Color(0xFF8A6FCF), thickness: 0.4, height: 10),
                                      SizedBox(height: 6),
                                      _BadgesRow(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.03),
                            border: Border.all(color: const Color(0xFF8A6FCF), width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(color: const Color(0x59CFCFCF).withOpacity(0.1), offset: const Offset(0, 1)),
                              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(2, 2)),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Achievements', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white)),
                              const Divider(color: Color(0xFF8A6FCF), thickness: 0.4, height: 10),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  _AchievementBox(icon: Icons.shopping_bag, label: 'Bags', value: '33/40'),
                                  _AchievementBox(icon: Icons.snowshoeing, label: 'Footwear', value: '33/40'),
                                  _AchievementBox(icon: Icons.checkroom, label: 'Clothing', value: '33/40'),
                                  _AchievementBox(icon: Icons.watch, label: 'Accessories', value: '33/40'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 3,
                right: 3,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xFF2D0C4B), shape: BoxShape.circle),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.close, size: 16, color: Color(0xffD9BFFF)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showRequestSentPopup(String name, String imagePath) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 60),
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      width: 360,
                      padding: const EdgeInsets.fromLTRB(28, 28, 28, 32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const RadialGradient(
                          center: Alignment(0, -0.25),
                          radius: 1.2,
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.10),
                            Color.fromRGBO(255, 255, 255, 0.03),
                          ],
                        ),
                        border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.35),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.kronaOne(
                              color: Colors.white,
                              fontSize: 28,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 18),
                          CircleAvatar(radius: 70, backgroundImage: AssetImage(imagePath)),
                          const SizedBox(height: 22),
                          const Text(
                            'Friend Request Sent successfully',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset('assets/images/Rectangle.png', width: 64, height: 64),
                          const Icon(Icons.close, color: Colors.white, size: 22),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;
  const _StatColumn({required this.value, required this.label, required this.valueColor});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: TextStyle(color: valueColor, fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }
}

class _BadgesRow extends StatelessWidget {
  const _BadgesRow();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/amature-badge.png', width: 50, height: 50),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Amature', style: TextStyle(fontSize: 10, color: Color(0xFFA46BF5), fontWeight: FontWeight.w600)),
            Text('2803', style: TextStyle(fontSize: 20, color: Color(0xFFA46BF5), fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
}

class _AchievementBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _AchievementBox({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.03),
        border: Border.all(color: const Color(0xFF8A6FCF), width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFA46BF5), size: 18),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
