/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/models/models.dart';

class SurveyQuestion {
  final String id;
  final String survayId;
  final String survayType;
  final String survayQuestion;
  final SurveyQuestionData? data;
  final int reward;
  final bool required;

  SurveyQuestion({
    required this.id,
    required this.survayId,
    required this.survayType,
    required this.survayQuestion,
    this.data,
    required this.reward,
    required this.required,
  });

  factory SurveyQuestion.fromRes(Map<String, dynamic> json) {
    return SurveyQuestion(
      id: json['_id'],
      survayId: json['survay_id'],
      survayType: json['survay_type'],
      survayQuestion: json['survay_question'] ?? '',
      data: json['data'] != null ? SurveyQuestionData.fromRes(json['data']) : null,
      reward: json['reward'],
      required: json['required'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'survay_id': survayId,
      'survay_type': survayType,
      'survay_question': survayQuestion,
      'data': data?.toJson(),
      'reward': reward,
      'required': required ? 1 : 0,
    };
  }
}
