// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i48;
import 'package:fabpiks_web/models/models.dart' as _i50;
import 'package:fabpiks_web/screens/about/about.screen.dart' as _i1;
import 'package:fabpiks_web/screens/add.address.dart' as _i2;
import 'package:fabpiks_web/screens/auth/auth.screen.dart' as _i3;
import 'package:fabpiks_web/screens/brand.item.screen.dart' as _i4;
import 'package:fabpiks_web/screens/brand.products.screen.dart' as _i5;
import 'package:fabpiks_web/screens/brand.trial.screen.dart' as _i6;
import 'package:fabpiks_web/screens/categories.screen.dart' as _i7;
import 'package:fabpiks_web/screens/category.products.screen.dart' as _i8;
import 'package:fabpiks_web/screens/contact.screen.dart' as _i9;
import 'package:fabpiks_web/screens/coupon.screen.dart' as _i10;
import 'package:fabpiks_web/screens/deals.screen.dart' as _i11;
import 'package:fabpiks_web/screens/edit.address.dart' as _i12;
import 'package:fabpiks_web/screens/explore.by.brand.screen.dart' as _i20;
import 'package:fabpiks_web/screens/faq.screen.dart' as _i13;
import 'package:fabpiks_web/screens/feedback.screen.dart' as _i14;
import 'package:fabpiks_web/screens/filter.screen.dart' as _i15;
import 'package:fabpiks_web/screens/help.screen.dart' as _i16;
import 'package:fabpiks_web/screens/home.screen.dart' as _i17;
import 'package:fabpiks_web/screens/hot.item.screen.dart' as _i18;
import 'package:fabpiks_web/screens/image.gallery.dart' as _i19;
import 'package:fabpiks_web/screens/login/login.screen.dart' as _i21;
import 'package:fabpiks_web/screens/navigator.screen.dart' as _i22;
import 'package:fabpiks_web/screens/notification.screen.dart' as _i23;
import 'package:fabpiks_web/screens/order.details.dart' as _i24;
import 'package:fabpiks_web/screens/order.help.dart' as _i25;
import 'package:fabpiks_web/screens/orders.screen.dart' as _i26;
import 'package:fabpiks_web/screens/payment.help.dart' as _i28;
import 'package:fabpiks_web/screens/payment/payment.faield.dart' as _i27;
import 'package:fabpiks_web/screens/payment/payment.success.dart' as _i29;
import 'package:fabpiks_web/screens/pending.actions.dart' as _i30;
import 'package:fabpiks_web/screens/privacy.screen.dart' as _i31;
import 'package:fabpiks_web/screens/product.survey.dart' as _i32;
import 'package:fabpiks_web/screens/profile.screen.dart' as _i33;
import 'package:fabpiks_web/screens/rating.screen.dart' as _i34;
import 'package:fabpiks_web/screens/refund.policy.dart' as _i35;
import 'package:fabpiks_web/screens/shipping.tab.dart' as _i36;
import 'package:fabpiks_web/screens/shopping.hep.dart' as _i37;
import 'package:fabpiks_web/screens/shopping.screen.dart' as _i38;
import 'package:fabpiks_web/screens/shopping.tab.one.desktop.dart' as _i39;
import 'package:fabpiks_web/screens/shopping.tab.three.desktop.dart' as _i40;
import 'package:fabpiks_web/screens/shopping.tab.two.desktop.dart' as _i41;
import 'package:fabpiks_web/screens/signup.screen.dart' as _i42;
import 'package:fabpiks_web/screens/splash.screen.dart' as _i43;
import 'package:fabpiks_web/screens/terms.condition.dart' as _i44;
import 'package:fabpiks_web/screens/trail.screen.dart' as _i46;
import 'package:fabpiks_web/screens/trial.item.screen.dart' as _i45;
import 'package:fabpiks_web/screens/wishlist.screen.dart' as _i47;
import 'package:flutter/foundation.dart' as _i51;
import 'package:flutter/material.dart' as _i49;

