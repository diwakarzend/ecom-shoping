/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/models/models.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final int size;
  final String productType;
  final int trialPoint;
  final int salePrice;
  final int rewardsPoint;
  final Category? category;
  final String brandId;
  final String? noFeedback;
  final String? preQulifingQuestion;
  final int mrp;
  final int offerPrice;
  final int maximumQty;
  final DateTime expireDate;
  final String image;
  final List<String> images;
  final String userId;
  final String parentId;
  final DateTime created;
  final Brand? brand;
  final Survey? pSurvey;
  final List<ProductDetails> details;
  int review;
  final List<String> tags;
  final String? sku;
  final int serviceCharge;
  final int dislike;
  int like;
  final String? videoLink;
  final String? videoThumbnail;
  final RetargetProduct? retargetProduct;
  final int sort;
  final int stock;
  final String sub_category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.size,
    required this.productType,
    required this.trialPoint,
    required this.salePrice,
    required this.rewardsPoint,
    // required this.subCategory,
    this.category,
    required this.brandId,
    this.noFeedback,
    this.preQulifingQuestion,
    required this.mrp,
    required this.offerPrice,
    required this.maximumQty,
    required this.expireDate,
    required this.image,
    required this.images,
    required this.userId,
    required this.parentId,
    required this.created,
    this.brand,
    this.pSurvey,
    required this.details,
    required this.review,
    required this.tags,
    this.sku,
    required this.serviceCharge,
    required this.dislike,
    required this.like,
    this.videoLink,
    this.videoThumbnail,
    this.retargetProduct,
    required this.sort,
    required this.stock,
    required this.sub_category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      size: json['size'] ?? '',
      productType: json['product_type'] ?? '',
      trialPoint: json['trial_point'] ?? '',
      salePrice: json['sale_price'] ?? '',
      rewardsPoint: json['rewards_point'] ?? '',
      // subCategory: SubCategory.fromJson(json['sub_category']),
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      brandId: json['brand_id'] ?? '',
      mrp: json['mrp'],
      offerPrice: json['offer_price'],
      maximumQty: json['maximum_qty'],
      expireDate: DateTime.fromMillisecondsSinceEpoch(json['expire_date'] * 1000),
      image: json['image'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images'].map((x) => x)) : [],
      userId: json['user_id'] ?? '',
      parentId: json['parent_id'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(json['created'] * 1000),
      brand: json['brand'] != null ? Brand.fromJson(json['brand']) : null,
      pSurvey: json['p_survey'] != null ? Survey.fromRes(json['p_survey']) : null,
      details: List<ProductDetails>.from(json['details'].map((x) => ProductDetails.fromJson(x))),
      review: json['review'] ?? 0,
      tags: json['tags'] != null && json['tags'].toString().contains(',') && json['tags'].runtimeType == String ? json['tags'].split(',') : [],
      sku: json['sku'] ?? '',
      serviceCharge: json['service_charge'] ?? 0,
      dislike: json['dislike'] ?? 0,
      like: json['like'] ?? 0,
      videoLink: json['video_link'],
      videoThumbnail: json['video_thumbnail'],
      retargetProduct: json['retarget_product'] != null ? RetargetProduct.fromJson(json['retarget_product']) : null,
      sort: json['new_sort'] ?? 10000000000000000,
      stock: json['stock'] ?? 0,
      sub_category: json['sub_category'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'size': size,
      'product_type': productType,
      'trial_point': trialPoint,
      'sale_price': salePrice,
      'rewards_point': rewardsPoint,
      // 'sub_category': subCategory.toJson(),
      'category': category?.toJson(),
      'brand_id': brandId,
      'mrp': mrp,
      'offer_price': offerPrice,
      'maximum_qty': maximumQty,
      'expire_date': expireDate.millisecondsSinceEpoch,
      'image': image,
      'images': images,
      'user_id': userId,
      'parent_id': parentId,
      'created': created.millisecondsSinceEpoch,
      'brand': brand?.toJson(),
      'p_survey': pSurvey?.toJson(),
      'details': List<Map<String, dynamic>>.from(details.map((e) => e.toJson())),
      'review': review,
      'sku': sku,
      'tags': tags,
      'service_charge': serviceCharge,
      'dislike': dislike,
      'like': like,
      'video_link': videoLink,
      'video_thumbnail': videoThumbnail,
      'new_sort': sort,
      'stock': stock,
    };
  }

// AnalyticsEventItem toGAP() {
//   return AnalyticsEventItem(
//     itemId: id,
//     itemName: name,
//     itemBrand: brand?.name,
//     itemCategory: category?.name ?? '',
//     currency: 'INR',
//     price: productType == StringConstants.hotDealProduct || productType == StringConstants.brandStoreProduct ? salePrice.toDouble() : 0.00,
//   );
// }
}

class RetargetProduct {
  final String type;
  final String? productId;
  final String? productLink;

  RetargetProduct({
    required this.type,
    this.productId,
    this.productLink,
  });

  factory RetargetProduct.fromJson(Map<String, dynamic> json) {
    return RetargetProduct(
      type: json['type'],
      productId: json['product_id'],
      productLink: json['product_link'],
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'product_id': productId,
    'product_link': productLink,
  };
}