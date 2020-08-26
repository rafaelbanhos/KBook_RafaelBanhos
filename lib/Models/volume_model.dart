// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kbook_rafaelbanhos/Models/image_model.dart';

class VolumeModel {
  final String title;
  final String description;
  final List authors;
  final ImageModel imageLinks;

  VolumeModel(
      {@required this.title,
      @required this.description,
      @required this.authors,
      @required this.imageLinks});

  factory VolumeModel.fromJson(Map<String, dynamic> json) {
    return VolumeModel(
      title: json["title"],
      authors: json["authors"],
      description: json["description"],
      imageLinks: json["imageLinks"] != null
          ? ImageModel.fromJson(json["imageLinks"])
          : null,
    );
  }

  hasImageLinks() {
    return imageLinks != null;
  }

  hasDescription() {
    return description != null;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "authors": authors,
      "description": description,
      "imageLinks": imageLinks.toJson()
    };
  }
}