/// generated route for
/// [_i1.AboutScreen]
class AboutRoute extends _i48.PageRouteInfo<AboutRouteArgs> {
  AboutRoute({
    _i49.Key? key,
    dynamic Function(bool)? onResult,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          AboutRoute.name,
          args: AboutRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'AboutRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<AboutRouteArgs>(orElse: () => const AboutRouteArgs());
      return _i1.AboutScreen(
        key: args.key,
        onResult: args.onResult,
      );
    },
  );
}

class AboutRouteArgs {
  const AboutRouteArgs({
    this.key,
    this.onResult,
  });

  final _i49.Key? key;

  final dynamic Function(bool)? onResult;

  @override
  String toString() {
    return 'AboutRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i2.AddAddress]
class AddAddressRoute extends _i48.PageRouteInfo<AddAddressRouteArgs> {
  AddAddressRoute({
    _i49.Key? key,
    required bool fromCart,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          AddAddressRoute.name,
          args: AddAddressRouteArgs(
            key: key,
            fromCart: fromCart,
          ),
          initialChildren: children,
        );

  static const String name = 'AddAddressRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AddAddressRouteArgs>();
      return _i2.AddAddress(
        key: args.key,
        fromCart: args.fromCart,
      );
    },
  );
}

class AddAddressRouteArgs {
  const AddAddressRouteArgs({
    this.key,
    required this.fromCart,
  });

  final _i49.Key? key;

  final bool fromCart;

  @override
  String toString() {
    return 'AddAddressRouteArgs{key: $key, fromCart: $fromCart}';
  }
}

/// generated route for
/// [_i3.AuthScreen]
class AuthRoute extends _i48.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i49.Key? key,
    bool logOut = false,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(
            key: key,
            logOut: logOut,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return _i3.AuthScreen(
        key: args.key,
        logOut: args.logOut,
      );
    },
  );
}

class AuthRouteArgs {
  const AuthRouteArgs({
    this.key,
    this.logOut = false,
  });

  final _i49.Key? key;

  final bool logOut;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, logOut: $logOut}';
  }
}

/// generated route for
/// [_i4.BrandItemScreen]
class BrandItemRoute extends _i48.PageRouteInfo<BrandItemRouteArgs> {
  BrandItemRoute({
    _i49.Key? key,
    required String productId,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          BrandItemRoute.name,
          args: BrandItemRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'id': productId},
          initialChildren: children,
        );

  static const String name = 'BrandItemRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<BrandItemRouteArgs>(
          orElse: () =>
              BrandItemRouteArgs(productId: pathParams.getString('id')));
      return _i4.BrandItemScreen(
        key: args.key,
        productId: args.productId,
      );
    },
  );
}

class BrandItemRouteArgs {
  const BrandItemRouteArgs({
    this.key,
    required this.productId,
  });

  final _i49.Key? key;

  final String productId;

  @override
  String toString() {
    return 'BrandItemRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i5.BrandProductScreen]
class BrandProductsRoute extends _i48.PageRouteInfo<void> {
  const BrandProductsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          BrandProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrandProductsRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i5.BrandProductScreen();
    },
  );
}

/// generated route for
/// [_i6.BrandTrialScreen]
class BrandTrialRoute extends _i48.PageRouteInfo<BrandTrialRouteArgs> {
  BrandTrialRoute({
    _i49.Key? key,
    required _i50.Brand brand,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          BrandTrialRoute.name,
          args: BrandTrialRouteArgs(
            key: key,
            brand: brand,
          ),
          initialChildren: children,
        );

  static const String name = 'BrandTrialRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BrandTrialRouteArgs>();
      return _i6.BrandTrialScreen(
        key: args.key,
        brand: args.brand,
      );
    },
  );
}

class BrandTrialRouteArgs {
  const BrandTrialRouteArgs({
    this.key,
    required this.brand,
  });

  final _i49.Key? key;

  final _i50.Brand brand;

  @override
  String toString() {
    return 'BrandTrialRouteArgs{key: $key, brand: $brand}';
  }
}

/// generated route for
/// [_i7.CategoriesScreen]
class CategoryRoute extends _i48.PageRouteInfo<void> {
  const CategoryRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CategoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i7.CategoriesScreen();
    },
  );
}

