/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/models/models.dart';

class Settings {
  final String id;
  final String aboutUs;
  final String privacy;
  final String conditions;
  final String refund;
  final GeneralSettings generalSettings;
  final Maintenance maintenance;
  final SurprisedProduct surprisedProduct;
  final List<PaymentGatway> paymentGateway;

  Settings({
    required this.id,
    required this.aboutUs,
    required this.privacy,
    required this.conditions,
    required this.refund,
    required this.generalSettings,
    required this.maintenance,
    required this.surprisedProduct,
    required this.paymentGateway,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      id: json['_id'],
      aboutUs: json['aboutus'] ?? '',
      privacy: json['privacy'] ?? '',
      conditions: json['conditions'] ?? '',
      refund: json['refund'] ?? '',
      generalSettings: GeneralSettings.fromJson(json['general_setting']),
      maintenance: Maintenance.fromJson(json['maintenance']),
      surprisedProduct: SurprisedProduct.fromJson(json['surprised_product']),
      paymentGateway: List<PaymentGatway>.from(
        json['payment_gatway'].map(
          (x) => PaymentGatway.fromJson(x),
        ),
      ),
    );
  }
}

class Maintenance {
  final bool mode;
  final String msg;
  final bool showOld;

  Maintenance({
    required this.mode,
    required this.msg,
    required this.showOld,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) {
    return Maintenance(
      mode: json['mode'] == 1,
      msg: json['msg'] ?? '',
      showOld: json['show_old'] == 1,
    );
  }
}

class SurprisedProduct {
  final double cartValue;
  final String productId;
  final bool enable;

  SurprisedProduct({
    required this.cartValue,
    required this.productId,
    required this.enable,
  });

  factory SurprisedProduct.fromJson(Map<String, dynamic> json) {
    return SurprisedProduct(
      cartValue: json['cart_value'] != null ? double.parse(json['cart_value'].toString()) : 0,
      productId: json['product_id'] ?? '',
      enable: json['enable'] == '1' ? true : false,
    );
  }
}

class PaymentGatway {
  final String gatway;
  final String key1;
  final String key2;
  final int status;
  final bool isActive;

  PaymentGatway({
    required this.gatway,
    required this.key1,
    required this.key2,
    required this.status,
    required this.isActive,
  });

  factory PaymentGatway.fromJson(Map<String, dynamic> json) {
    return PaymentGatway(
      gatway: json['gatway'] ?? '',
      key1: json['key1'] ?? '',
      key2: json['key2'] ?? '',
      status: json['status'] ?? 0,
      isActive: json['status'] == 1,
    );
  }
}
