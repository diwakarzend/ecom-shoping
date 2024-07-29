/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class FAQ {
  final String id;
  final String question;
  final String answer;
  bool expanded;

  FAQ({
    required this.id,
    required this.question,
    required this.answer,
    this.expanded = false,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      id: json['_id'],
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
    );
  }
}
