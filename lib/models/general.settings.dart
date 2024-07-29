/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class GeneralSettings {
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final String companyLogo;
  final String companyAddress;
  final int samplesLimit;
  final String razorpayId;
  final String razorpaySecret;
  final String androidVersion;
  final String iosVersion;
  final int itemQty;
  final int addonQty;
  final double addonUnitPrice;
  final int miniCharge;
  final int codCharge;
  final String? webAppUrl;

  GeneralSettings({
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.companyLogo,
    required this.companyAddress,
    required this.samplesLimit,
    required this.razorpayId,
    required this.razorpaySecret,
    required this.androidVersion,
    required this.iosVersion,
    required this.itemQty,
    required this.addonQty,
    required this.addonUnitPrice,
    required this.miniCharge,
    required this.codCharge,
    this.webAppUrl,
  });

  factory GeneralSettings.fromJson(Map<String, dynamic> json) {
    return GeneralSettings(
      companyName: json['company_name'] ?? '',
      companyEmail: json['company_email'] ?? '',
      companyPhone: json['company_phone'] ?? '',
      companyLogo: json['company_logo'] ?? '',
      companyAddress: json['company_address'] ?? '',
      samplesLimit: json['sample_limit'] != null && json['sample_limit'].runtimeType == int
          ? json['sample_limit']
          : json['sample_limit'] != null && json['sample_limit'].runtimeType == String
              ? int.parse(json['sample_limit'])
              : 2,
      razorpayId: json['razorpay_id'] ?? '',
      razorpaySecret: json['razorpay_secret'] ?? '',
      androidVersion: json['android_version'] ?? '',
      iosVersion: json['ios_version'] ?? '',
      itemQty: int.tryParse(json['item_qty']) ?? 0,
      addonQty: int.tryParse(json['addon_qty']) ?? 0,
      addonUnitPrice: double.tryParse(json['addon_unit_price']) ?? 0,
      miniCharge: json['mini_charge'] ?? '',
      codCharge: json['cod_charge'] ?? '',
      webAppUrl: json['web_app_url'],
    );
  }
}
