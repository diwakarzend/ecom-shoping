/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/models/models.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;
  final String gender;
  final String? married;
  final String? haveKids;
  final int? numberOfKids;
  final String? firstKidAge;
  final String? firstKidGender;
  final String? secondKidAge;
  final String? secondKidGender;
  final String? thirdKidAge;
  final String? thirdKidGender;
  final String age;
  final String city;
  final String state;
  final String pincode;
  final List<String> interests;
  final String referCode;
  final String? emailKey;
  final String? playerKey;
  final String? smsKey;
  int trialPoint;
  int rewardPoint;
  final String role;
  final String? image;
  final List<Order> orders;
  final List<Shipping> shipping;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNo,
    required this.gender,
    required this.married,
    required this.haveKids,
    this.numberOfKids,
    this.firstKidAge,
    this.firstKidGender,
    this.secondKidAge,
    this.secondKidGender,
    this.thirdKidAge,
    this.thirdKidGender,
    required this.age,
    required this.city,
    required this.state,
    required this.pincode,
    required this.interests,
    required this.referCode,
    this.emailKey,
    this.playerKey,
    this.smsKey,
    required this.trialPoint,
    required this.rewardPoint,
    required this.role,
    this.image,
    required this.orders,
    required this.shipping,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobile_no'] != null ? json['mobile_no'].toString() : '',
      gender: json['gender'] ?? '',
      married: json['married'],
      haveKids: json['have_kids'],
      numberOfKids: json['number_of_kids'],
      firstKidAge: json['first_kid_age'],
      firstKidGender: json['first_kid_gender'],
      secondKidAge: json['second_kid_age'],
      secondKidGender: json['second_kid_gender'],
      thirdKidAge: json['third_kid_age'],
      thirdKidGender: json['third_kid_gender'],
      age: json['age'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      pincode: json['pincode'] ?? '',
      interests: json['interests'] != null && json['interests'].runtimeType != String ? List<String>.from(json['interests'].map((x) => x)) : [],
      referCode: json['refer_code'] ?? '',
      emailKey: json['email_key'],
      playerKey: json['player_key'],
      smsKey: json['sms_key'],
      trialPoint: json['trail_point'] ?? 0,
      rewardPoint: json['reward_point'] ?? 0,
      role: json['role'] ?? '',
      image: json['image'],
      orders: json['orders'] != null ? List<Order>.from(json['orders'].map((x) => Order.fromJson(x))) : [],
      shipping: json['shipping'] != null ? List<Shipping>.from(json['shipping'].map((x) => Shipping.fromJson(x))) : [],
    );
  }
}
