// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i46;
import 'package:fabpiks_web/models/models.dart' as _i48;
import 'package:fabpiks_web/screens/about/about.screen.dart' as _i1;
import 'package:fabpiks_web/screens/add.address.dart' as _i2;
import 'package:fabpiks_web/screens/auth/auth.screen.dart' as _i3;
import 'package:fabpiks_web/screens/brand.item.screen.dart' as _i4;
import 'package:fabpiks_web/screens/brand.products.screen.dart' as _i5;
import 'package:fabpiks_web/screens/brand.trial.screen.dart' as _i6;
import 'package:fabpiks_web/screens/categories.screen.dart' as _i7;
import 'package:fabpiks_web/screens/category.products.screen.dart' as _i8;
import 'package:fabpiks_web/screens/coupon.screen.dart' as _i9;
import 'package:fabpiks_web/screens/deals.screen.dart' as _i10;
import 'package:fabpiks_web/screens/edit.address.dart' as _i11;
import 'package:fabpiks_web/screens/explore.by.brand.screen.dart' as _i20;
import 'package:fabpiks_web/screens/faq.screen.dart' as _i12;
import 'package:fabpiks_web/screens/feedback.screen.dart' as _i13;
import 'package:fabpiks_web/screens/filter.screen.dart' as _i14;
import 'package:fabpiks_web/screens/help.screen.dart' as _i15;
import 'package:fabpiks_web/screens/home.screen.dart' as _i16;
import 'package:fabpiks_web/screens/hot.item.screen.dart' as _i17;
import 'package:fabpiks_web/screens/image.gallery.dart' as _i18;
import 'package:fabpiks_web/screens/login/login.screen.dart' as _i19;
import 'package:fabpiks_web/screens/navigator.screen.dart' as _i21;
import 'package:fabpiks_web/screens/notification.screen.dart' as _i22;
import 'package:fabpiks_web/screens/order.details.dart' as _i23;
import 'package:fabpiks_web/screens/order.help.dart' as _i24;
import 'package:fabpiks_web/screens/orders.screen.dart' as _i25;
import 'package:fabpiks_web/screens/payment.help.dart' as _i27;
import 'package:fabpiks_web/screens/payment/payment.faield.dart' as _i26;
import 'package:fabpiks_web/screens/payment/payment.success.dart' as _i28;
import 'package:fabpiks_web/screens/pending.actions.dart' as _i29;
import 'package:fabpiks_web/screens/privacy.screen.dart' as _i30;
import 'package:fabpiks_web/screens/product.survey.dart' as _i31;
import 'package:fabpiks_web/screens/profile.screen.dart' as _i32;
import 'package:fabpiks_web/screens/rating.screen.dart' as _i33;
import 'package:fabpiks_web/screens/refund.policy.dart' as _i34;
import 'package:fabpiks_web/screens/shopping.hep.dart' as _i35;
import 'package:fabpiks_web/screens/shopping.screen.dart' as _i36;
import 'package:fabpiks_web/screens/shopping.tab.one.desktop.dart' as _i37;
import 'package:fabpiks_web/screens/shopping.tab.three.desktop.dart' as _i38;
import 'package:fabpiks_web/screens/shopping.tab.two.desktop.dart' as _i39;
import 'package:fabpiks_web/screens/signup.screen.dart' as _i40;
import 'package:fabpiks_web/screens/splash.screen.dart' as _i41;
import 'package:fabpiks_web/screens/terms.condition.dart' as _i42;
import 'package:fabpiks_web/screens/trail.screen.dart' as _i44;
import 'package:fabpiks_web/screens/trial.item.screen.dart' as _i43;
import 'package:fabpiks_web/screens/wishlist.screen.dart' as _i45;
import 'package:flutter/foundation.dart' as _i49;
import 'package:flutter/material.dart' as _i47;