/// generated route for
/// [_i8.CategoryProductsScreen]
class CategoryProductRoute
    extends _i48.PageRouteInfo<CategoryProductRouteArgs> {
  CategoryProductRoute({
    _i49.Key? key,
    required String categoryId,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          CategoryProductRoute.name,
          args: CategoryProductRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          rawPathParams: {'id': categoryId},
          initialChildren: children,
        );

  static const String name = 'CategoryProductRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<CategoryProductRouteArgs>(
          orElse: () =>
              CategoryProductRouteArgs(categoryId: pathParams.getString('id')));
      return _i8.CategoryProductsScreen(
        key: args.key,
        categoryId: args.categoryId,
      );
    },
  );
}

class CategoryProductRouteArgs {
  const CategoryProductRouteArgs({
    this.key,
    required this.categoryId,
  });

  final _i49.Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'CategoryProductRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i9.ContactUsAll]
class ContactRoute extends _i48.PageRouteInfo<void> {
  const ContactRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ContactRoute.name,
          initialChildren: children,
        );

  static const String name = 'ContactRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i9.ContactUsAll();
    },
  );
}

/// generated route for
/// [_i10.CouponScreen]
class CouponRoute extends _i48.PageRouteInfo<void> {
  const CouponRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CouponRoute.name,
          initialChildren: children,
        );

  static const String name = 'CouponRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i10.CouponScreen();
    },
  );
}

/// generated route for
/// [_i11.DealsScreen]
class DealsRoute extends _i48.PageRouteInfo<void> {
  const DealsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          DealsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealsRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i11.DealsScreen();
    },
  );
}

/// generated route for
/// [_i12.EditAddress]
class EditAddressRoute extends _i48.PageRouteInfo<EditAddressRouteArgs> {
  EditAddressRoute({
    _i51.Key? key,
    required _i50.Shipping shipping,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          EditAddressRoute.name,
          args: EditAddressRouteArgs(
            key: key,
            shipping: shipping,
          ),
          initialChildren: children,
        );

  static const String name = 'EditAddressRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditAddressRouteArgs>();
      return _i12.EditAddress(
        key: args.key,
        shipping: args.shipping,
      );
    },
  );
}

class EditAddressRouteArgs {
  const EditAddressRouteArgs({
    this.key,
    required this.shipping,
  });

  final _i51.Key? key;

  final _i50.Shipping shipping;

  @override
  String toString() {
    return 'EditAddressRouteArgs{key: $key, shipping: $shipping}';
  }
}

/// generated route for
/// [_i13.FAQHelp]
class FAQHelpRoute extends _i48.PageRouteInfo<void> {
  const FAQHelpRoute({List<_i48.PageRouteInfo>? children})
      : super(
          FAQHelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'FAQHelpRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i13.FAQHelp();
    },
  );
}

/// generated route for
/// [_i14.FeedbackScreen]
class FeedbackRoute extends _i48.PageRouteInfo<void> {
  const FeedbackRoute({List<_i48.PageRouteInfo>? children})
      : super(
          FeedbackRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedbackRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i14.FeedbackScreen();
    },
  );
}

/// generated route for
/// [_i15.FilterScreen]
class FilterRoute extends _i48.PageRouteInfo<FilterRouteArgs> {
  FilterRoute({
    _i49.Key? key,
    required dynamic Function({
      _i50.Brand? brand,
      _i50.Category? category,
    }) onSubmit,
    _i50.Brand? selectedBrand,
    _i50.Category? selectedCategory,
    required String screenName,
    String? productType,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          FilterRoute.name,
          args: FilterRouteArgs(
            key: key,
            onSubmit: onSubmit,
            selectedBrand: selectedBrand,
            selectedCategory: selectedCategory,
            screenName: screenName,
            productType: productType,
          ),
          initialChildren: children,
        );

  static const String name = 'FilterRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilterRouteArgs>();
      return _i15.FilterScreen(
        key: args.key,
        onSubmit: args.onSubmit,
        selectedBrand: args.selectedBrand,
        selectedCategory: args.selectedCategory,
        screenName: args.screenName,
        productType: args.productType,
      );
    },
  );
}

class FilterRouteArgs {
  const FilterRouteArgs({
    this.key,
    required this.onSubmit,
    this.selectedBrand,
    this.selectedCategory,
    required this.screenName,
    this.productType,
  });

