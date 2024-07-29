/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/models/user.dart';

class Feedback {
  final String id;
  final String review;
  final double quality;
  final String remarks;
  final int status;
  final String productId;
  final String userId;
  final DateTime created;
  final User? user;
  final String? name;

  Feedback({
    required this.id,
    required this.review,
    required this.quality,
    required this.remarks,
    required this.status,
    required this.productId,
    required this.userId,
    required this.created,
    this.user,
    this.name,
  });

  factory Feedback.fromRes(Map<String, dynamic> json) {
    return Feedback(
      id: json['_id'],
      review: json['review'] ?? '',
      quality: json['quality'] != null ? json['quality'].toDouble() : 0,
      remarks: json['remarks'] ?? '',
      status: json['status'] ?? '',
      productId: json['product_id'] ?? '',
      userId: json['user_id'] != null && json['user_id'].runtimeType == String ? json['user_id'] : '',
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      name: json['name'],
    );
  }
}
