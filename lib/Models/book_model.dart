// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:kbook_rafaelbanhos/Models/sale_model.dart';
import 'package:kbook_rafaelbanhos/Models/volume_model.dart';

class BookModel {
  final String id;
  VolumeModel volumeModel;
  SaleModel saleModel;

  BookModel(
      {@required this.id,
      @required this.volumeModel,
      @required this.saleModel});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json["id"],
      volumeModel: json['volumeInfo'] != null
          ? VolumeModel.fromJson(json['volumeInfo'])
          : null,
      saleModel: json['saleInfo'] != null
          ? SaleModel.fromJson(json['saleInfo'])
          : null,
    );
  }

  hasVolumeInfo() {
    return volumeModel != null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "volumeInfo": volumeModel.toJson(),
      "saleInfo": saleModel.toJson()
    };
  }
}
