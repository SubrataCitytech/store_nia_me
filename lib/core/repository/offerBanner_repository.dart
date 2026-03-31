// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../../models/offer_bannerModel.dart';
// import '../api/api_endpoints.dart';
// import '../config/app_config.dart';
//
// class OfferbannerRepository {
//   Future<NivoSliderResponse> fetchNivoSlider() async {
//     final response = await http.post(
//       Uri.parse(ApiEndpoints.nivoSlider),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         "StoreId": AppConfig.storeId,
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       return NivoSliderResponse.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to load nivo slider: ${response.statusCode}');
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/offer_bannerModel.dart';
import '../api/api_endpoints.dart';
import '../config/app_config.dart';

class OfferbannerRepository {
  Future<NivoSliderResponse> fetchNivoSlider() async {
    final response = await http.post(
      Uri.parse(ApiEndpoints.nivoSlider), // ✅ now has full URL
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "StoreId": AppConfig.storeId,
      }),
    );

    if (response.statusCode == 200) {
      return NivoSliderResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load nivo slider: ${response.statusCode}');
    }
  }
}