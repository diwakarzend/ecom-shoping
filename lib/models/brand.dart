/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class Brand {
  final String id;
  final String name;
  final String description;
  final String logo;
  final String banner;
  final int sort;
  final int status;
  final String userId;
  final String parentId;
  final DateTime created;

  Brand({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.banner,
    required this.sort,
    required this.status,
    required this.userId,
    required this.parentId,
    required this.created,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['_id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      banner: json['banner'] ?? '',
      sort: json['sort'] ?? '',
      status: json['status'] ?? '',
      userId: json['user_id'] ?? '',
      parentId: json['parent_id'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'logo': logo,
      'banner': banner,
      'sort': sort,
      'status': status,
      'user_id': userId,
      'parent_id': parentId,
      'created': created.millisecondsSinceEpoch,
    };
  }
}
