import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

import '../providers/notification_provider.dart';
import '../widgets/notification_bell.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({super.key});

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  int currentIndex = -1;
  String selectedTab = 'Friend list';
  bool isSearching = false;

  TextEditingController _searchController = TextEditingController();

  void _showFriendRequestSent(String name, String image) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Friend request sent to $name'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<Map<String, String>> searchResults = [];

  final List<Map<String, dynamic>> friendList = [
    {'name': 'Gamer65', 'image': 'assets/images/avatar1.jpg'},
    {'name': 'Beautyeve', 'image': 'assets/images/avatar2.jpg'},
    {'name': 'Liya James', 'image': 'assets/images/avatar3.jpg'},
    {'name': 'Gamer65', 'image': 'assets/images/avatar4.jpg'},
    {'name': 'Beautyeve', 'image': 'assets/images/avatar5.jpg'},
    {'name': 'Liya James', 'image': 'assets/images/avatar6.jpg'},
    {'name': 'Gamer65', 'image': 'assets/images/avatar7.jpg'},
    {'name': 'Beautyeve', 'image': 'assets/images/avatar8.jpg'},
    {'name': 'Liya James', 'image': 'assets/images/avatar9.jpg'},
  ];

  final List<Map<String, dynamic>> pendingRequests = [
    {'name': 'Luxuryintatse', 'image': 'assets/images/avatar10.jpg', 'score': '553'},
    {'name': 'ChicWave', 'image': 'assets/images/avatar11.jpg', 'score': '521'},
    {'name': 'GlamMystery', 'image': 'assets/images/avatar8.jpg', 'score': '499'},
  ];

  final List<Map<String, String>> allUsers = [
    {'name': 'Gamer65', 'image': 'assets/images/avatar1.jpg'},
    {'name': 'Beautyeve', 'image': 'assets/images/avatar2.jpg'},
    {'name': 'Liya James', 'image': 'assets/images/avatar3.jpg'},
    {'name': 'Luxuryintatse', 'image': 'assets/images/avatar10.jpg'},
    {'name': 'ChicWave', 'image': 'assets/images/avatar11.jpg'},
    {'name': 'GlamMystery', 'image': 'assets/images/avatar8.jpg'},
    {'name': 'NewUserX', 'image': 'assets/images/avatar6.jpg'},
    {'name': 'NewUserY', 'image': 'assets/images/avatar7.jpg'},
    {'name': 'NewUserZ', 'image': 'assets/images/avatar8.jpg'},
  ];

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
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 0.03),
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
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 0.03),
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
                            color: const Color.fromRGBO(255, 255, 255, 0.03),
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

  Future<void> _showAcceptedPopup(String name, String imagePath) async {
    await showDialog(
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
                    width: 380,
                    padding: const EdgeInsets.fromLTRB(28, 36, 28, 36),
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
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.kronaOne(
                              color: Colors.white, fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18),
                        CircleAvatar(radius: 62, backgroundImage: AssetImage(imagePath)),
                        const SizedBox(height: 22),
                        const Text(
                          'Is now in your Friend List!',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 26),
                        SizedBox(
                          width: 280,
                          height: 42,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const FriendSuggestionsPage()),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const RadialGradient(
                                  center: Alignment(0.08, 0.08),
                                  radius: 7.98,
                                  colors: [
                                    Color.fromRGBO(0, 0, 0, 0.8),
                                    Color.fromRGBO(147, 51, 234, 0.4),
                                  ],
                                ),
                                border: Border.all(color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x66000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Text(
                                  'Add More Friends',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 7,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset('assets/images/Rectangle.png', width: 54, height: 54),
                      const Icon(Icons.close, color: Colors.white, size: 22),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleSearch(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
    });

    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    final normalizedQuery = query.toLowerCase();

    final results = allUsers.where((user) {
      final userName = user['name']!.toLowerCase();
      return userName.contains(normalizedQuery);
    }).toList();

    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Image.asset('assets/images/logo.png', height: 40),
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: NotificationBell(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: _onNavTapped,
        isGame: true,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "FRIENDS",
                      style: GoogleFonts.kronaOne(
                        fontSize: 22,
                        color: Colors.white,
                        letterSpacing: 4,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/game-entrance'),
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
                        padding: const EdgeInsets.only(right: 1.0),
                        child: GestureDetector(
                          onTap: () => _showSettingsDialog(context),
                          child: const Icon(Icons.settings, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildToggleButton("Friend list"),
                      const SizedBox(width: 12),
                      _buildToggleButton("Pending Request"),
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
                        GestureDetector(
                          onTap: () {
                            if (isSearching) {
                              setState(() {
                                _searchController.clear();
                                searchResults = [];
                                isSearching = false;
                              });
                            }
                          },
                          child: Icon(
                            isSearching ? Icons.arrow_back : Icons.search,
                            color: const Color(0xFFBFA9DD),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: _handleSearch,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Color(0xFFBFA9DD)),
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_searchController.text.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Expanded(
                      child: searchResults.isEmpty
                          ? const Center(
                              child: Text(
                                "No users found",
                                style: TextStyle(color: Colors.white54, fontSize: 16),
                              ),
                            )
                          : ListView.builder(
                              itemCount: searchResults.length,
                              itemBuilder: (context, index) {
                                final user = searchResults[index];
                                final name = user['name']!;
                                final image = user['image']!;
                                final isFriend = friendList.any((f) => f['name'] == name);
                                final isPending = pendingRequests.any((r) => r['name'] == name);

                                if (isFriend) {
                                  return buildFriendCard(name, image, friendList.indexWhere((f) => f['name'] == name));
                                } else if (isPending) {
                                  final matchedUser = pendingRequests.firstWhere((r) => r['name'] == name, orElse: () => {});
                                  final score = matchedUser['score'] ?? '0';
                                  final sentByMe = matchedUser['sentByMe'] == true;
                                  return buildPendingRequestCard(name, image, score, sentByMe: sentByMe);
                                } else {
                                  return buildAddFriendCard(name, image, () {
                                    context.read<NotificationProvider>().addGameNotification({
                                      'type': 'user',
                                      'time': DateTime.now().toIso8601String(),
                                      'name': name,
                                      'message': 'You sent a friend request to $name.',
                                      'image': image,
                                    });
                                    setState(() {
                                      pendingRequests.add({
                                        'name': name,
                                        'image': image,
                                        'score': '0',
                                        'sentByMe': true,
                                      });
                                    });
                                  });
                                }
                              }),
                    ),
                  ]
                  else if (selectedTab == 'Friend list') ...[
                    const SizedBox(height: 20),
                    Expanded(
                      child: friendList.isEmpty
                          ? Center(
                              child: Text(
                                "No friends yet",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: friendList.length,
                              itemBuilder: (context, index) {
                                final friend = friendList[index];
                                return buildFriendCard(friend['name']!, friend['image']!, index);
                              },
                            ),
                    )
                  ]
                  else if (selectedTab == 'Pending Request') ...[
                    const SizedBox(height: 20),
                    Expanded(
                      child: pendingRequests.isEmpty
                          ? const Center(
                              child: Text(
                                "No pending requests",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: pendingRequests.length,
                              itemBuilder: (context, index) {
                                final request = pendingRequests[index];
                                final sentByMe = request['sentByMe'] == true;
                                return buildPendingRequestCard(
                                  request['name'],
                                  request['image'],
                                  request['score'] ?? '0',
                                  sentByMe: sentByMe,
                                );
                              },
                            ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddFriendCard(String name, String image, VoidCallback onSendRequest) {
    final friend = {'name': name, 'avatar': image};

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _showPlayerPopup(context, friend),
              child: Row(
                children: [
                  CircleAvatar(radius: 24, backgroundImage: AssetImage(image)),
                  const SizedBox(width: 12),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              onSendRequest();
              bool closedByUser = false;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        width: 300,
                        height: 160,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Request sent successfully",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            closedByUser = true;
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: const Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              await Future.delayed(const Duration(milliseconds: 700));
              if (Navigator.of(context).canPop() && !closedByUser) {
                Navigator.of(context).pop();
              }
              _showFriendRequestSent(name, image);
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white30),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.person_add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPendingRequestCard(String name, String imagePath, String score, {bool sentByMe = false}) {
    final friend = {'name': name, 'avatar': imagePath};

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: GestureDetector(
        onTap: () => _showPlayerPopup(context, friend),
        child: Row(
          children: [
            CircleAvatar(radius: 24, backgroundImage: AssetImage(imagePath)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!sentByMe) ...[
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/star.png', width: 18, height: 18),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              score,
                              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: const RadialGradient(
                          center: Alignment(0.08, 0.08),
                          radius: 7.98,
                          colors: [Color.fromRGBO(0, 0, 0, 0.8), Color.fromRGBO(147, 51, 234, 0.4)],
                          stops: [0.0, 0.5],
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.check, color: Colors.white, size: 18),
                        onPressed: () {
                          setState(() {
                            friendList.add({'name': name, 'image': imagePath});
                            pendingRequests.removeWhere((r) => r['name'] == name);
                            context.read<NotificationProvider>().addGameNotification({
                              'type': 'user',
                              'time': DateTime.now().toIso8601String(),
                              'name': name,
                              'message': 'You accepted a friend request from $name.',
                              'image': imagePath,
                            });
                          });
                          _showAcceptedPopup(name, imagePath);
                        },
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.close, color: Colors.white, size: 18),
                        onPressed: () {
                          setState(() {
                            pendingRequests.removeWhere((r) => r['name'] == name);
                          });
                          context.read<NotificationProvider>().addGameNotification({
                            'type': 'user',
                            'time': DateTime.now().toIso8601String(),
                            'name': name,
                            'message': 'You rejected a friend request from $name.',
                            'image': imagePath,
                          });
                        },
                      ),
                    ),
                  ],
                  if (sentByMe) ...[
                    GestureDetector(
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
                                            "Withdraw Request",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            "Do you want to withdraw your friend request with $name?",
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 28),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
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
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    pendingRequests.removeWhere((r) => r['name'] == name);
                                                  });
                                                  context.read<NotificationProvider>().addGameNotification({
                                                    'type': 'user',
                                                    'time': DateTime.now().toIso8601String(),
                                                    'name': name,
                                                    'message': 'You withdrew your friend request to $name.',
                                                    'image': imagePath,
                                                  });
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
                                                  child: Text("Withdraw"),
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.white30),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.person, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text("Sent", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton(String label) {
    final isSelected = selectedTab == label;

    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = label);
      },
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
                  color: Color.fromRGBO(147, 51, 234, 0.4),
                  width: 1,
                ),
              ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildFriendCard(String name, String imagePath, int index) {
    final friend = {'name': name, 'avatar': imagePath};

    return GestureDetector(
      onTap: () => _showPlayerPopup(context, friend),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(imagePath),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              icon: SvgPicture.asset('assets/images/trash.svg', height: 22, width: 22, color: Colors.redAccent),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => DeleteFriendDialog(
                    friendName: friendList[index]['name']?.toString() ?? '',
                    onConfirm: () {
                      setState(() {
                        final deletedFriend = friendList[index];
                        friendList.removeAt(index);
                        context.read<NotificationProvider>().addGameNotification({
                          'type': 'user',
                          'time': 'JUST NOW',
                          'name': deletedFriend['name'],
                          'message': 'You removed ${deletedFriend['name']} from your friend list.',
                          'image': deletedFriend['image'],
                        });
                      });
                    },
                  ),
                );
              },
            ),
          ],
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

  Widget _settingsPill({required IconData icon, required String label, required VoidCallback onTap}) {
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
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFE0E0E0), Color(0xFF8B8B8B)],
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

class FriendSuggestionsPage extends StatefulWidget {
  const FriendSuggestionsPage({super.key});

  @override
  State<FriendSuggestionsPage> createState() => _FriendSuggestionsPageState();
}

class _FriendSuggestionsPageState extends State<FriendSuggestionsPage> {
  final List<Map<String, String>> suggestions = [
    {'name': 'LuxuryinTaste', 'avatar': 'assets/images/avatar10.jpg'},
    {'name': 'Gamer65', 'avatar': 'assets/images/avatar1.jpg'},
    {'name': 'Beautyeve', 'avatar': 'assets/images/avatar2.jpg'},
    {'name': 'Liya James', 'avatar': 'assets/images/avatar3.jpg'},
    {'name': 'Gamer65', 'avatar': 'assets/images/avatar4.jpg'},
    {'name': 'Beautyeve', 'avatar': 'assets/images/avatar5.jpg'},
    {'name': 'Liya James', 'avatar': 'assets/images/avatar6.jpg'},
    {'name': 'Gamer65', 'avatar': 'assets/images/avatar7.jpg'},
  ];
  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2D0C4B).withOpacity(0.9),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Settings content goes here.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Close'),
            ),
          ],
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
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 0.03),
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
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(255, 255, 255, 0.03),
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
                            color: const Color.fromRGBO(255, 255, 255, 0.03),
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

  Future<void> _showRequestSentPopup(String name, String imagePath) async {
    bool closedByUser = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              width: 320,
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.kronaOne(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(height: 16),
                  CircleAvatar(radius: 56, backgroundImage: AssetImage(imagePath)),
                  const SizedBox(height: 20),
                  const Text(
                    'Request sent successfully',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  closedByUser = true;
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    await Future.delayed(const Duration(milliseconds: 700));
    if (Navigator.of(context).canPop() && !closedByUser) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = suggestions
        .where((n) => n['name']!.toLowerCase().contains(_searchController.text.toLowerCase()))
        .toList();

    return Scaffold(
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/background.png', fit: BoxFit.cover)),
          Positioned.fill(child: Container(color: Colors.black.withOpacity(0.6))),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Builder(
                    builder: (ctx) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () => Scaffold.of(ctx).openDrawer(),
                        ),
                        Image.asset('assets/images/logo.png', height: 40),
                        const NotificationBell(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Back",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text('FRIENDS', style: GoogleFonts.kronaOne(color: Colors.white, letterSpacing: 6, fontSize: 20)),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF6B21A8),
                          border: Border.all(color: const Color(0xFF9333EA)),
                        ),
                        child: const Text('Friend List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        border: Border.all(color: const Color(0xFF9333EA)),
                      ),
                      child: const Text('Pending Request', style: TextStyle(color: Color(0xFFBFA9DD), fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0x569333EA), width: 1),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (isSearching) {
                              setState(() {
                                _searchController.clear();
                                isSearching = false;
                              });
                            } else {
                              setState(() {
                                isSearching = true;
                              });
                            }
                          },
                          child: Icon(
                            isSearching ? Icons.arrow_back : Icons.search,
                            color: const Color(0xFFBFA9DD),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Color(0xFFBFA9DD)),
                              border: InputBorder.none,
                              isCollapsed: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              onTap: () {
                                final parent = context.findAncestorStateOfType<_FriendListPageState>();
                                if (parent != null) {
                                  parent._showPlayerPopup(context, {'name': name, 'avatar': avatar});
                                } else {
                                  _showPlayerPopup(context, {'name': name, 'avatar': avatar});
                                }
                              },
                              child: Text(
                                name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _showRequestSentPopup(name, avatar);
                              if (mounted) {
                                context.read<NotificationProvider>().addGameNotification({
                                  'type': 'user',
                                  'time': DateTime.now().toIso8601String(),
                                  'name': name,
                                  'message': 'You sent a friend request to $name.',
                                  'image': avatar,
                                  'trailingIcon': 'assets/images/trash.png',
                                });
                                setState(() {
                                  suggestions.removeWhere((u) => u['name'] == name);
                                });
                              }
                            },
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
        ],
      ),
    );
  }
}

class DeleteFriendDialog extends StatelessWidget {
  final String friendName;
  final VoidCallback onConfirm;

  const DeleteFriendDialog({
    super.key,
    required this.friendName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    "Confirm to delete $friendName from your friend list?",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm();
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
                          child: Text("OK"),
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