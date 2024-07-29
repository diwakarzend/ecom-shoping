/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class SurveyAnswer {
  final String id;
  dynamic answer;
  bool required;
  bool qualified;
  bool validated;
  bool error;

  SurveyAnswer({
    required this.id,
    this.answer,
    required this.required,
    required this.qualified,
    required this.validated,
    required this.error,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer': answer,
    };
  }
}
