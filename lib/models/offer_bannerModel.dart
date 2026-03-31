class NivoSliderModel {
  final String pictureUrl;
  final String text;
  final String link;

  NivoSliderModel({
    required this.pictureUrl,
    required this.text,
    required this.link,
  });

  factory NivoSliderModel.fromJson(Map<String, dynamic> json) {
    return NivoSliderModel(
      pictureUrl: json['PictureUrl'] ?? '',
      text: json['Text'] ?? '',
      link: json['Link'] ?? '',
    );
  }
}

class NivoSliderResponse {
  final List<NivoSliderModel> gallery;
  final int messageCode;
  final String messageText;

  NivoSliderResponse({
    required this.gallery,
    required this.messageCode,
    required this.messageText,
  });

  factory NivoSliderResponse.fromJson(Map<String, dynamic> json) {
    return NivoSliderResponse(
      gallery: (json['gallery'] as List<dynamic>? ?? [])
          .map<NivoSliderModel>((item) => NivoSliderModel.fromJson(item))
          .toList(),
      messageCode: json['messageCode'] ?? 0,
      messageText: json['messageText'] ?? '',
    );
  }
}