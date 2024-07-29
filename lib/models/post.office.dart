/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class PostOffice {
  final String name;
  final String? description;
  final String branchType;
  final String deliveryStatus;
  final String circle;
  final String district;
  final String division;
  final String block;
  final String state;
  final String country;
  final String pincode;

  PostOffice({
    required this.name,
    required this.description,
    required this.branchType,
    required this.deliveryStatus,
    required this.circle,
    required this.district,
    required this.division,
    required this.block,
    required this.state,
    required this.country,
    required this.pincode,
  });

  factory PostOffice.fromJson(Map<String, dynamic> json) {
    return PostOffice(
      name: json['Name'] ?? '',
      description: json['Description'] ?? '',
      branchType: json['BranchType'] ?? '',
      deliveryStatus: json['DeliveryStatus'] ?? '',
      circle: json['Circle'] ?? '',
      district: json['District'] ?? '',
      division: json['Division'] ?? '',
      block: json['Block'] ?? '',
      state: json['State'] ?? '',
      country: json['Country'] ?? '',
      pincode: json['Pincode'] ?? '',
    );
  }
}
