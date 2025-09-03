import 'package:flutter/material.dart';
import 'package:lit/pages/notifications_page.dart';
import 'screens/main_layout.dart';
import 'package:lit/screens/home/home_page.dart';
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
import 'pages/ir_icon_page.dart';
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
import 'payment/payment_gateway_page.dart';
import 'pages/game_entrance_page.dart';
import 'pages/shop_page.dart';
import 'pages/friend_list_page.dart';
import 'package:lit/providers/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:lit/pages/coming_soon.dart';
import 'package:lit/ecommerce/billing_history.dart';
import 'package:lit/ecommerce/selection_address.dart';
import 'package:lit/ecommerce/cart_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LIT Fashion',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFF1B0428),
        brightness: Brightness.dark,
      ),
      home: const MainLayout(),

      routes: {
        '/home': (context) => const MainLayout(),

        // ✅ Added this line for /login
        '/login': (context) => const SignInPage(),

        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/ir_icon': (context) => const IrIconPage(),
        '/profile': (context) => const ProfilePage(),
        '/newsletter': (context) => const NewsletterPage(),
        '/marketplace': (context) => const SustainableLuxuryPage(),
        '/marketplace/sustainable': (context) => const SustainableStorePage(),
        '/marketplace/luxury': (context) => const LuxuryStorePage(),
        '/category': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return CategoryPage(
            title: args['title'] ?? 'Category',
            categoryKey: args['categoryKey'] ?? 'shop all',
            type: args['type'] ?? 'sustainable',
            gender: args['gender'] ?? 'men',
          );
        },
        '/game-category': (context) => const GameCategoryPage(),
        '/ir-icon': (context) => const IrIconPage(),
        '/game': (context) => const GamePage(),
        '/game-leaderboard': (context) => const GameLeaderboardPage(),
        '/game-modes': (context) => const GameModesPage(),
        '/settings': (context) => const SettingsPage(),
        '/accountSettings': (context) => const AccountSettingsPage(),
        '/privacyControlSettings': (context) => const PrivacySettingsPage(),
        '/languageCountrySettings': (context) => const LanguageSettingsPage(),
        '/notificationSettings': (context) => const NotificationSettingsPage(),
        '/subscriptionSettings': (context) => const SubscriptionSettingsPage(),
        '/orderPreferencesSettings': (context) =>
            const OrderPreferencesSettingsPage(),
        '/returnCancellationSettings': (context) =>
            const ReturnCancellationSettingsPage(),
        '/supportLegalSettings': (context) => const SupportLegalSettingsPage(),
        '/payment-methods': (context) => const PaymentMethodsPage(),
        '/subscription-plan-details': (context) => const SubscriptionPlanPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/payment-gateway': (context) => const PaymentGatewayPage(),
        '/game-entrance': (context) => const GameEntrancePage(),
        '/game-shop': (context) => const ShopPage(),
        '/friend-list': (context) => const FriendListPage(),
        '/coming-soon': (context) => const ComingSoonPage(),
        '/billing-history': (context) => const BillingHistoryPage(),
        '/shipping-address': (context) => const ShippingAddressPage(),
        '/cart': (context) {
          final cartItems =
              ModalRoute.of(context)!.settings.arguments
                  as List<Map<String, dynamic>>;
          return CartPage(cartItems: cartItems);
        },
      },
    );
  }
}
