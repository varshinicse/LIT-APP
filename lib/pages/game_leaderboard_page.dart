import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/common_button.dart';
import 'dart:ui';
import 'dart:math' as math;
import '../widgets/notification_bell.dart';
import 'package:lit/global_data.dart'; 



class GameLeaderboardPage extends StatefulWidget {
  const GameLeaderboardPage({super.key});

  @override
  State<GameLeaderboardPage> createState() => _GameLeaderboardPageState();
}

class _GameLeaderboardPageState extends State<GameLeaderboardPage> {
  int currentIndex = -1;
  final List<String> friendNames = friendList.map((f) => f['name']!).toList();


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

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: _AudioSettingsPopup(),
        );
      },
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
                        // Header
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
                                    const Icon(Icons.person_add_alt_1,
                                        size: 18, color: Colors.white),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Text(
                                      "Beginner",
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 12),
                                    ),
                                    const SizedBox(width: 6),
                                    CircleAvatar(
                                      radius: 8,
                                      backgroundImage: AssetImage(
                                          'assets/images/india-flag.png'),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Player Stats & Badges Section
                        // Player Stats & Badges Section (Updated)
                        // Player Stats & Badges Section (Updated & Aligned)
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              // Player Stats Box
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(10),

                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 0.03), // Optional soft fill
                                    border: Border.all(color: Color(0xFF8A6FCF), width: 0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x59CFCFCF).withOpacity(0.1),
                                        offset: const Offset(0, 1),
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 30,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                  ),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Player Stats",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.white),
                                      ),
                                      const Divider(
                                        color: Color(0xFF8A6FCF),
                                        thickness: 0.4,
                                        height: 10,
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: const [
                                          _StatColumn(
                                            value: "16",
                                            label: "Games Played",
                                            valueColor: Color(0xFFA46BF5),
                                          ),
                                          _StatColumn(
                                            value: "21",
                                            label: "Games won",
                                            valueColor: Color(0xFFA46BF5),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              // Badges Box
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 0.03), // Optional soft fill
                                    border: Border.all(color: Color(0xFF8A6FCF), width: 0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x59CFCFCF).withOpacity(0.1),
                                        offset: const Offset(0, 1),
                                      ),
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 30,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                  ),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Badges",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Colors.white),
                                      ),
                                      const Divider(
                                        color: Color(0xFF8A6FCF),
                                        thickness: 0.4,
                                        height: 10,
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/amature-badge.png',
                                            width: 50,
                                            height: 50,
                                          ),
                                          const SizedBox(width: 8),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "Amature",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xFFA46BF5),
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                "2803",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFFA46BF5),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
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
                            color: const Color.fromRGBO(255, 255, 255, 0.03), // Optional soft fill
                            border: Border.all(color: Color(0xFF8A6FCF), width: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x59CFCFCF).withOpacity(0.1),
                                offset: const Offset(0, 1),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 30,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Achievements",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              const Divider(
                                color: Color(0xFF8A6FCF),
                                thickness: 0.4,
                                height: 10,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  _AchievementBox(
                                    icon: Icons.shopping_bag,
                                    label: "Bags",
                                    value: "33/40",
                                  ),
                                  _AchievementBox(
                                    icon: Icons.snowshoeing,
                                    label: "Footwear",
                                    value: "33/40",
                                  ),
                                  _AchievementBox(
                                    icon: Icons.checkroom,
                                    label: "Clothing",
                                    value: "33/40",
                                  ),
                                  _AchievementBox(
                                    icon: Icons.watch,
                                    label: "Accessories",
                                    value: "33/40",
                                  ),
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

              // ❌ Close Button
              Positioned(
                top: 3,
                right: 3,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF2D0C4B),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.close,
                        size: 16, color: Color(0xffD9BFFF)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  final List<Map<String, dynamic>> leaderboard = [
    {"rank": 1, "name": "LuxuryinTaste", "score": 555, "avatar": "assets/images/avatar1.jpg", "isGold": true},
    {"rank": 2, "name": "Gamer42", "score": 534, "avatar": "assets/images/avatar2.jpg", "isGold": false},
    {"rank": 3, "name": "Alix Johnson", "score": 510, "avatar": "assets/images/avatar3.jpg", "isGold": false},
    {"rank": 4, "name": "Mariya Satnova", "score": 500, "avatar": "assets/images/avatar4.jpg", "isGold": true},
    {"rank": 5, "name": "Gamer42", "score": 534, "avatar": "assets/images/avatar5.jpg", "isGold": true},
    {"rank": 6, "name": "Alix Johnson", "score": 510, "avatar": "assets/images/avatar6.jpg", "isGold": false},
    {"rank": 7, "name": "Mariya Satnova", "score": 500, "avatar": "assets/images/avatar7.jpg", "isGold": true},
    {"rank": 8, "name": "Gamer42", "score": 534, "avatar": "assets/images/avatar8.jpg", "isGold": false},
    {"rank": 9, "name": "Alix Johnson", "score": 510, "avatar": "assets/images/avatar9.jpg", "isGold": false},
    {"rank": 10, "name": "Mariya Satnova", "score": 500, "avatar": "assets/images/avatar10.jpg", "isGold": true},
    {"rank": 11, "name": "Gamer42", "score": 534, "avatar": "assets/images/avatar11.jpg", "isGold": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.6)),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      const Spacer(),
                      Image.asset("assets/images/logo.png", height: 40),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: NotificationBell(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "LEADERBOARD",
                  style: GoogleFonts.kronaOne(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 3.5,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16), // shift back button right
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: const [
                            Icon(Icons.arrow_back, color: Colors.white),
                            SizedBox(width: 8),
                            Text("Back", style: TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12), // shift settings icon right
                      child: GestureDetector(
                        onTap: () => _showSettingsDialog(context),
                        child: const Icon(Icons.settings, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: leaderboard.length,
                    itemBuilder: (context, index) {
                      final entry = leaderboard[index];
                      final bool isFriend = friendNames.contains(entry['name']);
                      final rank = entry['rank'];

                      Color bgColor = Colors.transparent;
                      Border border = Border.all(color: Colors.white60);

                      if (rank == 1) {
                        bgColor = Colors.amber.shade700;
                        border = Border.all(color: Colors.yellowAccent, width: 2);
                      } else if (rank == 2) {
                        bgColor = Colors.grey.shade700;
                        border = Border.all(color: Colors.grey, width: 2);
                      } else if (rank == 3) {
                        bgColor = Colors.brown.shade600;
                        border = Border.all(color: Colors.brown.shade300, width: 2);
                      }

                      return GestureDetector(
                        onTap: () {
                          _showPlayerPopup(context, entry);
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      border: border,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      rank.toString(),
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  CircleAvatar(
                                    backgroundImage: AssetImage(entry['avatar']),
                                    radius: 22,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      entry['name'],
                                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      if (isFriend) ...[
                                        Image.asset(
                                          'assets/images/clap.png', // 👏 replace with your actual clap image path
                                          width: 18,
                                          height: 18,
                                        ),
                                      ],
                                      const SizedBox(width: 10),
                                      Image.asset(
                                        entry['isGold'] ? 'assets/images/gold_star.png' : 'assets/images/purple_star.png',
                                        width: 20,
                                        height: 20,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        entry['score'].toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white54,
                              thickness: 1,
                              height: 0,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: _onNavTapped,
        isMarketplace: false,
        isGame: true
      ),
    );
  }
}

class _AchievementBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _AchievementBox({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.05),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF201921).withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(
            icon,
            size: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA46BF5),
          ),
        ),
      ],
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;

  const _StatColumn({
    Key? key,
    required this.value,
    required this.label,
    this.valueColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}



// Audio Settings Dialog

class _AudioSettingsPopup extends StatefulWidget {
  const _AudioSettingsPopup();

  @override
  State<_AudioSettingsPopup> createState() => _AudioSettingsPopupState();
}

class _AudioSettingsPopupState extends State<_AudioSettingsPopup> {
  double masterVolume = 0.7;
  double sfxVolume = 0.9;

  double previousMasterVolume = 0.7;
  double previousSfxVolume = 0.9;

  bool isMasterMuted = false;
  bool isSfxMuted = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final popupWidth = math.min(screenWidth * 0.79, 500.0); // 90% of screen or 500 max

    return Center(
      child: UnconstrainedBox(
        child: SizedBox(
          width: popupWidth.toDouble(),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const RadialGradient(
                          center: Alignment(0, -0.2),
                          radius: 1.2,
                          colors: [
                            Color(0x2FFFFFFF),
                            Color(0x33FFFFFF),
                          ],
                          stops: [0.1, 1.0],
                        ),
                        border: Border.all(color: Colors.white24, width: 1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "SETTINGS",
                            style: GoogleFonts.kronaOne(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32),
                          _buildVolumeRow("Master Volume", masterVolume, (val) {
                            setState(() {
                              masterVolume = val;
                              if (val > 0) isMasterMuted = false;
                            });
                          }),
                          const SizedBox(height: 20),
                          _buildVolumeRow("SFX Volume", sfxVolume, (val) {
                            setState(() {
                              sfxVolume = val;
                              if (val > 0) isSfxMuted = false;
                            });
                          }),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _AudioIconButton(
                                icon: isMasterMuted ? Icons.music_off : Icons.music_note,
                                onTap: () {
                                  setState(() {
                                    if (isMasterMuted) {
                                      masterVolume = previousMasterVolume;
                                      isMasterMuted = false;
                                    } else {
                                      previousMasterVolume = masterVolume;
                                      masterVolume = 0.0;
                                      isMasterMuted = true;
                                    }
                                  });
                                },
                              ),
                              const SizedBox(width: 24),
                              _AudioIconButton(
                                icon: isSfxMuted ? Icons.volume_off : Icons.volume_up,
                                onTap: () {
                                  setState(() {
                                    if (isSfxMuted) {
                                      sfxVolume = previousSfxVolume;
                                      isSfxMuted = false;
                                    } else {
                                      previousSfxVolume = sfxVolume;
                                      sfxVolume = 0.0;
                                      isSfxMuted = true;
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white30,
                    child: Icon(Icons.close, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVolumeRow(String label, double value, ValueChanged<double> onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanUpdate: (details) {
                  final newWidth = (details.localPosition.dx / constraints.maxWidth).clamp(0.0, 1.0);
                  onChanged(newWidth);
                },
                onTapDown: (details) {
                  final newWidth = (details.localPosition.dx / constraints.maxWidth).clamp(0.0, 1.0);
                  onChanged(newWidth);
                },
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 1),
                    color: Colors.transparent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Stack(
                      children: [
                        FractionallySizedBox(
                          widthFactor: value,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFFE0E0E0), Color(0xFF8B8B8B)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AudioIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _AudioIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white12,
        ),
        padding: const EdgeInsets.all(16),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
