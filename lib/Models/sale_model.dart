// Flutter imports:
import 'package:flutter/cupertino.dart';

class SaleModel {
  String country;
  String buyLink;

  SaleModel({@required this.country, @required this.buyLink});

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      country: json["country"],
      buyLink: json["buyLink"],
    );
  }

  hasBuyLink() {
    return buyLink != null && buyLink.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      "country": country,
      "buyLink": buyLink,
    };
  }
}