  final _i49.Key? key;

  final dynamic Function({
    _i50.Brand? brand,
    _i50.Category? category,
  }) onSubmit;

  final _i50.Brand? selectedBrand;

  final _i50.Category? selectedCategory;

  final String screenName;

  final String? productType;

  @override
  String toString() {
    return 'FilterRouteArgs{key: $key, onSubmit: $onSubmit, selectedBrand: $selectedBrand, selectedCategory: $selectedCategory, screenName: $screenName, productType: $productType}';
  }
}

/// generated route for
/// [_i16.HelpScreen]
class HelpRoute extends _i48.PageRouteInfo<void> {
  const HelpRoute({List<_i48.PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i16.HelpScreen();
    },
  );
}

/// generated route for
/// [_i17.HomeScreen]
class HomeRoute extends _i48.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i49.Key? key,
    bool orderSuccess = false,
    _i50.Order? order,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            orderSuccess: orderSuccess,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i17.HomeScreen(
        key: args.key,
        orderSuccess: args.orderSuccess,
        order: args.order,
      );
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    this.orderSuccess = false,
    this.order,
  });

  final _i49.Key? key;

  final bool orderSuccess;

  final _i50.Order? order;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, orderSuccess: $orderSuccess, order: $order}';
  }
}

/// generated route for
/// [_i18.HotItemScreen]
class HotItemRoute extends _i48.PageRouteInfo<HotItemRouteArgs> {
  HotItemRoute({
    _i49.Key? key,
    required String productId,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          HotItemRoute.name,
          args: HotItemRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'id': productId},
          initialChildren: children,
        );

  static const String name = 'HotItemRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<HotItemRouteArgs>(
          orElse: () =>
              HotItemRouteArgs(productId: pathParams.getString('id')));
      return _i18.HotItemScreen(
        key: args.key,
        productId: args.productId,
      );
    },
  );
}

class HotItemRouteArgs {
  const HotItemRouteArgs({
    this.key,
    required this.productId,
  });

  final _i49.Key? key;

  final String productId;

  @override
  String toString() {
    return 'HotItemRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i19.ImageGallery]
class ImageGalleryRoute extends _i48.PageRouteInfo<ImageGalleryRouteArgs> {
  ImageGalleryRoute({
    _i49.Key? key,
    required List<String> images,
    required int index,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          ImageGalleryRoute.name,
          args: ImageGalleryRouteArgs(
            key: key,
            images: images,
            index: index,
          ),
          initialChildren: children,
        );

  static const String name = 'ImageGalleryRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ImageGalleryRouteArgs>();
      return _i19.ImageGallery(
        key: args.key,
        images: args.images,
        index: args.index,
      );
    },
  );
}

class ImageGalleryRouteArgs {
  const ImageGalleryRouteArgs({
    this.key,
    required this.images,
    required this.index,
  });

  final _i49.Key? key;

  final List<String> images;

  final int index;

  @override
  String toString() {
    return 'ImageGalleryRouteArgs{key: $key, images: $images, index: $index}';
  }
}

/// generated route for
/// [_i20.LoginScreen]
class ExploreByBrandsRoute extends _i48.PageRouteInfo<void> {
  const ExploreByBrandsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ExploreByBrandsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreByBrandsRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i20.LoginScreen();
    },
  );
}

/// generated route for
/// [_i21.LoginScreen]
class LoginRoute extends _i48.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i49.Key? key,
    dynamic Function(bool)? onResult,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i21.LoginScreen(
        key: args.key,
        onResult: args.onResult,
      );
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    this.onResult,
  });

  final _i49.Key? key;

  final dynamic Function(bool)? onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i22.NavigatorScreen]
class NavigatorRoute extends _i48.PageRouteInfo<NavigatorRouteArgs> {
  NavigatorRoute({
    _i49.Key? key,
    bool orderSuccess = false,
    _i50.Order? order,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          NavigatorRoute.name,
          args: NavigatorRouteArgs(
            key: key,
            orderSuccess: orderSuccess,
            order: order,
          ),
          initialChildren: children,
        );

  static const String name = 'NavigatorRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NavigatorRouteArgs>(
          orElse: () => const NavigatorRouteArgs());
      return _i22.NavigatorScreen(
        key: args.key,
        orderSuccess: args.orderSuccess,
        order: args.order,
      );
    },
  );
}

