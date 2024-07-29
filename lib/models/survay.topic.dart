/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class SurvayTopic {
  final String id;
  final String name;
  final String description;
  final int sort;
  final int status;
  final String logo;
  final DateTime created;

  SurvayTopic({
    required this.id,
    required this.name,
    required this.description,
    required this.sort,
    required this.status,
    required this.logo,
    required this.created,
  });

  factory SurvayTopic.fromJson(Map<String, dynamic> json) {
    return SurvayTopic(
      id: json['_id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      sort: json['sort'] ?? 0,
      status: json['status'] ?? 0,
      logo: json['logo'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
    );
  }
}
