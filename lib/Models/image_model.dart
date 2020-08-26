// Flutter imports:
import 'package:flutter/material.dart';

class ImageModel {
  final String smallThumbnail;
  final String thumbnail;

  ImageModel({@required this.smallThumbnail, @required this.thumbnail});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      smallThumbnail: json["smallThumbnail"] ?? null,
      thumbnail: json["thumbnail"] ?? null,
    );
  }

  Map<String, dynamic> toJson() {
    return {"smallThumbnail": smallThumbnail, "thumbnail": thumbnail};
  }
}
