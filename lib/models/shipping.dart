/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class Shipping {
  final String id;
  final String shippingName;
  final String shippingLandmark;
  final String shippingPhone;
  final String shippingCity;
  final String shippingState;
  final String shippingAddress;
  final String shippingPincode;
  final String shippingAlternatePhone;
  final String billingName;
  final String billingLandmark;
  final String billingPhone;
  final String billingCity;
  final String billingState;
  final String billingAddress;
  final String billingPincode;
  final String billingAlternatePhone;
  final String billingSame;
  final DateTime created;
  bool selected;

  Shipping({
    required this.id,
    required this.shippingName,
    required this.shippingLandmark,
    required this.shippingPhone,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingAddress,
    required this.shippingPincode,
    required this.shippingAlternatePhone,
    required this.billingName,
    required this.billingLandmark,
    required this.billingPhone,
    required this.billingCity,
    required this.billingState,
    required this.billingAddress,
    required this.billingPincode,
    required this.billingAlternatePhone,
    required this.billingSame,
    required this.created,
    required this.selected,
  });

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      id: json['_id'] ?? '',
      shippingName: json['shipping_name'] ?? '',
      shippingLandmark: json['shipping_landmark'] ?? '',
      shippingPhone: json['shipping_phone'] ?? '',
      shippingCity: json['shipping_city'] ?? '',
      shippingState: json['shipping_state'] ?? '',
      shippingAddress: json['shipping_address'] ?? '',
      shippingPincode: json['shipping_pincode'] ?? '',
      shippingAlternatePhone: json['shipping_alternate_phone'] ?? '',
      billingName: json['billing_name'] ?? '',
      billingLandmark: json['billing_landmark'] ?? '',
      billingPhone: json['billing_phone'] ?? '',
      billingCity: json['billing_city'] ?? '',
      billingState: json['billing_state'] ?? '',
      billingAddress: json['billing_address'] ?? '',
      billingPincode: json['billing_pincode'] ?? '',
      billingAlternatePhone: json['billing_alternate_phone'] ?? '',
      billingSame: json['billing_same'].toString(),
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      selected: json['selected'] ?? false,
    );
  }
}
