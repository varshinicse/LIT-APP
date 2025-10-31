import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import '../widgets/notification_bell.dart';

class GameEntrancePage extends StatefulWidget {
  const GameEntrancePage({super.key});

  @override
  State<GameEntrancePage> createState() => _GameEntrancePageState();
}

class _GameEntrancePageState extends State<GameEntrancePage> {
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

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: const _AudioSettingsPopup(),
        );
      },
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 0),
            child: NotificationBell(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: _onNavTapped,
        // Removed isGame: true, since your CustomBottomNavBar only accepts currentIndex and onTap
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.65)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // 🔹 Top row: Back + Settings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/home'),
                        child: Row(
                          children: const [
                            Icon(Icons.arrow_back, color: Colors.white),
                            SizedBox(width: 8),
                            Text("Back",
                                style: TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showSettingsDialog(context),
                        child: const Icon(Icons.settings, color: Colors.white),
                      ),
                    ],
                  ),

                  // 🔹 Expanded Center Section
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 🟪 LIT GAME Layout
                        Center(
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 380,
                                padding: const EdgeInsets.only(top: 20, bottom: 24),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: Colors.white, width: 3),
                                  color: const Color(0xFF1B0428).withOpacity(0.85),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    buildShoeCard('assets/images/violet-shoe.png', -math.pi / 15),
                                    const SizedBox(width: 8),
                                    // 🎨 VS
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Text(
                                          'VS',
                                          style: TextStyle(
                                            fontSize: 56,
                                            fontWeight: FontWeight.w900,
                                            foreground: Paint()
                                              ..style = PaintingStyle.stroke
                                              ..strokeWidth = 5
                                              ..color = Colors.black,
                                          ),
                                        ),
                                        ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            return const LinearGradient(
                                              colors: [Color(0xFFB497D6), Color(0xFF6B4F9E)],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ).createShader(bounds);
                                          },
                                          child: const Text(
                                            'VS',
                                            style: TextStyle(
                                              fontSize: 50,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 8),
                                    buildShoeCard('assets/images/blue-shoe.png', math.pi / 15),
                                  ],
                                ),
                              ),

                              // 🟪 LIT GAME Tab
                              Positioned(
                                top: -26,
                                left: 0,
                                right: 0,
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 26, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF200D33),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: Colors.white, width: 3),
                                    ),
                                    child: const Text(
                                      'LIT GAME',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                        letterSpacing: 1.4,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 80),

                        // 🔹 Buttons
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            children: [
                              Expanded(
                                child: _buildGameButton("Play Now", onTap: () {
                                  Navigator.pushNamed(context, '/game-modes');
                                }),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildGameButton("Shop", onTap: () {
                                  Navigator.pushNamed(context, '/game-shop');
                                }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          child: _buildGameButton("Friend list", onTap: () {
                            Navigator.pushNamed(context, '/friend-list');
                          }),
                        ),
                      ],
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

  Widget buildShoeCard(String imgPath, double angle) {
    return Transform.rotate(
      angle: angle,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: 100,
          height: 190,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(2, 10),
              ),
            ],
            color: Colors.transparent,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    color: const Color(0xFFEDEDED),
                    alignment: Alignment.center,
                    child: Image.asset(
                      imgPath,
                      height: 95,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: const Text(
                      '???',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const RadialGradient(
            center: Alignment(0.08, 0.08),
            radius: 7.98,
            colors: [
              Color.fromRGBO(0, 0, 0, 0.8),
              Color.fromRGBO(147, 51, 234, 0.4),
            ],
            stops: [0.0, 0.5],
          ),
          border: Border.all(color: Color(0xFFAEAEAE), width: 1),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

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
    final popupWidth = math.min(screenWidth * 0.79, 500.0);

    return Center(
      child: UnconstrainedBox(
        child: SizedBox(
          width: popupWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: -6,
                right: -6,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // closes the dialog
                  },
                  child: Image.asset(
                    'assets/close.png',
                    width: 28,
                    height: 28,
                  ),
                ),
              ),
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
                          const SizedBox(height: 24),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              _settingsPill(
                                icon: Icons.info_outline,
                                label: 'How to Play',
                                onTap: () {},
                              ),
                              _settingsPill(
                                icon: Icons.privacy_tip_outlined,
                                label: 'Privacy',
                                onTap: () {},
                              ),
                              _settingsPill(
                                icon: Icons.gavel_outlined,
                                label: 'Terms of Service',
                                onTap: () {},
                              ),
                              _settingsPill(
                                icon: Icons.headset_mic_outlined,
                                label: 'Help And Support',
                                onTap: () {},
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

  Widget _settingsPill(
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVolumeRow(
      String label, double value, ValueChanged<double> onChanged) {
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
                  final newWidth = (details.localPosition.dx /
                          constraints.maxWidth)
                      .clamp(0.0, 1.0);
                  onChanged(newWidth);
                },
                onTapDown: (details) {
                  final newWidth = (details.localPosition.dx /
                          constraints.maxWidth)
                      .clamp(0.0, 1.0);
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
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFE0E0E0),
                                  Color(0xFF8B8B8B)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${(value * 100).round()}%',
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
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

  const _AudioIconButton({required this.icon, required this.onTap});

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