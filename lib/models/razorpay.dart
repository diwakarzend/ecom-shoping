/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class RazorpayM {
  final String id;
  final String entity;
  final int amount;
  final int amountPaid;
  final int amountDue;
  final String currency;
  final String receipt;
  final String offerId;
  final String status;
  final int attempts;
  final List notes;
  final int createdAt;

  RazorpayM({
    required this.id,
    required this.entity,
    required this.amount,
    required this.amountPaid,
    required this.amountDue,
    required this.currency,
    required this.receipt,
    required this.offerId,
    required this.status,
    required this.attempts,
    required this.notes,
    required this.createdAt,
  });

  factory RazorpayM.fromMap(Map<String, dynamic> jsonData) {
    return RazorpayM(
      id: jsonData['id'],
      entity: jsonData['entity'],
      amount: jsonData['amount'],
      amountPaid: jsonData['amount_paid'],
      amountDue: jsonData['amount_due'],
      currency: jsonData['currency'],
      receipt: jsonData['receipt'] ?? '',
      offerId: jsonData['offer_id'] ?? '',
      status: jsonData['status'],
      attempts: jsonData['attempts'],
      createdAt: jsonData['created_at'],
      notes: jsonData['notes'],
    );
  }
}
