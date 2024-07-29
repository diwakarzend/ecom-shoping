/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/models/models.dart';

class SurveyReport {
  final String id;
  final String surveyId;
  final String userId;
  final String? productId;
  final String? brandId;
  final int totalQuestions;
  final int totalPoints;
  final int pointsEarned;
  final bool qualified;
  final bool rejected;
  final String answerFor;
  final List<QuestionAndAnswer> questionAnswers;
  final Product? product;

  SurveyReport({
    required this.id,
    required this.surveyId,
    required this.userId,
    this.productId,
    this.brandId,
    required this.totalQuestions,
    required this.totalPoints,
    required this.pointsEarned,
    required this.qualified,
    required this.questionAnswers,
    required this.rejected,
    required this.answerFor,
    this.product,
  });

  factory SurveyReport.fromJson(Map<String, dynamic> json) {
    return SurveyReport(
      id: json['_id'],
      surveyId: json['survay_id'],
      userId: json['user_id'],
      productId: json['product_id'],
      brandId: json['brand_id'],
      totalQuestions: json['total_questions'],
      totalPoints: json['total_points'],
      pointsEarned: json['points_earned'],
      qualified: json['qualified'] == 1 ? true : false,
      rejected: json['rejected'] != null && json['rejected'] == 1 ? true : false,
      questionAnswers: List<QuestionAndAnswer>.from(json['question_answers'].map((x) => QuestionAndAnswer.fromJson(x))),
      answerFor: json['answer_for'] ?? '',
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'survey_id': surveyId,
      'user_id': userId,
      'product_id': productId,
      'brand_id': brandId,
      'total_questions': totalQuestions,
      'total_points': totalPoints,
      'points_earned': pointsEarned,
      'qualified': qualified ? 1 : 0,
      'rejected': rejected ? 1 : 0,
      'question_answers': List<Map<String, dynamic>>.from(questionAnswers.map((e) => e.toJson())),
      'answer_for': answerFor,
    };
  }
}

class QuestionAndAnswer {
  final String question;
  final dynamic answer;

  QuestionAndAnswer({
    required this.question,
    this.answer,
  });

  factory QuestionAndAnswer.fromJson(Map<String, dynamic> json) {
    return QuestionAndAnswer(
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
