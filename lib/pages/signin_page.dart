// ignore_for_file: use_build_context_synchronously

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lit/screens/main_layout.dart';
import 'package:lit/screens/home/home_page.dart';
// ✅ Add this import for navigation

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _showFacebookPopup = false;

  // ---------------- GOOGLE SIGN-IN ----------------
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        messenger.showSnackBar(
          const SnackBar(content: Text('Google sign-in cancelled')),
        );
        return;
      }
      messenger.showSnackBar(
        SnackBar(content: Text('Signed in as ${googleUser.email}')),
      );

      // ✅ After Google sign-in, go to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('Google Sign-In failed: $error')),
      );
    }
  }

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🔹 Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.65)),

          // 🔹 Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 100),
                const SizedBox(height: 30),

                const Text(
                  'SIGN IN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sign in with your email address',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 40),

                _buildInputField(hint: 'Yourname@gmail.com', icon: Icons.email),
                const SizedBox(height: 18),
                const _PasswordField(),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot_password');
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ✅ When pressing "Sign In", go to Home Page
                _gradientButton("Sign In", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                  );
                }),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don’t have an Account? ",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Color.fromRGBO(147, 51, 234, 0.9),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),

                Row(
                  children: const [
                    Expanded(child: Divider(color: Colors.white38)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or continue with",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.white38)),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(
                      "Google",
                      "assets/images/google.png",
                      onTap: () => _handleGoogleSignIn(context),
                    ),
                    const SizedBox(width: 20),
                    _socialButton(
                      "Facebook",
                      "assets/images/facebook.png",
                      onTap: () => setState(() {
                        _showFacebookPopup = true;
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🔹 Facebook Popup (same as before)
          if (_showFacebookPopup) ...[
            GestureDetector(
              onTap: () => setState(() => _showFacebookPopup = false),
              child: Container(color: Colors.black.withOpacity(0.6)),
            ),
            Positioned(
              top: screenHeight * 0.34,
              child: AnimatedOpacity(
                opacity: _showFacebookPopup ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        style: const TextStyle(color: Colors.black87),
                        cursorColor: Colors.grey.shade700,
                        decoration: InputDecoration(
                          hintText: 'Email address or phone number',
                          hintStyle: const TextStyle(color: Colors.black54),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.black87),
                        cursorColor: Colors.grey.shade700,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.black54),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() => _showFacebookPopup = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Facebook login simulated')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1877F2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Log in',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgotten Password?',
                          style: TextStyle(color: Color(0xFF1877F2), fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 1,
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() => _showFacebookPopup = false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('New Facebook account simulated')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF42B72A),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Create new account',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ---------------- Reusable Widgets ----------------
  Widget _buildInputField({
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
          prefixIcon: Icon(icon, color: Colors.white70),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _gradientButton(String text, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(147, 51, 234, 0.9),
            Color.fromRGBO(0, 0, 0, 0.85)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _socialButton(String label, String iconPath, {required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 22),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

// ---------------- Password Field ----------------
class _PasswordField extends StatefulWidget {
  const _PasswordField({super.key});
  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        obscureText: _obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
          prefixIcon: const Icon(Icons.lock, color: Colors.white70),
          suffixIcon: IconButton(
            icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white70),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
