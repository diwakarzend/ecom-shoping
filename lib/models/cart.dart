import 'package:fabpiks_web/constants.dart';

class Cart {
  final int count;
  final List<CartItem> records;
  final CartCharges charges;
  final String msg;

  Cart({
    required this.count,
    required this.records,
    required this.charges,
    required this.msg,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      count: json['count'] ?? 0,
      records: List<CartItem>.from(json['records'].map((x) => CartItem.fromJson(x))),
      charges: CartCharges.fromJson(json['charges']),
      msg: json['msg'] ?? '',
    );
  }
}

class CartItem {
  final String id;
  final String productId;
  final String userId;
  final int quantity;
  final String name;
  final String sku;
  final String description;
  final String productType;
  final int salePrice;
  final int mrp;
  final int offerPrice;
  final int serviceCharge;
  final String image;
  final int inventry;
  final int rewards;
  final CartItemBrand brand;
  final bool inStock;

  CartItem({
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
    required this.brand,
    required this.inStock,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
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
      brand: CartItemBrand.fromJson(json['brand']),
      inStock: (json['inventry'] ?? 0) > 0,
    );
  }
}

class CartItemBrand {
  final String id;
  final String name;
  final String description;
  final String logo;
  final String banner;

  CartItemBrand({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.banner,
  });

  factory CartItemBrand.fromJson(Map<String, dynamic> json) {
    return CartItemBrand(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      banner: json['banner'] ?? '',
    );
  }
}

class CartCharges {
  final num hotDealsCharge;
  final int miniItemQuantity;
  final num addonQuantity;
  final num serviceCharge;
  final num addonUnitPrice;
  final num bounsServiceCharge;
  final num subTotalWithoutDiscount;
  final num discount;
  final num subTotal;
  final num grandTotal;

  CartCharges({
    required this.hotDealsCharge,
    required this.miniItemQuantity,
    required this.addonQuantity,
    required this.serviceCharge,
    required this.addonUnitPrice,
    required this.bounsServiceCharge,
    required this.subTotalWithoutDiscount,
    required this.discount,
    required this.subTotal,
    required this.grandTotal,
  });

  factory CartCharges.fromJson(Map<String, dynamic> json) {
    return CartCharges(
      hotDealsCharge: ConvertToNum.value(json['hot_deals_charge'] ?? 0),
      miniItemQuantity: ConvertToNum.value(json['mini_item_quantity'] ?? 0),
      addonQuantity: ConvertToNum.value(json['addon_quantity'] ?? 0),
      serviceCharge: ConvertToNum.value(json['service_charge'] ?? 0),
      addonUnitPrice: ConvertToNum.value(json['addon_unit_price'] ?? 0),
      bounsServiceCharge: ConvertToNum.value(json['bouns_service_charge'] ?? 0),
      subTotalWithoutDiscount: ConvertToNum.value(json['sub_total_without_discount'] ?? 0),
      discount: ConvertToNum.value(json['discount'] ?? 0),
      subTotal: ConvertToNum.value(json['sub_total'] ?? 0),
      grandTotal: ConvertToNum.value(json['grand_total'] ?? 0),
    );
  }
}
