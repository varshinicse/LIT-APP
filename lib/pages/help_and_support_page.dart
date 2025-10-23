import 'package:flutter/material.dart';
import 'package:lit/widgets/app_drawer.dart';
import 'package:lit/pages/notifications_page.dart';
import 'package:lit/pages/profile_page.dart';
import 'package:lit/screens/home/home_page.dart';
import 'package:lit/widgets/common_button.dart'; // ✅ Use your shared bottom nav file

class HelpAndSupportPage extends StatefulWidget {
  const HelpAndSupportPage({super.key});

  @override
  State<HelpAndSupportPage> createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  String? selectedIssue;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController playerIdController =
      TextEditingController(text: "603552b6-58f4-45d7-bb1c-45bda74ded70");
  final TextEditingController messageController = TextEditingController();

  static const RadialGradient sustainableGradient = RadialGradient(
    center: Alignment(0.08, 0.08),
    radius: 7.98,
    colors: [
      Color.fromRGBO(0, 0, 0, 0.8),
      Color.fromRGBO(147, 51, 234, 0.4),
    ],
    stops: [0.0, 0.5],
  );

  int _selectedIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() => _selectedIndex = index);
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          /// 🌌 Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          /// 🧭 Main Content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                    child: Column(
                      children: [
                        /// 🔝 Header
                        _buildHeader(),

                        const SizedBox(height: 20),

                        const Text(
                          "Submit a response",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6,
                            fontFamily: 'Poppins',
                          ),
                        ),

                        const SizedBox(height: 28),

                        buildLabel("Please select an issue that you are having"),
                        buildDropdown(),

                        const SizedBox(height: 16),
                        buildLabel("Your email address"),
                        buildInputField(emailController),

                        const SizedBox(height: 16),
                        buildLabel("What is your Player/Unique ID"),
                        buildInputField(playerIdController),

                        const SizedBox(height: 16),
                        buildLabel(
                            "Please do not add more than 100 characters here. If you wish to share more information with us, please add it to the 'Description' box below."),
                        buildInputField(messageController,
                            hint: "write here.....", maxLines: 3),

                        const SizedBox(height: 16),
                        buildLabel("Attachments (optional)"),
                        buildUploadBox(),

                        const SizedBox(height: 28),

                        /// 🌈 Submit Button
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 130,
                            height: 38,
                            decoration: BoxDecoration(
                              gradient: sustainableGradient,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white24,
                                width: 0.5,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Submit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.5,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),

                /// 🧭 Bottom Navigation Bar (From common_button.dart)
                CustomBottomNavBar(
                  currentIndex: _selectedIndex,
                  onTap: _onBottomNavTapped,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🧩 Header
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// ☰ Menu icon
          Builder(
            builder: (context) => GestureDetector(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.only(left: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 20, height: 2, color: Colors.white),
                    const SizedBox(height: 4),
                    Container(width: 20, height: 2, color: Colors.white),
                    const SizedBox(height: 4),
                    Container(width: 20, height: 2, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),

          /// 🖤 Center logo
          Image.asset(
            'assets/images/logo.png',
            height: 45,
            width: 45,
          ),

          /// 🔔 Notification icon
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 2),
              child: Icon(Icons.notifications, color: Colors.white, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  /// 🏷 Label
  Widget buildLabel(String text) => Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              height: 1.3,
            ),
          ),
        ),
      );

  /// 🔽 Dropdown
  Widget buildDropdown() => Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          border: Border.all(color: Colors.white54, width: 0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedIssue,
            dropdownColor: Colors.black87,
            isExpanded: true,
            hint: const Text(
              "Select issue",
              style: TextStyle(color: Colors.white70, fontSize: 13.5),
            ),
            icon: const Icon(Icons.arrow_drop_down, color: Colors.white70),
            items: const [
              DropdownMenuItem(
                value: "login",
                child:
                    Text("Login Issue", style: TextStyle(color: Colors.white)),
              ),
              DropdownMenuItem(
                value: "payment",
                child: Text("Payment Failed",
                    style: TextStyle(color: Colors.white)),
              ),
              DropdownMenuItem(
                value: "other",
                child: Text("Other", style: TextStyle(color: Colors.white)),
              ),
            ],
            onChanged: (value) => setState(() => selectedIssue = value),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  /// ✏️ Input Field
  Widget buildInputField(TextEditingController controller,
      {String? hint, int maxLines = 1}) {
    return Container(
      height: maxLines == 1 ? 44 : 90,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white70, width: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white, fontSize: 13.5),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 13),
          border: InputBorder.none,
        ),
      ),
    );
  }

  /// 📎 Upload Box
  Widget buildUploadBox() => Container(
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white70, width: 0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Add file or Drop a file",
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
        ),
      );
}
