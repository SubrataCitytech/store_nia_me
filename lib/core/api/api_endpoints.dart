import '../config/app_config.dart';

class ApiEndpoints {
  ApiEndpoints._();
  /// ✅ Helper — build full URL
  static String fullUrl(String endpoint) => '${AppConfig.baseUrl}$endpoint';

  /// ✅ Banner
  static const String nivoSlider = '/api/client/NivoSlider';

  /// ✅ Categories
  static const String categories = '/api/client/TopMenu';

  /// ✅ Products
  static const String mostInterested = '/api/client/HomePageProducts';
  static const String popular = '/api/client/BestSellers';
  static const String productSearch = '/api/client/ProductSearch';

  /// ✅ Helper — build full URL
  // static String fullUrl(String endpoint) => '${AppConfig.baseUrl}$endpoint';
}
