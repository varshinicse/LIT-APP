import 'dart:math';
import 'package:flutter/material.dart';

class LitGameBoxOnly extends StatelessWidget {
  const LitGameBoxOnly({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Stack(
            clipBehavior: Clip.none,
            children: [
              // 🟪 Game Box with increased vertical padding
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 40, bottom: 50), // Increased vertical padding
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white, width: 2),
                  color: const Color(0xFF1B0428).withOpacity(0.85),
                ),
                constraints: const BoxConstraints(minHeight: 300), // Added minimum height
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildShoeCard('assets/images/violet-shoe.png', -pi / 15),
                        const SizedBox(width: 8),
                        // 🎨 VS Text with outline and gradient
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              'VS',
                              style: TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.w900,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 4
                                  ..color = Colors.black,
                              ),
                            ),
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  colors: [
                                    Color(0xFFB497D6),
                                    Color(0xFF6B4F9E),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: const Text(
                                'VS',
                                style: TextStyle(
                                  fontSize: 46,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        _buildShoeCard('assets/images/blue-shoe.png', pi / 15),
                      ],
                    ),
                  ],
                ),
              ),

              // 🛑 Mask top border behind tab
              Positioned(
                top: -2,
                left: screenWidth * 0.25,
                right: screenWidth * 0.25,
                child: Container(
                  height: 12,
                  color: const Color(0xFF1B0428),
                ),
              ),

              // 🟪 LIT GAME Tab
              Positioned(
                top: -20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF200D33),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Text(
                      'LIT GAME',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🟦 Shoe Card
  Widget _buildShoeCard(String imgPath, double angle) {
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
}
