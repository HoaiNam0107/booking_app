class StorageKeys {
  StorageKeys._();

  // Secure Storage Keys (sensitive data)
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';

  // SharedPreferences Keys (non-sensitive)
  static const String isFirstLaunch = 'is_first_launch';
  static const String languageCode = 'language_code';
  static const String themeMode = 'theme_mode';
  static const String userEmail = 'user_email';
  static const String fcmToken = 'fcm_token';
}