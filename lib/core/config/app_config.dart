class AppConfig {
  // 🔒 Private constructor — no instantiation
  AppConfig._();

  // ✅ Base URL
  static const String baseUrl = 'http://40.123.209.144:96';

  // ✅ API Secret Key
  static const String apiSecretKey = 'a112i122f120g111a97l105m111t114';
  /// const apiKey = "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"; // 🔴 replace this

  // ✅ Store ID
  static const int storeId = 1;

  // ✅ Customer ID
  static const int customerId = 4341133;

  //  ✅ Currency ID
  static const int currencyId = 1;

  //  ✅ Language ID
  static const int  languageId = 1;

  // ✅ Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}