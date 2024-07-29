/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class SubCategory {
  final String id;
  final String categoryId;
  final String name;
  final String discription;
  final String sort;
  final int status;
  final String userId;
  final String parentId;
  final DateTime created;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.discription,
    required this.sort,
    required this.status,
    required this.userId,
    required this.parentId,
    required this.created,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'],
      categoryId: json['category_id'],
      name: json['name'],
      discription: json['discription'] ?? '',
      sort: json['sort'],
      status: json['status'],
      userId: json['user_id'],
      parentId: json['parent_id'],
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'category_id': categoryId,
      'name': name,
      'discription': discription,
      'sort': sort,
      'status': status,
      'user_id': userId,
      'parent_id': parentId,
      'created': created.millisecondsSinceEpoch,
    };
  }
}
