/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

import 'models.dart';

class Order {
  final String id;
  final dynamic orderNumber;
  final DateTime orderDate;
  final String paymentMode;
  final num shippingCost;
  final num serviceCharge;
  final num codCharge;
  final num addonUnitPrice;
  final num hotDealsTotal;
  final num addonQuantity;
  final num bounsServiceCharge;
  final num miniItemQuantity;
  final num miniCharge;
  final num subTotal;
  final num subTotalWithoutDiscount;
  final num discount;
  final num taxAmount;
  final num grandTotal;
  final String status;
  final String orderStatus;
  final OrderShippingAddress shippingDetails;
  final int surprisedProduct;
  final int newOrder;
  final List<OrderItem> products;
  final String userId;
  final int parentId;
  final int created;
  final int updated;
  final String paymentRefId;
  final int cancelRequest;
  final String courierStatus;
  final Coupon? coupon;
  final bool onlineCart;
  final String? accessKey;
  final String? intUrl;
  final String? extUrl;

  Order({
    required this.id,
    required this.orderNumber,
    required this.orderDate,
    required this.paymentMode,
    required this.taxAmount,
    required this.grandTotal,
    required this.shippingCost,
    required this.codCharge,
    required this.miniCharge,
    required this.addonUnitPrice,
    required this.miniItemQuantity,
    required this.addonQuantity,
    required this.discount,
    required this.status,
    required this.orderStatus,
    required this.shippingDetails,
    required this.surprisedProduct,
    required this.newOrder,
    required this.products,
    required this.userId,
    required this.parentId,
    required this.created,
    required this.updated,
    required this.paymentRefId,
    required this.cancelRequest,
    required this.courierStatus,
    required this.hotDealsTotal,
    required this.bounsServiceCharge,
    required this.subTotal,
    required this.subTotalWithoutDiscount,
    required this.serviceCharge,
    this.coupon,
    required this.onlineCart,
    this.accessKey,
    this.intUrl,
    this.extUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'] ?? '',
      orderNumber: json['order_number'] ?? '',
      orderDate: DateTime.fromMillisecondsSinceEpoch((json['order_date'] * 1000)),
      paymentMode: json['payment_mode'] ?? '',
      taxAmount: ConvertToNum.value(json['tax_amount'] ?? 0),
      grandTotal: ConvertToNum.value(json['grand_total'] ?? 0),
      shippingCost: ConvertToNum.value(json['shipping_cost'] ?? 0),
      codCharge: ConvertToNum.value(json['cod_charge'] ?? 0),
      miniCharge: ConvertToNum.value(json['mini_charge'] ?? 0),
      addonUnitPrice: ConvertToNum.value(json['addon_unit_price'] ?? 0),
      miniItemQuantity: ConvertToNum.value(json['mini_item_quantity'] ?? 0),
      addonQuantity: ConvertToNum.value(json['addon_quantity'] ?? 0),
      discount: ConvertToNum.value(json['discount'] ?? 0),
      status: json['status'] ?? '',
      orderStatus: json['order_status'] ?? '',
      shippingDetails: OrderShippingAddress.fromJson(json['shipping_details']),
      surprisedProduct: json['surprised_product'] ?? 0,
      newOrder: json['new_order'] ?? 0,
      products: List<OrderItem>.from(json['products'].map((x) => OrderItem.fromJson(x))),
      userId: json['user_id'] ?? '',
      parentId: json['parent_id'] ?? 0,
      created: json['created'] ?? 0,
      updated: json['updated'] ?? 0,
      paymentRefId: json['payment_ref_id'] ?? '',
      cancelRequest: json['cancel_request'] ?? 0,
      courierStatus: json['courier_status'] ?? '',
      hotDealsTotal: json['hot_deals_total'] ?? 0,
      bounsServiceCharge: json['bouns_service_charge'] ?? 0,
      serviceCharge: json['service_charge'] ?? 0,
      subTotal: json['sub_total'] ?? 0,
      subTotalWithoutDiscount: json['sub_total_without_discount'] ?? 0,
      coupon: json['coupon'] != null ? Coupon.fromRes(json['coupon']) : null,
      onlineCart: json['online_cart'] == 1,
      accessKey: json['access_key'],
      intUrl: json['int_url'],
      extUrl: json['ext_url'],
    );
  }
}

