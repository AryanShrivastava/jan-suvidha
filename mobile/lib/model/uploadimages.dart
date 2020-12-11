import 'package:meta/meta.dart';
import 'dart:convert';

UploadImage uploadImageFromJson(String str) =>
    UploadImage.fromJson(json.decode(str));

String uploadImageToJson(UploadImage data) => json.encode(data.toJson());

class UploadImage {
  UploadImage({
    @required this.success,
    @required this.url,
    @required this.message,
  });

  final bool success;
  final String url;
  final String message;

  factory UploadImage.fromJson(Map<String, dynamic> json) => UploadImage(
        success: json["success"] == null ? null : json["success"],
        url: json["url"] == null ? null : json["url"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "url": url == null ? null : url,
        "message": message == null ? null : message,
      };
}
