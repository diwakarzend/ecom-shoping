/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */
class SubAttribute {
  final String id;
  final String attributeId;
  final String name;
  final int sort;
  final int status;
  final String userId;
  final String parentId;
  final DateTime created;

  SubAttribute({
    required this.id,
    required this.attributeId,
    required this.name,
    required this.sort,
    required this.status,
    required this.userId,
    required this.parentId,
    required this.created,
  });

  factory SubAttribute.fromJson(Map<String, dynamic> json) {
    return SubAttribute(
      id: json['_id'],
      attributeId: json['attribute_id'],
      name: json['name'],
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
      'attribute_id': attributeId,
      'name': name,
      'sort': sort,
      'status': status,
      'user_id': userId,
      'parent_id': parentId,
      'created': created.millisecondsSinceEpoch,
    };
  }
}
