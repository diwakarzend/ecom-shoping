/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class SurveyQuestionData {
  final dynamic answer;
  final List<String> option;

  SurveyQuestionData({
    required this.answer,
    required this.option,
  });

  factory SurveyQuestionData.fromRes(Map<String, dynamic> json) {
    return SurveyQuestionData(
      answer: json['answer'],
      option: json['option'] != null ? List<String>.from(json['option'].map((x) => x ?? '')) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'option': option,
    };
  }
}
