import 'package:flutter/material.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/widgets/common_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:lit/providers/notification_provider.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int currentIndex = -1;
  int selectedTab = 0;
  final PageController _pageController = PageController();

  final List<String> tabs = ["Game", "Newsletter", "Ecommerce"];


  Map<String, List<Map<String, dynamic>>> newsletterNotificationsByDate = {
    'Today': [
      {
        'time': "2 MIN AGO",
        'name': "Fast Fashion",
        'message':
            "From echo-chic materials to ethical production - this week's style edit proves fashion can care.",
        'image': "assets/images/d1.jpg",
      },
      {
        'time': "12 MIN AGO",
        'name': "Luxury Fashion",
        'message':
            "This week's report breaks down iconic pieces, styling tips, and how to train your eye to stop real luxury.",
        'image': "assets/images/d2.jpg",
      },
      {
        'time': "23 MIN AGO",
        'name': "Sneaker World",
        'message':
            "This week's report breaks down iconic pieces, styling tips, and how to train your eye to stop real luxury.",
        'image': "assets/images/d3.jpg",
      },
    ],
    'Yesterday': [
      {
        'time': "24 HOURS AGO",
        'name': "Sneaker World",
        'message':
            "This week's report breaks down iconic pieces, styling tips, and how to train your eye to stop real luxury.",
        'image': "assets/images/sneaker1.png",
      },
      {
        'time': "1 DAY AGO",
        'name': "Sneaker World",
        'message':
            "This week's report breaks down iconic pieces, styling tips, and how to train your eye to stop real luxury.",
        'image': "assets/images/sneaker2.png",
      },
    ],
  };

  Map<String, List<Map<String, dynamic>>> ecommerceNotificationsByDate = {
    'Today': [
      {
        'time': "2 MIN AGO",
        'name': "Footwear",
        'message':
            "shoes you eyed last week are now 40% off. Time to add to cart?",
        'image': "assets/images/noti-footwear.jpg",
      },
      {
        'time': "12 MIN AGO",
        'name': "Bags",
        'message':
            "The dupe of the week is trending. Yours is in stock — and still on sale.",
        'image': "assets/images/noti-bags.jpg",
      },
      {
        'time': "23 MIN AGO",
        'name': "Accessories",
        'message':
            "We’ve added 10 more premium-looking shirts under ₹999 — tap to browse now.",
        'image': "assets/images/noti-accessories.jpg",
      },
    ],
    'Yesterday': [
      {
        'time': "24 HOURS AGO",
        'name': "Clothing",
        'message':
            "We’ve added 10 more premium-looking shirts under ₹999 — tap to browse now.",
        'image': "assets/images/noti-clothing.jpg",
      },
      {
        'time': "1 DAY AGO",
        'name': "Bags",
        'message':
            "We’ve added 10 more premium-looking shirts under ₹999 — tap to browse now.",
        'image': "assets/images/noti-bags2.jpg",
      },
    ],
  };

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
  void initState() {
    super.initState();
  }


  Widget buildTab(String label, int index) {
    final isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = index);
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
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
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x66000000),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              )
            : BoxDecoration(
                border: Border.all(color: Color.fromRGBO(147, 51, 234, 0.4)),
                borderRadius: BorderRadius.circular(25),
              ),
        child: SizedBox(
          width: 100, // uniform tab width
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUserNotification({
    required String time,
    required String name,
    required String message,
    required String imageAsset,
    required VoidCallback onDelete,
    bool isNew = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔴 Avatar with red dot badge
          Stack(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(imageAsset),
              ),

            ],
          ),
          const SizedBox(width: 12),
          // 🔹 Notification content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                const SizedBox(height: 2),
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 2),
                Text(message, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                if (isNew)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('NEW', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_sharp, color: Colors.redAccent),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  Widget buildGameNotification({
    required String time,
    required String message,
    required VoidCallback onDelete,
    required bool isNew,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset('assets/images/video-game.png', height: 40, width: 40, fit: BoxFit.contain),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(time, style: const TextStyle(color: Colors.white38, fontSize: 11)),
                const SizedBox(height: 2),
                Text(message, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_sharp, color: Colors.redAccent),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 🔹 Background
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: () => Scaffold.of(context).openDrawer(),
                        ),
                      ),
                      Image.asset('assets/images/logo.png', height: 40),
                      const Icon(Icons.notifications, color: Colors.white),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                // 🔹 Page Title
                Center(
                  child: Text(
                    "NOTIFICATION",
                    style: GoogleFonts.kronaOne(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 26),

                // 🔹 Header Row
                Padding(
                  padding: const EdgeInsets.only(left: 19.0),
                  // 👈 Moves back button right
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_back, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Back",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // 🔹 Tabs
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      tabs.length,
                      (index) => buildTab(tabs[index], index),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 🔹 Notification List
                Expanded(
                  child: SizedBox.expand(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => selectedTab = index);
                        if (index == 0) {
                          context.read<NotificationProvider>().markAllSeen();
                        }
                      },
                      children: [
                        // 🔹 Game Notifications Tab
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            key: const ValueKey('game'),
                            children: context.watch<NotificationProvider>().groupedNotifications.entries.expand((entry) {
                              final date = entry.key;
                              final items = entry.value;
                              if (items.isEmpty) return <Widget>[];

                              return [
                                Text(
                                  date,
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ...items.map((notification) {
                                  final isNew = context.read<NotificationProvider>().isUnseenNotification(notification);

                                  if (notification['type'] == 'user') {
                                    return buildUserNotification(
                                      time: formatTimeAgo(DateTime.parse(notification['time'])),
                                      name: notification['name'],
                                      message: notification['message'],
                                      imageAsset: notification['image'],
                                      onDelete: () {
                                        context.read<NotificationProvider>().removeNotificationByTime(notification['time']);
                                      },
                                      isNew: isNew,
                                    );
                                  } else {
                                    return buildGameNotification(
                                      time: formatTimeAgo(DateTime.parse(notification['time'])),
                                      message: notification['message'],
                                      onDelete: () {
                                        context.read<NotificationProvider>().removeNotificationByTime(notification['time']);
                                      },
                                      isNew: isNew,
                                    );
                                  }
                                }),
                                const SizedBox(height: 20),
                              ];
                            }).toList(),
                          ),
                        ),

                        // 🔹 Newsletter Notifications Tab
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            key: const ValueKey('newsletter'),
                            children: newsletterNotificationsByDate.entries.expand((entry) {
                              final date = entry.key;
                              final items = entry.value;
                              if (items.isEmpty) return <Widget>[]; // Skip if no items for date

                              return [
                                Text(
                                  date,
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ...List.generate(items.length, (index) {
                                  final item = items[index];
                                  return buildUserNotification(
                                    time: item['time'],
                                    name: item['name'],
                                    message: item['message'],
                                    imageAsset: item['image'],
                                    onDelete: () {
                                      setState(() {
                                        items.removeAt(index);
                                      });
                                    },
                                    isNew: false,
                                  );
                                }),
                                const SizedBox(height: 20),
                              ];
                            }).toList(),
                          ),
                        ),

                        // 🔹 Ecommerce Notifications Tab
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView(
                            key: const ValueKey('ecommerce'),
                            children: ecommerceNotificationsByDate.entries.expand((entry) {
                              final date = entry.key;
                              final items = entry.value;
                              if (items.isEmpty) return <Widget>[]; // Skip if no items for date

                              return [
                                Text(
                                  date,
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                ...List.generate(items.length, (index) {
                                  final item = items[index];
                                  return buildUserNotification(
                                    time: item['time'],
                                    name: item['name'],
                                    message: item['message'],
                                    imageAsset: item['image'],
                                    onDelete: () {
                                      setState(() {
                                        items.removeAt(index);
                                      });
                                    },
                                    isNew: false,
                                  );
                                }),
                                const SizedBox(height: 20),
                              ];
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),

      // 🔹 Bottom Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: currentIndex,
        onTap: _onNavTapped,
        isMarketplace: false,
      ),
    );
  }
}
