class AppConstants {
  AppConstants._();

  // App info
  static const String appName = 'Booking App';
  static const String appVersion = '1.0.0';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String restaurantsCollection = 'restaurants';
  static const String ordersCollection = 'orders';
  static const String menuItemsCollection = 'menu_items';
  static const String categoriesCollection = 'categories';
  static const String reviewsCollection = 'reviews';

  // Firebase Storage paths
  static const String userAvatarsPath = 'avatars/users';
  static const String restaurantImagesPath = 'images/restaurants';
  static const String menuItemImagesPath = 'images/menu_items';

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;

  // Timeouts
  static const int connectTimeoutMs = 30000;
  static const int receiveTimeoutMs = 30000;
  static const int sendTimeoutMs = 30000;
}