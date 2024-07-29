/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/models/models.dart';

class Survey {
  final String id;
  final String title;
  final String type;
  final String description;
  final String userId;
  final String parentId;
  final String? topicId;
  final String? brandId;
  final DateTime created;
  final List<SurveyQuestion> questions;

  Survey({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.userId,
    required this.parentId,
    required this.created,
    required this.questions,
    this.topicId,
    this.brandId,
  });

  factory Survey.fromRes(Map<String, dynamic> json) {
    return Survey(
      id: json['_id'],
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      userId: json['user_id'] ?? '',
      parentId: json['parent_id'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      questions: json['questions'] != null ? List<SurveyQuestion>.from(json['questions'].map((x) => SurveyQuestion.fromRes(x))) : [],
      topicId: json['topic_id'],
      brandId: json['brand_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'type': type,
      'description': description,
      'user_id': userId,
      'parent_id': parentId,
      'created': created.millisecondsSinceEpoch,
      'questions': List<Map<String, dynamic>>.from(questions.map((e) => e.toJson())),
      'topic_id': topicId,
      'brand_id': brandId,
    };
  }
}
