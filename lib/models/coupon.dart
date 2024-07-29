/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class Coupon {
  final String id;
  final String couponCode;
  final int couponQty;
  final DateTime expiry;
  final int status;
  final int expiryStatus;
  final String discountType;
  final String cartValue;
  final String description;
  final String? amount;
  final String? percentage;
  final String storeType;

  Coupon({
    required this.id,
    required this.couponCode,
    required this.couponQty,
    required this.expiry,
    required this.status,
    required this.expiryStatus,
    required this.discountType,
    required this.cartValue,
    required this.description,
    this.amount,
    this.percentage,
    required this.storeType,
  });

  factory Coupon.fromRes(Map<String, dynamic> json) {
    return Coupon(
      id: json['_id'],
      couponCode: json['coupon_code'] ?? '',
      couponQty: json['coupon_qty'] ?? 1,
      expiry: DateTime.fromMillisecondsSinceEpoch(json['expiry'] * 1000),
      status: json['status'] ?? 1,
      expiryStatus: json['expiry_status'] ?? 1,
      discountType: json['discount_type'] ?? '',
      cartValue: json['cart_value'] ?? '0',
      description: json['description'] ?? '',
      amount: json['amount'],
      percentage: json['percentage'],
      storeType: json['store_type'] ?? '',
    );
  }
}
