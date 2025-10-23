import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ✅ Providers
import 'package:lit/providers/notification_provider.dart';
import 'package:lit/ecommerce/wishlist_service.dart';
import 'package:lit/ecommerce/cart_service.dart';

// ✅ Pages & Screens
import 'screens/main_layout.dart';
import 'pages/help_and_support_page.dart';
import 'pages/ir_icon_page.dart';
import 'pages/profile_page.dart';
import 'pages/newsletter_page.dart';
import 'pages/sustainable_luxury.dart';
import 'pages/sustainable_store_page.dart';
import 'pages/luxury_store_page.dart';
import 'pages/category_page.dart';
import 'pages/signin_page.dart';
import 'pages/signup_page.dart';
import 'pages/forgot_password_page.dart';
import 'pages/game_category_page.dart';
import 'pages/game_page.dart';
import 'pages/game_leaderboard_page.dart';
import 'pages/game_modes_page.dart';
import 'settings/settings_page.dart';
import 'settings/account_settings_page.dart';
import 'settings/privacy_control_settings_page.dart';
import 'settings/language_country_settings_page.dart';
import 'settings/notifications_settings_page.dart';
import 'settings/subscription_settings_page.dart';
import 'settings/order_preferences_settings_page.dart';
import 'settings/return_cancellation_settings_page.dart';
import 'settings/support_legal_settings_page.dart';
import 'settings/payment_methods_page.dart';
import 'settings/subscription_plan_details_page.dart';
import 'pages/notifications_page.dart';
import 'pages/saved_item_page.dart';
import 'payment/payment_gateway_page.dart';
import 'pages/game_entrance_page.dart';
import 'pages/shop_page.dart';
import 'pages/friend_list_page.dart';
import 'package:lit/pages/coming_soon.dart';
import 'package:lit/ecommerce/billing_history.dart';
import 'package:lit/ecommerce/selection_address.dart';
import 'package:lit/ecommerce/cart_page.dart';
import 'package:lit/ecommerce/payment_page.dart';
import 'package:lit/payment/payment_success_page.dart';
import 'package:lit/payment/order_confirmation_page.dart';
import 'package:lit/payment/payment_failure_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool firebaseOk = true;
  try {
    await Firebase.initializeApp();
  } catch (e, s) {
    debugPrint('❌ Firebase.initializeApp() failed: $e');
    debugPrint('$s');
    firebaseOk = false;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => WishlistService()),
        ChangeNotifierProvider(create: (_) => CartService()),
      ],
      child: MyApp(firebaseOk: firebaseOk),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool firebaseOk;

  const MyApp({super.key, this.firebaseOk = true});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LIT Fashion',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1B0428),
        brightness: Brightness.dark,
      ),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child!,
      ),
      home: firebaseOk ? const AuthGate() : const _DebugFallbackHome(),
      routes: {
        '/home': (context) => const MainLayout(),
        '/help-and-support': (context) => const HelpAndSupportPage(),
        '/profile': (context) => const ProfilePage(),
        '/newsletter': (context) => const NewsletterPage(),
        '/coming-soon': (context) => const ComingSoonPage(),
        '/friend-list': (context) => const FriendListPage(),
        '/saved': (context) => const SavedItemPage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/marketplace': (context) => const SustainableLuxuryPage(),
        '/marketplace/sustainable': (context) => const SustainableStorePage(),
        '/marketplace/luxury': (context) => const LuxuryStorePage(),
        '/category': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return CategoryPage(
            title: args['title'] ?? 'Category',
            categoryKey: args['categoryKey'] ?? 'shop all',
            type: args['type'] ?? 'sustainable',
            gender: args['gender'] ?? 'men',
          );
        },
        '/game-category': (context) => const GameCategoryPage(),
        '/game': (context) => const GamePage(),
        '/game-leaderboard': (context) => const GameLeaderboardPage(),
        '/game-modes': (context) => const GameModesPage(),
        '/game-entrance': (context) => const GameEntrancePage(),
        '/game-shop': (context) => const ShopPage(),
        '/ir_icon': (context) => const IrIconPage(),
        '/settings': (context) => const SettingsPage(),
        '/accountSettings': (context) => const AccountSettingsPage(),
        '/privacyControlSettings': (context) => const PrivacySettingsPage(),
        '/languageCountrySettings': (context) => const LanguageSettingsPage(),
        '/notificationSettings': (context) => const NotificationSettingsPage(),
        '/subscriptionSettings': (context) => const SubscriptionSettingsPage(),
        '/orderPreferencesSettings': (context) => const OrderPreferencesSettingsPage(),
        '/returnCancellationSettings': (context) => const ReturnCancellationSettingsPage(),
        '/supportLegalSettings': (context) => const SupportLegalSettingsPage(),
        '/payment-methods': (context) => const PaymentMethodsPage(),
        '/subscription-plan-details': (context) => const SubscriptionPlanPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/billing-history': (context) => const BillingHistoryPage(),
        '/shipping-address': (context) => const ShippingAddressPage(),
        '/ecommerce/payment_page': (context) => const PaymentPage(),
        '/cart': (context) {
          final cartItems = ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>;
          return CartPage(cartItems: cartItems);
        },
        '/payment-gateway': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final cartItems = (args is List<Map<String, dynamic>>) ? args : <Map<String, dynamic>>[];
          return PaymentGatewayPage(cartItems: cartItems);
        },
        '/payment-success': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          String? orderId;
          if (args is Map && args['orderId'] is String) {
            orderId = args['orderId'];
          }
          return PaymentSuccessPage(orderId: orderId);
        },
        '/order-confirmation': (context) => const OrderConfirmationPage(),
        '/payment-failure': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          List<Map<String, dynamic>> cartItems = const [];
          if (args is Map && args['cartItems'] is List) {
            cartItems = (args['cartItems'] as List).cast<Map<String, dynamic>>();
          }
          return PaymentFailurePage(cartItems: cartItems);
        },
      },
    );
  }
}

/// ✅ AuthGate: Shows Home if logged in, SignIn if not
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const MainLayout();
        } else {
          return const SignInPage();
        }
      },
    );
  }
}

class _DebugFallbackHome extends StatelessWidget {
  const _DebugFallbackHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Text(
          '⚠️ App started (Firebase init failed)\nCheck logs for details.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