class NavigatorRouteArgs {
  const NavigatorRouteArgs({
    this.key,
    this.orderSuccess = false,
    this.order,
  });

  final _i49.Key? key;

  final bool orderSuccess;

  final _i50.Order? order;

  @override
  String toString() {
    return 'NavigatorRouteArgs{key: $key, orderSuccess: $orderSuccess, order: $order}';
  }
}

/// generated route for
/// [_i23.NotificationScreen]
class NotificationRoute extends _i48.PageRouteInfo<void> {
  const NotificationRoute({List<_i48.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i23.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i24.OrderDetails]
class OrderDetailsRoute extends _i48.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i49.Key? key,
    required String orderId,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          OrderDetailsRoute.name,
          args: OrderDetailsRouteArgs(
            key: key,
            orderId: orderId,
          ),
          rawPathParams: {'id': orderId},
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<OrderDetailsRouteArgs>(
          orElse: () =>
              OrderDetailsRouteArgs(orderId: pathParams.getString('id')));
      return _i24.OrderDetails(
        key: args.key,
        orderId: args.orderId,
      );
    },
  );
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({
    this.key,
    required this.orderId,
  });

  final _i49.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i25.OrderHelp]
class OrderHelpRoute extends _i48.PageRouteInfo<void> {
  const OrderHelpRoute({List<_i48.PageRouteInfo>? children})
      : super(
          OrderHelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHelpRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i25.OrderHelp();
    },
  );
}

/// generated route for
/// [_i26.OrdersScreen]
class OrderRoute extends _i48.PageRouteInfo<void> {
  const OrderRoute({List<_i48.PageRouteInfo>? children})
      : super(
          OrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i26.OrdersScreen();
    },
  );
}

/// generated route for
/// [_i27.PaymentFailed]
class PaymentFailed extends _i48.PageRouteInfo<PaymentFailedArgs> {
  PaymentFailed({
    _i49.Key? key,
    required String paymentID,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          PaymentFailed.name,
          args: PaymentFailedArgs(
            key: key,
            paymentID: paymentID,
          ),
          rawPathParams: {'id': paymentID},
          initialChildren: children,
        );

  static const String name = 'PaymentFailed';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PaymentFailedArgs>(
          orElse: () =>
              PaymentFailedArgs(paymentID: pathParams.getString('id')));
      return _i27.PaymentFailed(
        key: args.key,
        paymentID: args.paymentID,
      );
    },
  );
}

class PaymentFailedArgs {
  const PaymentFailedArgs({
    this.key,
    required this.paymentID,
  });

  final _i49.Key? key;

  final String paymentID;

  @override
  String toString() {
    return 'PaymentFailedArgs{key: $key, paymentID: $paymentID}';
  }
}

/// generated route for
/// [_i28.PaymentHelp]
class PaymentHelpRoute extends _i48.PageRouteInfo<void> {
  const PaymentHelpRoute({List<_i48.PageRouteInfo>? children})
      : super(
          PaymentHelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentHelpRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i28.PaymentHelp();
    },
  );
}

/// generated route for
/// [_i29.PaymentSuccess]
class PaymentSuccess extends _i48.PageRouteInfo<PaymentSuccessArgs> {
  PaymentSuccess({
    _i49.Key? key,
    required String paymentID,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          PaymentSuccess.name,
          args: PaymentSuccessArgs(
            key: key,
            paymentID: paymentID,
          ),
          rawPathParams: {'id': paymentID},
          initialChildren: children,
        );

  static const String name = 'PaymentSuccess';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PaymentSuccessArgs>(
          orElse: () =>
              PaymentSuccessArgs(paymentID: pathParams.getString('id')));
      return _i29.PaymentSuccess(
        key: args.key,
        paymentID: args.paymentID,
      );
    },
  );
}

class PaymentSuccessArgs {
  const PaymentSuccessArgs({
    this.key,
    required this.paymentID,
  });

  final _i49.Key? key;

