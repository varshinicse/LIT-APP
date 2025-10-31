import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lit/widgets/app_drawer.dart';
import '../widgets/notification_bell.dart';
import 'package:lit/widgets/common_button.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String selectedTab = 'Gems';
  int currentIndex = 0;

  final List<Map<String, dynamic>> gemItems = [
    {'qty': 25, 'label': 'Fistful of Gems', 'price': '240 ₹', 'icon': 'assets/images/gems1.png'},
    {'qty': 50, 'label': 'Pouch of Gems', 'price': '240 ₹', 'icon': 'assets/images/gems3.png'},
    {'qty': 75, 'label': 'Bag of Gems', 'price': '240 ₹', 'icon': 'assets/images/gems2.png'},
    {'qty': 100, 'label': 'Box of Gems', 'price': '240 ₹', 'icon': 'assets/images/gems4.png'},
  ];

  final List<Map<String, dynamic>> livesItems = [
    {'qty': 5, 'label': 'Hearts', 'price': '2 GEMS', 'icon': 'assets/images/lives1.png'},
    {'qty': 10, 'label': 'Hearts', 'price': '4 GEMS', 'icon': 'assets/images/lives2.png'},
    {'qty': 15, 'label': 'Hearts', 'price': '6 GEMS', 'icon': 'assets/images/lives3.png'},
    {'qty': 20, 'label': 'Hearts', 'price': '8 GEMS', 'icon': 'assets/images/lives4.png'},
    {'qty': '∞', 'label': 'Hearts (2 min)', 'price': '20 GEMS', 'icon': 'assets/images/heart.png'},
  ];

  void _onNavTapped(int index) {
    setState(() => currentIndex = index);
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> itemsToShow =
        selectedTab == 'Gems' ? gemItems : livesItems;

    return Scaffold(
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Image.asset('assets/images/logo.png', height: 40),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/notifications_page');
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: NotificationBell(),
            ),
          ),
        ],
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
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "SHOP",
                      style: GoogleFonts.kronaOne(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 4,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text("Back", style: TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        _buildTabButton("Gems"),
                        const SizedBox(width: 15),
                        _buildTabButton("Lives"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                      itemCount: itemsToShow.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final item = itemsToShow[index];
                        return _buildItemCard(
                          item['qty'].toString(),
                          item['label'],
                          item['price'],
                          item['icon'],
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

      // ✅ Shared bottom navigation bar (same as game_page.dart)
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: _onNavTapped,
        isMarketplace: true,
        isGame: false,
      ),
    );
  }

  Widget _buildTabButton(String title) {
    final isActive = selectedTab == title;
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => setState(() => selectedTab = title),
      child: Container(
        width: screenWidth * 0.3,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: !isActive
            ? BoxDecoration(
                gradient: const RadialGradient(
                  center: Alignment(0.08, 0.08),
                  radius: 15,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(147, 51, 234, 0.4),
                  ],
                  stops: [0.0, 0.5],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x66000000),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF9333EA),
                  width: 1,
                ),
                color: Colors.transparent,
              ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemCard(String qty, String label, String price, String iconPath) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0x8036144D),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.only(left: 12.0, bottom: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              qty,
                              style: const TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFD5A8FF),
                                height: 1.0,
                              ),
                            ),
                            Text(
                              label.toLowerCase(),
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFFBDAED3),
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (iconPath.trim().isNotEmpty)
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 0.0),
                          child: Image.asset(
                            iconPath,
                            height: 90,
                            width: 85,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: const BoxDecoration(
              color: Color(0xFF240E36),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Text(
              price,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
