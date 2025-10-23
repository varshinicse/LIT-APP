import 'package:flutter/material.dart';
import 'package:lit/pages/notifications_page.dart';
import 'screens/main_layout.dart';
// duplicate import removed
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
import 'pages/saved_item_page.dart';
import 'settings/subscription_plan_details_page.dart';
// removed duplicate import of notifications_page.dart above
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
import 'package:lit/ecommerce/payment_page.dart';
import 'package:lit/ecommerce/buy_now_page.dart';
import 'package:lit/payment/payment_success_page.dart';
import 'package:lit/payment/order_confirmation_page.dart';
import 'package:lit/payment/payment_failure_page.dart';
void main() {
  // Enable performance optimizations
  WidgetsFlutterBinding.ensureInitialized();
  
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
      // Performance optimizations
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: const MainLayout(),

      routes: {
        '/home': (context) => const MainLayout(),
        '/saved': (context) => const SavedItemPage(),
        '/ir_icon': (context) => const IrIconPage(),
        '/profile': (context) => const ProfilePage(),
        '/newsletter': (context) => const NewsletterPage(),
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

        '/buy-now': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          Map<String, dynamic> item = const {};
          if (args is Map<String, dynamic>) {
            item = args;
          } else if (args is Map) {
            item = Map<String, dynamic>.from(args as Map);
          }
          return BuyNowPage(item: item);
        },


        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/game-category': (context) => const GameCategoryPage(),
        '/ir-icon': (context) => const IrIconPage(),
        '/scan': (context) => const IrIconPage(),
        '/game': (context) => const GamePage(),
        '/game-leaderboard': (context) => const GameLeaderboardPage(),
        '/game-modes': (context) => const GameModesPage(),
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
        '/payment-gateway': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final cartItems = (args is List<Map<String, dynamic>>) ? args : <Map<String, dynamic>>[];
          return PaymentGatewayPage(cartItems: cartItems);
        },
        '/game-entrance': (context) => const GameEntrancePage(),
        '/game-shop': (context) => const ShopPage(),
        '/friend-list': (context) => const FriendListPage(),
        '/save-products': (context) => const SavedItemPage(),
        '/coming-soon': (context) => const ComingSoonPage(),
        '/billing-history': (context) => const BillingHistoryPage(),
        '/shipping-address': (context) => const ShippingAddressPage(),
        '/ecommerce/payment_page': (context) => const PaymentPage(),
        '/cart': (context) {
          final cartItems = ModalRoute.of(context)!.settings.arguments as List<Map<String, dynamic>>;
          return CartPage(cartItems: cartItems);
        },

        '/payment-success': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          String? orderId;
          if (args is Map) {
            final raw = args['orderId'];
            if (raw is String) orderId = raw;
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