class OrderShippingAddress {
  final String shippingName;
  final String shippingLandmark;
  final String shippingPhone;
  final String shippingCity;
  final String shippingState;
  final String shippingAddress;
  final String shippingPincode;
  final String shippingAlternatePhone;

  OrderShippingAddress({
    required this.shippingName,
    required this.shippingLandmark,
    required this.shippingPhone,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingAddress,
    required this.shippingPincode,
    required this.shippingAlternatePhone,
  });

  factory OrderShippingAddress.fromJson(Map<String, dynamic> json) {
    return OrderShippingAddress(
      shippingName: json['shipping_name'] ?? '',
      shippingLandmark: json['shipping_landmark'] ?? '',
      shippingPhone: json['shipping_phone'] ?? '',
      shippingCity: json['shipping_city'] ?? '',
      shippingState: json['shipping_state'] ?? '',
      shippingAddress: json['shipping_address'] ?? '',
      shippingPincode: json['shipping_pincode'] ?? '',
      shippingAlternatePhone: json['shipping_alternate_phone'] ?? '',
    );
  }
}

class OrderItem {
  final String id;
  final String productId;
  final String userId;
  final int quantity;
  final String name;
  final String sku;
  final String description;
  final String productType;
  final num salePrice;
  final num mrp;
  final num offerPrice;
  final num serviceCharge;
  final String image;
  final int inventry;
  final int rewards;
  final OrderBrand? brand;

  OrderItem({
    required this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.name,
    required this.sku,
    required this.description,
    required this.productType,
    required this.salePrice,
    required this.mrp,
    required this.offerPrice,
    required this.serviceCharge,
    required this.image,
    required this.inventry,
    required this.rewards,
    this.brand,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['_id'] ?? '',
      productId: json['product_id'] ?? '',
      userId: json['user_id'] ?? '',
      quantity: json['quantity'] ?? 0,
      name: json['name'] ?? '',
      sku: json['sku'] ?? '',
      description: json['description'] ?? '',
      productType: json['product_type'] ?? '',
      salePrice: json['sale_price'] ?? 0,
      mrp: json['mrp'] ?? 0,
      offerPrice: json['offer_price'] ?? 0,
      serviceCharge: json['service_charge'] ?? 0,
      image: json['image'] ?? '',
      inventry: json['inventry'] ?? 0,
      rewards: json['rewards'] ?? 0,
      brand: json['brand'] != null ? OrderBrand.fromJson(json['brand']) : null,
    );
  }

  // AnalyticsEventItem toGAP() {
  //   return AnalyticsEventItem(
  //     itemId: id,
  //     itemName: name,
  //     itemBrand: brand?.name,
  //     itemCategory: brand?.name,
  //     currency: 'INR',
  //     price: productType == StringConstants.hotDealProduct || productType == StringConstants.brandStoreProduct ? salePrice.toDouble() : 0.00,
  //   );
  // }
}

class OrderBrand {
  final String id;
  final String name;
  final String description;
  final String logo;
  final String banner;

  OrderBrand({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.banner,
  });

  factory OrderBrand.fromJson(Map<String, dynamic> json) {
    return OrderBrand(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      banner: json['banner'] ?? '',
    );
  }
}

class ConvertToNum {
  static value(data) {
    if (data is String) {
      return num.parse(data);
    } else if (data is int) {
      return num.parse(data.toString());
    } else if (data is double) {
      return num.parse(data.toString());
    } else {
      return 0;
    }
  }
}