/// generated route for
/// [_i1.AboutScreen]
class AboutRoute extends _i46.PageRouteInfo<AboutRouteArgs> {
  AboutRoute({
    _i47.Key? key,
    dynamic Function(bool)? onResult,
    List<_i46.PageRouteInfo>? children,
  }) : super(
          AboutRoute.name,
          args: AboutRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'AboutRoute';

  static _i46.PageInfo page = _i46.PageInfo(
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

  final _i47.Key? key;

  final dynamic Function(bool)? onResult;

  @override
  String toString() {
    return 'AboutRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i2.AddAddress]
class AddAddressRoute extends _i46.PageRouteInfo<AddAddressRouteArgs> {
  AddAddressRoute({
    _i47.Key? key,
    required bool fromCart,
    List<_i46.PageRouteInfo>? children,
  }) : super(
          AddAddressRoute.name,
          args: AddAddressRouteArgs(
            key: key,
            fromCart: fromCart,
          ),
          initialChildren: children,
        );

  static const String name = 'AddAddressRoute';

  static _i46.PageInfo page = _i46.PageInfo(
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

  final _i47.Key? key;

  final bool fromCart;

  @override
  String toString() {
    return 'AddAddressRouteArgs{key: $key, fromCart: $fromCart}';
  }
}

/// generated route for
/// [_i3.AuthScreen]
class AuthRoute extends _i46.PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    _i47.Key? key,
    bool logOut = false,
    List<_i46.PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(
            key: key,
            logOut: logOut,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static _i46.PageInfo page = _i46.PageInfo(
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

  final _i47.Key? key;

  final bool logOut;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, logOut: $logOut}';
  }
}

/// generated route for
/// [_i4.BrandItemScreen]
class BrandItemRoute extends _i46.PageRouteInfo<BrandItemRouteArgs> {
  BrandItemRoute({
    _i47.Key? key,
    required String productId,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
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

  final _i47.Key? key;

  final String productId;

  @override
  String toString() {
    return 'BrandItemRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i5.BrandProductScreen]
class BrandProductsRoute extends _i46.PageRouteInfo<void> {
  const BrandProductsRoute({List<_i46.PageRouteInfo>? children})
      : super(
          BrandProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrandProductsRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i5.BrandProductScreen();
    },
  );
}

/// generated route for
/// [_i6.BrandTrialScreen]
class BrandTrialRoute extends _i46.PageRouteInfo<BrandTrialRouteArgs> {
  BrandTrialRoute({
    _i47.Key? key,
    required _i48.Brand brand,
    List<_i46.PageRouteInfo>? children,
  }) : super(
          BrandTrialRoute.name,
          args: BrandTrialRouteArgs(
            key: key,
            brand: brand,
          ),
          initialChildren: children,
        );

  static const String name = 'BrandTrialRoute';

  static _i46.PageInfo page = _i46.PageInfo(
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

  final _i47.Key? key;

  final _i48.Brand brand;

  @override
  String toString() {
    return 'BrandTrialRouteArgs{key: $key, brand: $brand}';
  }
}

/// generated route for
/// [_i7.CategoriesScreen]
class CategoryRoute extends _i46.PageRouteInfo<void> {
  const CategoryRoute({List<_i46.PageRouteInfo>? children})
      : super(
          CategoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i7.CategoriesScreen();
    },
  );
}

/// generated route for
/// [_i8.CategoryProductsScreen]
class CategoryProductRoute
    extends _i46.PageRouteInfo<CategoryProductRouteArgs> {
  CategoryProductRoute({
    _i47.Key? key,
    required String categoryId,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
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

  final _i47.Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'CategoryProductRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i9.CouponScreen]
class CouponRoute extends _i46.PageRouteInfo<void> {
  const CouponRoute({List<_i46.PageRouteInfo>? children})
      : super(
          CouponRoute.name,
          initialChildren: children,
        );

  static const String name = 'CouponRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i9.CouponScreen();
    },
  );
}

/// generated route for
/// [_i10.DealsScreen]
class DealsRoute extends _i46.PageRouteInfo<void> {
  const DealsRoute({List<_i46.PageRouteInfo>? children})
      : super(
          DealsRoute.name,
          initialChildren: children,
        );

  static const String name = 'DealsRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i10.DealsScreen();
    },
  );
}

/// generated route for
/// [_i11.EditAddress]
class EditAddressRoute extends _i46.PageRouteInfo<EditAddressRouteArgs> {
  EditAddressRoute({
    _i49.Key? key,
    required _i48.Shipping shipping,
    List<_i46.PageRouteInfo>? children,
  }) : super(
          EditAddressRoute.name,
          args: EditAddressRouteArgs(
            key: key,
            shipping: shipping,
          ),
          initialChildren: children,
        );

  static const String name = 'EditAddressRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditAddressRouteArgs>();
      return _i11.EditAddress(
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

  final _i49.Key? key;

  final _i48.Shipping shipping;

  @override
  String toString() {
    return 'EditAddressRouteArgs{key: $key, shipping: $shipping}';
  }
}

/// generated route for
/// [_i12.FAQHelp]
class FAQHelpRoute extends _i46.PageRouteInfo<void> {
  const FAQHelpRoute({List<_i46.PageRouteInfo>? children})
      : super(
          FAQHelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'FAQHelpRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i12.FAQHelp();
    },
  );
}

/// generated route for
/// [_i13.FeedbackScreen]
class FeedbackRoute extends _i46.PageRouteInfo<void> {
  const FeedbackRoute({List<_i46.PageRouteInfo>? children})
      : super(
          FeedbackRoute.name,
          initialChildren: children,
        );

  static const String name = 'FeedbackRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i13.FeedbackScreen();
    },
  );
}

/// generated route for
/// [_i14.FilterScreen]
class FilterRoute extends _i46.PageRouteInfo<FilterRouteArgs> {
  FilterRoute({
    _i47.Key? key,
    required dynamic Function({
      _i48.Brand? brand,
      _i48.Category? category,
    }) onSubmit,
    _i48.Brand? selectedBrand,
    _i48.Category? selectedCategory,
    required String screenName,
    String? productType,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FilterRouteArgs>();
      return _i14.FilterScreen(
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

  final _i47.Key? key;

  final dynamic Function({
    _i48.Brand? brand,
    _i48.Category? category,
  }) onSubmit;

  final _i48.Brand? selectedBrand;

  final _i48.Category? selectedCategory;

  final String screenName;

  final String? productType;

  @override
  String toString() {
    return 'FilterRouteArgs{key: $key, onSubmit: $onSubmit, selectedBrand: $selectedBrand, selectedCategory: $selectedCategory, screenName: $screenName, productType: $productType}';
  }
}

/// generated route for
/// [_i15.HelpScreen]
class HelpRoute extends _i46.PageRouteInfo<void> {
  const HelpRoute({List<_i46.PageRouteInfo>? children})
      : super(
          HelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i15.HelpScreen();
    },
  );
}

/// generated route for
/// [_i16.HomeScreen]
class HomeRoute extends _i46.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i47.Key? key,
    bool orderSuccess = false,
    _i48.Order? order,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i16.HomeScreen(
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

  final _i47.Key? key;

  final bool orderSuccess;

  final _i48.Order? order;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, orderSuccess: $orderSuccess, order: $order}';
  }
}

/// generated route for
/// [_i17.HotItemScreen]
class HotItemRoute extends _i46.PageRouteInfo<HotItemRouteArgs> {
  HotItemRoute({
    _i47.Key? key,
    required String productId,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<HotItemRouteArgs>(
          orElse: () =>
              HotItemRouteArgs(productId: pathParams.getString('id')));
      return _i17.HotItemScreen(
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

  final _i47.Key? key;

  final String productId;

  @override
  String toString() {
    return 'HotItemRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i18.ImageGallery]
class ImageGalleryRoute extends _i46.PageRouteInfo<ImageGalleryRouteArgs> {
  ImageGalleryRoute({
    _i47.Key? key,
    required List<String> images,
    required int index,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ImageGalleryRouteArgs>();
      return _i18.ImageGallery(
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

  final _i47.Key? key;

  final List<String> images;

  final int index;

  @override
  String toString() {
    return 'ImageGalleryRouteArgs{key: $key, images: $images, index: $index}';
  }
}

/// generated route for
/// [_i19.LoginScreen]
class LoginRoute extends _i46.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i47.Key? key,
    dynamic Function(bool)? onResult,
    List<_i46.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i19.LoginScreen(
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

  final _i47.Key? key;

  final dynamic Function(bool)? onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i20.LoginScreen]
class ExploreByBrandsRoute extends _i46.PageRouteInfo<void> {
  const ExploreByBrandsRoute({List<_i46.PageRouteInfo>? children})
      : super(
          ExploreByBrandsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExploreByBrandsRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i20.LoginScreen();
    },
  );
}

/// generated route for
/// [_i21.NavigatorScreen]
class NavigatorRoute extends _i46.PageRouteInfo<NavigatorRouteArgs> {
  NavigatorRoute({
    _i47.Key? key,
    bool orderSuccess = false,
    _i48.Order? order,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NavigatorRouteArgs>(
          orElse: () => const NavigatorRouteArgs());
      return _i21.NavigatorScreen(
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

  final _i47.Key? key;

  final bool orderSuccess;

  final _i48.Order? order;

  @override
  String toString() {
    return 'NavigatorRouteArgs{key: $key, orderSuccess: $orderSuccess, order: $order}';
  }
}

/// generated route for
/// [_i22.NotificationScreen]
class NotificationRoute extends _i46.PageRouteInfo<void> {
  const NotificationRoute({List<_i46.PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i22.NotificationScreen();
    },
  );
}

/// generated route for
/// [_i23.OrderDetails]
class OrderDetailsRoute extends _i46.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i47.Key? key,
    required String orderId,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<OrderDetailsRouteArgs>(
          orElse: () =>
              OrderDetailsRouteArgs(orderId: pathParams.getString('id')));
      return _i23.OrderDetails(
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

  final _i47.Key? key;

  final String orderId;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, orderId: $orderId}';
  }
}

/// generated route for
/// [_i24.OrderHelp]
class OrderHelpRoute extends _i46.PageRouteInfo<void> {
  const OrderHelpRoute({List<_i46.PageRouteInfo>? children})
      : super(
          OrderHelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHelpRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i24.OrderHelp();
    },
  );
}

/// generated route for
/// [_i25.OrdersScreen]
class OrderRoute extends _i46.PageRouteInfo<void> {
  const OrderRoute({List<_i46.PageRouteInfo>? children})
      : super(
          OrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i25.OrdersScreen();
    },
  );
}

/// generated route for
/// [_i26.PaymentFailed]
class PaymentFailed extends _i46.PageRouteInfo<PaymentFailedArgs> {
  PaymentFailed({
    _i47.Key? key,
    required String paymentID,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PaymentFailedArgs>(
          orElse: () =>
              PaymentFailedArgs(paymentID: pathParams.getString('id')));
      return _i26.PaymentFailed(
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

  final _i47.Key? key;

  final String paymentID;

  @override
  String toString() {
    return 'PaymentFailedArgs{key: $key, paymentID: $paymentID}';
  }
}

/// generated route for
/// [_i27.PaymentHelp]
class PaymentHelpRoute extends _i46.PageRouteInfo<void> {
  const PaymentHelpRoute({List<_i46.PageRouteInfo>? children})
      : super(
          PaymentHelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'PaymentHelpRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i27.PaymentHelp();
    },
  );
}

/// generated route for
/// [_i28.PaymentSuccess]
class PaymentSuccess extends _i46.PageRouteInfo<PaymentSuccessArgs> {
  PaymentSuccess({
    _i47.Key? key,
    required String paymentID,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<PaymentSuccessArgs>(
          orElse: () =>
              PaymentSuccessArgs(paymentID: pathParams.getString('id')));
      return _i28.PaymentSuccess(
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

  final _i47.Key? key;

  final String paymentID;

  @override
  String toString() {
    return 'PaymentSuccessArgs{key: $key, paymentID: $paymentID}';
  }
}

/// generated route for
/// [_i29.PendingActions]
class PendingActionsRoute extends _i46.PageRouteInfo<void> {
  const PendingActionsRoute({List<_i46.PageRouteInfo>? children})
      : super(
          PendingActionsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PendingActionsRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i29.PendingActions();
    },
  );
}

/// generated route for
/// [_i30.PrivacyPolicy]
class PrivacyPolicyRoute extends _i46.PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<_i46.PageRouteInfo>? children})
      : super(
          PrivacyPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i30.PrivacyPolicy();
    },
  );
}

/// generated route for
/// [_i31.ProductSurvey]
class ProductSurveyRoute extends _i46.PageRouteInfo<ProductSurveyRouteArgs> {
  ProductSurveyRoute({
    _i47.Key? key,
    required String productId,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProductSurveyRouteArgs>(
          orElse: () =>
              ProductSurveyRouteArgs(productId: pathParams.getString('id')));
      return _i31.ProductSurvey(
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

  final _i47.Key? key;

  final String productId;

  @override
  String toString() {
    return 'ProductSurveyRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i32.ProfileScreen]
class ProfileRoute extends _i46.PageRouteInfo<void> {
  const ProfileRoute({List<_i46.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i32.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i33.RatingScreen]
class RatingRoute extends _i46.PageRouteInfo<RatingRouteArgs> {
  RatingRoute({
    _i47.Key? key,
    required _i48.Product product,
    List<_i46.PageRouteInfo>? children,
  }) : super(
          RatingRoute.name,
          args: RatingRouteArgs(
            key: key,
            product: product,
          ),
          initialChildren: children,
        );

  static const String name = 'RatingRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RatingRouteArgs>();
      return _i33.RatingScreen(
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

  final _i47.Key? key;

  final _i48.Product product;

  @override
  String toString() {
    return 'RatingRouteArgs{key: $key, product: $product}';
  }
}

/// generated route for
/// [_i34.RefundPolicy]
class RefundPolicyRoute extends _i46.PageRouteInfo<void> {
  const RefundPolicyRoute({List<_i46.PageRouteInfo>? children})
      : super(
          RefundPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'RefundPolicyRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i34.RefundPolicy();
    },
  );
}

/// generated route for
/// [_i35.ShoppingHelp]
class ShoppingHelpRoute extends _i46.PageRouteInfo<void> {
  const ShoppingHelpRoute({List<_i46.PageRouteInfo>? children})
      : super(
          ShoppingHelpRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingHelpRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i35.ShoppingHelp();
    },
  );
}

/// generated route for
/// [_i36.ShoppingScreen]
class CartRoute extends _i46.PageRouteInfo<void> {
  const CartRoute({List<_i46.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i36.ShoppingScreen();
    },
  );
}

/// generated route for
/// [_i37.ShoppingTabOneDesktop]
class ShoppingTabOneDesktop extends _i46.PageRouteInfo<void> {
  const ShoppingTabOneDesktop({List<_i46.PageRouteInfo>? children})
      : super(
          ShoppingTabOneDesktop.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingTabOneDesktop';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i37.ShoppingTabOneDesktop();
    },
  );
}

/// generated route for
/// [_i38.ShoppingTabThreeDesktop]
class ShoppingTabThreeDesktop
    extends _i46.PageRouteInfo<ShoppingTabThreeDesktopArgs> {
  ShoppingTabThreeDesktop({
    _i49.Key? key,
    required String addressId,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ShoppingTabThreeDesktopArgs>(
          orElse: () => ShoppingTabThreeDesktopArgs(
              addressId: pathParams.getString('id')));
      return _i38.ShoppingTabThreeDesktop(
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

  final _i49.Key? key;

  final String addressId;

  @override
  String toString() {
    return 'ShoppingTabThreeDesktopArgs{key: $key, addressId: $addressId}';
  }
}

/// generated route for
/// [_i39.ShoppingTabTwoDesktop]
class ShoppingTabTwoDesktop extends _i46.PageRouteInfo<void> {
  const ShoppingTabTwoDesktop({List<_i46.PageRouteInfo>? children})
      : super(
          ShoppingTabTwoDesktop.name,
          initialChildren: children,
        );

  static const String name = 'ShoppingTabTwoDesktop';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i39.ShoppingTabTwoDesktop();
    },
  );
}

/// generated route for
/// [_i40.SignupScreen]
class SignupRoute extends _i46.PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    _i47.Key? key,
    dynamic Function(bool)? onResult,
    required String referCode,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SignupRouteArgs>();
      return _i40.SignupScreen(
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

  final _i47.Key? key;

  final dynamic Function(bool)? onResult;

  final String referCode;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key, onResult: $onResult, referCode: $referCode}';
  }
}

/// generated route for
/// [_i41.SplashScreen]
class SplashRoute extends _i46.PageRouteInfo<void> {
  const SplashRoute({List<_i46.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i41.SplashScreen();
    },
  );
}

/// generated route for
/// [_i42.TermsCondition]
class TermsConditionRoute extends _i46.PageRouteInfo<void> {
  const TermsConditionRoute({List<_i46.PageRouteInfo>? children})
      : super(
          TermsConditionRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsConditionRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i42.TermsCondition();
    },
  );
}

/// generated route for
/// [_i43.TrialItemScreen]
class TrialItemRoute extends _i46.PageRouteInfo<TrialItemRouteArgs> {
  TrialItemRoute({
    _i47.Key? key,
    required String productId,
    List<_i46.PageRouteInfo>? children,
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

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TrialItemRouteArgs>(
          orElse: () =>
              TrialItemRouteArgs(productId: pathParams.getString('id')));
      return _i43.TrialItemScreen(
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

  final _i47.Key? key;

  final String productId;

  @override
  String toString() {
    return 'TrialItemRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i44.TrialScreen]
class TrialRoute extends _i46.PageRouteInfo<void> {
  const TrialRoute({List<_i46.PageRouteInfo>? children})
      : super(
          TrialRoute.name,
          initialChildren: children,
        );

  static const String name = 'TrialRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i44.TrialScreen();
    },
  );
}

/// generated route for
/// [_i45.WishlistScreenAll]
class WishlistRoute extends _i46.PageRouteInfo<void> {
  const WishlistRoute({List<_i46.PageRouteInfo>? children})
      : super(
          WishlistRoute.name,
          initialChildren: children,
        );

  static const String name = 'WishlistRoute';

  static _i46.PageInfo page = _i46.PageInfo(
    name,
    builder: (data) {
      return const _i45.WishlistScreenAll();
    },
  );
}
