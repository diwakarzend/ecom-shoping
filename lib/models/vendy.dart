/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

class Vendy {
  final List<VendyCity> cities;
  final List<String> images;

  Vendy({
    required this.cities,
    required this.images,
  });

  factory Vendy.fromJson(Map<String, dynamic> json) {
    return Vendy(
      cities: List<VendyCity>.from(json['city'].map((x) => VendyCity.fromJson(x))),
      images: List<String>.from(json['images'].map((x) => x)),
    );
  }
}

class VendyCity {
  final String city;
  final List<VendyCityAddress> address;

  VendyCity({
    required this.city,
    required this.address,
  });

  factory VendyCity.fromJson(Map<String, dynamic> json) {
    return VendyCity(
      city: json['city'],
      address: List<VendyCityAddress>.from(json['address'].map((x) => VendyCityAddress.fromJson(x))),
    );
  }
}

class VendyCityAddress {
  final String landmark;
  final String address;

  VendyCityAddress({
    required this.landmark,
    required this.address,
  });

  factory VendyCityAddress.fromJson(Map<String, dynamic> json) {
    return VendyCityAddress(
      landmark: json['landmark'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