  final String paymentID;

  @override
  String toString() {
    return 'PaymentSuccessArgs{key: $key, paymentID: $paymentID}';
  }
}

/// generated route for
/// [_i30.PendingActions]
class PendingActionsRoute extends _i48.PageRouteInfo<void> {
  const PendingActionsRoute({List<_i48.PageRouteInfo>? children})
      : super(
          PendingActionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PendingActionsRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i30.PendingActions();
    },
  );
}

/// generated route for
/// [_i31.PrivacyPolicy]
class PrivacyPolicyRoute extends _i48.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i48.PageRouteInfo>? children})
      : super(
          PrivacyPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i31.PrivacyPolicy();
    },
  );
}

/// generated route for
/// [_i32.ProductSurvey]
class ProductSurveyRoute extends _i48.PageRouteInfo<ProductSurveyRouteArgs> {
  ProductSurveyRoute({
    _i49.Key? key,
    required String productId,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          ProductSurveyRoute.name,
          args: ProductSurveyRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'id': productId},
          initialChildren: children,
        );

  static const String name = 'ProductSurveyRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProductSurveyRouteArgs>(
          orElse: () =>
              ProductSurveyRouteArgs(productId: pathParams.getString('id')));
      return _i32.ProductSurvey(
        key: args.key,
        productId: args.productId,
      );
    },
  );
}

class ProductSurveyRouteArgs {
  const ProductSurveyRouteArgs({
    this.key,
    required this.productId,
  });

  final _i49.Key? key;

  final String productId;

  @override
  String toString() {
    return 'ProductSurveyRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i33.ProfileScreen]
class ProfileRoute extends _i48.PageRouteInfo<void> {
  const ProfileRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i33.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i34.RatingScreen]
class RatingRoute extends _i48.PageRouteInfo<RatingRouteArgs> {
  RatingRoute({
    _i49.Key? key,
    required _i50.Product product,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          RatingRoute.name,
          args: RatingRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'RatingRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RatingRouteArgs>();
      return _i34.RatingScreen(
        key: args.key,
        product: args.product,
      );
    },
  );
}

class RatingRouteArgs {
  const RatingRouteArgs({
    this.key,
    required this.product,
  });

  final _i49.Key? key;

  final _i50.Product product;

  @override
  String toString() {
    return 'RatingRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i35.RefundPolicy]
class RefundPolicyRoute extends _i48.PageRouteInfo<void> {
  const RefundPolicyRoute({List<_i48.PageRouteInfo>? children})
      : super(
          RefundPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'RefundPolicyRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i35.RefundPolicy();
    },
  );
}

/// generated route for
/// [_i36.ShippingPolicyTab]
class ShippingRoute extends _i48.PageRouteInfo<void> {
  const ShippingRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ShippingRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShippingRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i36.ShippingPolicyTab();
    },
  );
}

/// generated route for
/// [_i37.ShoppingHelp]
class ShoppingHelpRoute extends _i48.PageRouteInfo<void> {
  const ShoppingHelpRoute({List<_i48.PageRouteInfo>? children})
      : super(
          ShoppingHelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingHelpRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i37.ShoppingHelp();
    },
  );
}

/// generated route for
/// [_i38.ShoppingScreen]
class CartRoute extends _i48.PageRouteInfo<void> {
  const CartRoute({List<_i48.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i38.ShoppingScreen();
    },
  );
}

/// generated route for
/// [_i39.ShoppingTabOneDesktop]
class ShoppingTabOneDesktop extends _i48.PageRouteInfo<void> {
  const ShoppingTabOneDesktop({List<_i48.PageRouteInfo>? children})
      : super(
          ShoppingTabOneDesktop.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingTabOneDesktop';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i39.ShoppingTabOneDesktop();
    },
  );
}

