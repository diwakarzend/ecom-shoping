class Wishlist {
  final num count;
  final List<WishlistItem> records;
  final String msg;

  Wishlist({
    required this.count,
    required this.records,
    required this.msg,
  });

  factory Wishlist.fromJson(Map<String, dynamic> json) {
    return Wishlist(
      count: json['count'] ?? 0,
      records: List<WishlistItem>.from(json['records'].map((x) => WishlistItem.fromJson(x))),
      msg: json['msg'] ?? '',
    );
  }
}

class WishlistItem {
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
  final WishlistItemBrand brand;

  WishlistItem({
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
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
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
      brand: WishlistItemBrand.fromJson(json['brand']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product_id': productId,
      'user_id': userId,
      'quantity': quantity,
      'name': name,
      'sku': sku,
      'description': description,
      'product_type': productType,
      'sale_price': salePrice,
      'mrp': mrp,
      'offer_price': offerPrice,
      'service_charge': serviceCharge,
      'image': image,
      'inventry': inventry,
      'rewards': rewards,
    };
  }
}

class WishlistItemBrand {
  final String id;
  final String name;
  final String description;
  final String logo;
  final String banner;

  WishlistItemBrand({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.banner,
  });

  factory WishlistItemBrand.fromJson(Map<String, dynamic> json) {
    return WishlistItemBrand(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
      banner: json['banner'] ?? '',
    );
  }
}
