class AppConfig {
  // 🔒 Private constructor — no instantiation
  AppConfig._();

  // ✅ Base URL
  static const String baseUrl = 'http://40.123.209.144:96';

  // ✅ API Secret Key
  static const String apiSecretKey = 'a112i122f120g111a97l105m111t114';


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