/// generated route for
/// [_i40.ShoppingTabThreeDesktop]
class ShoppingTabThreeDesktop
    extends _i48.PageRouteInfo<ShoppingTabThreeDesktopArgs> {
  ShoppingTabThreeDesktop({
    _i51.Key? key,
    required String addressId,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          ShoppingTabThreeDesktop.name,
          args: ShoppingTabThreeDesktopArgs(
            key: key,
            addressId: addressId,
          ),
          rawPathParams: {'id': addressId},
          initialChildren: children,
        );

  static const String name = 'ShoppingTabThreeDesktop';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ShoppingTabThreeDesktopArgs>(
          orElse: () => ShoppingTabThreeDesktopArgs(
              addressId: pathParams.getString('id')));
      return _i40.ShoppingTabThreeDesktop(
        key: args.key,
        addressId: args.addressId,
      );
    },
  );
}

class ShoppingTabThreeDesktopArgs {
  const ShoppingTabThreeDesktopArgs({
    this.key,
    required this.addressId,
  });

  final _i51.Key? key;

  final String addressId;

  @override
  String toString() {
    return 'ShoppingTabThreeDesktopArgs{key: $key, addressId: $addressId}';
  }
}

/// generated route for
/// [_i41.ShoppingTabTwoDesktop]
class ShoppingTabTwoDesktop extends _i48.PageRouteInfo<void> {
  const ShoppingTabTwoDesktop({List<_i48.PageRouteInfo>? children})
      : super(
          ShoppingTabTwoDesktop.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingTabTwoDesktop';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i41.ShoppingTabTwoDesktop();
    },
  );
}

/// generated route for
/// [_i42.SignupScreen]
class SignupRoute extends _i48.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i49.Key? key,
    dynamic Function(bool)? onResult,
    required String referCode,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(
            key: key,
            onResult: onResult,
            referCode: referCode,
          ),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignupRouteArgs>();
      return _i42.SignupScreen(
        key: args.key,
        onResult: args.onResult,
        referCode: args.referCode,
      );
    },
  );
}

class SignupRouteArgs {
  const SignupRouteArgs({
    this.key,
    this.onResult,
    required this.referCode,
  });

  final _i49.Key? key;

  final dynamic Function(bool)? onResult;

  final String referCode;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key, onResult: $onResult, referCode: $referCode}';
  }
}

/// generated route for
/// [_i43.SplashScreen]
class SplashRoute extends _i48.PageRouteInfo<void> {
  const SplashRoute({List<_i48.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i43.SplashScreen();
    },
  );
}

/// generated route for
/// [_i44.TermsCondition]
class TermsConditionRoute extends _i48.PageRouteInfo<void> {
  const TermsConditionRoute({List<_i48.PageRouteInfo>? children})
      : super(
          TermsConditionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsConditionRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i44.TermsCondition();
    },
  );
}

/// generated route for
/// [_i45.TrialItemScreen]
class TrialItemRoute extends _i48.PageRouteInfo<TrialItemRouteArgs> {
  TrialItemRoute({
    _i49.Key? key,
    required String productId,
    List<_i48.PageRouteInfo>? children,
  }) : super(
          TrialItemRoute.name,
          args: TrialItemRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'id': productId},
          initialChildren: children,
        );

  static const String name = 'TrialItemRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TrialItemRouteArgs>(
          orElse: () =>
              TrialItemRouteArgs(productId: pathParams.getString('id')));
      return _i45.TrialItemScreen(
        key: args.key,
        productId: args.productId,
      );
    },
  );
}

class TrialItemRouteArgs {
  const TrialItemRouteArgs({
    this.key,
    required this.productId,
  });

  final _i49.Key? key;

  final String productId;

  @override
  String toString() {
    return 'TrialItemRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i46.TrialScreen]
class TrialRoute extends _i48.PageRouteInfo<void> {
  const TrialRoute({List<_i48.PageRouteInfo>? children})
      : super(
          TrialRoute.name,
          initialChildren: children,
        );

  static const String name = 'TrialRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i46.TrialScreen();
    },
  );
}

/// generated route for
/// [_i47.WishlistScreenAll]
class WishlistRoute extends _i48.PageRouteInfo<void> {
  const WishlistRoute({List<_i48.PageRouteInfo>? children})
      : super(
          WishlistRoute.name,
          initialChildren: children,
        );

  static const String name = 'WishlistRoute';

  static _i48.PageInfo page = _i48.PageInfo(
    name,
    builder: (data) {
      return const _i47.WishlistScreenAll();
    },
  );
}
