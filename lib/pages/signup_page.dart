import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _showFacebookPopup = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      debugPrint("✅ Signed up as: ${userCredential.user?.email}");
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (error) {
      debugPrint("❌ Google Sign-Up failed: $error");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Google sign-up failed: $error")),
        );
      }
    }
  }

  Future<void> _handleEmailSignup() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter email and password')),
      );
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Account created successfully!')),
      );

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up failed: ${e.message}')),
      );
    }
  }

  void _toggleFacebookPopup(bool value) {
    setState(() {
      _showFacebookPopup = value;
    });
  }

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

          // 🔹 Main Signup Content
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', height: 100),
                const SizedBox(height: 30),

                const Text(
                  'SIGN UP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Sign up with your email address',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 30),

                _buildInputField(
                  hint: 'Full Name',
                  icon: Icons.person,
                  controller: _nameController,
                ),
                const SizedBox(height: 18),
                _buildInputField(
                  hint: 'Yourname@gmail.com',
                  icon: Icons.email,
                  controller: _emailController,
                ),
                const SizedBox(height: 18),
                _PasswordField(controller: _passwordController),
                const SizedBox(height: 22),

                _gradientButton("Sign Up", _handleEmailSignup),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an Account? ",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
                      child: const Text(
                        "Sign In",
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

                // 🔹 Google & Facebook buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton("Google", "assets/images/google.png",
                        onTap: _handleGoogleSignIn),
                    const SizedBox(width: 20),
                    _socialButton("Facebook", "assets/images/facebook.png",
                        onTap: () => _toggleFacebookPopup(true)),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),

          // 🔹 Facebook Popup Positioned Between Title & Social Buttons
          if (_showFacebookPopup) ...[
            GestureDetector(
              onTap: () => _toggleFacebookPopup(false),
              child: Container(color: Colors.black.withOpacity(0.6)),
            ),

            Positioned(
              top: screenHeight * 0.34, // adjusted for perfect balance
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
                      // Email field
                      TextField(
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 15),
                        cursorColor: Colors.grey.shade700,
                        decoration: InputDecoration(
                          hintText:
                              'Email address or phone number required',
                          hintStyle: const TextStyle(color: Colors.black54),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Password field
                      TextField(
                        obscureText: true,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 15),
                        cursorColor: Colors.grey.shade700,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.black54),
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Log in button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _toggleFacebookPopup(false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Facebook login simulated')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1877F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Forgotten Password
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgotten Password',
                          style: TextStyle(
                              color: Color(0xFF1877F2), fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Divider
                      Container(
                        height: 1,
                        color: Colors.grey.shade300,
                        margin:
                            const EdgeInsets.symmetric(vertical: 8),
                      ),

                      // Create new account button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _toggleFacebookPopup(false);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'New Facebook account simulated')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF42B72A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Create new account',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
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

  Widget _buildInputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: controller,
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _socialButton(String label, String iconPath,
      {required VoidCallback onTap}) {
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
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  final TextEditingController controller;
  const _PasswordField({super.key, required this.controller});
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
        controller: widget.controller,
        obscureText: _obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Password',
          hintStyle: const TextStyle(color: Colors.white54, fontSize: 14),
          prefixIcon: const Icon(Icons.lock, color: Colors.white70),
          suffixIcon: IconButton(
            icon: Icon(
              _obscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.white70,
            ),
            onPressed: () => setState(() => _obscure = !_obscure),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}
