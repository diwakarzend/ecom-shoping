/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class Banner {
  final String id;
  final String name;
  final String type;
  final int status;
  final String banner;
  final String deviceType;

  Banner({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.banner,
    required this.deviceType, required bannerurl,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      status: json['status'] ?? '',
      banner: json['banner'] != null ? json['banner'].toString().replaceAll(' ', '%20') : '',
      deviceType: json['device_type'] ?? 'mobile',
      bannerurl: json['url']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'type': type,
      'status': status,
      'banner': banner,
    };
  }
}
