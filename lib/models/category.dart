/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class Category {
  final String id;
  final String name;
  final String discription;
  final int sort;
  final int status;
  final String? banner;
  final String? icon;
  final String userId;
  final String parentId;
  final DateTime created;

  Category({
    required this.id,
    required this.name,
    required this.discription,
    required this.sort,
    required this.status,
    this.banner,
    this.icon,
    required this.userId,
    required this.parentId,
    required this.created,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'] ?? '',
      discription: json['discription'] ?? '',
      sort: json['sort'] ?? 99,
      status: json['status'] ?? '',
      banner: json['banner'] ?? '',
      icon: json['icon'] ?? '',
      userId: json['user_id'] ?? '',
      parentId: json['parent_id'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'discription': discription,
      'sort': sort,
      'status': status,
      'banner': banner,
      'icon': icon,
      'user_id': userId,
      'parent_id': parentId,
      'created': created.millisecondsSinceEpoch,
    };
  }
}
