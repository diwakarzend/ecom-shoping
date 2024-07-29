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

abstract class $AppRouter extends _i46.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i46.PageFactory> pagesMap = {
    AboutRoute.name: (routeData) {
      final args = routeData.argsAs<AboutRouteArgs>(
          orElse: () => const AboutRouteArgs());
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AboutScreen(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    AddAddressRoute.name: (routeData) {
      final args = routeData.argsAs<AddAddressRouteArgs>();
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.AddAddress(
          key: args.key,
          fromCart: args.fromCart,
        ),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.AuthScreen(
          key: args.key,
          logOut: args.logOut,
        ),
      );
    },
    BrandItemRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BrandItemRouteArgs>(
          orElse: () =>
              BrandItemRouteArgs(productId: pathParams.getString('id')));
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.BrandItemScreen(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    BrandProductsRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.BrandProductScreen(),
      );
    },
    BrandTrialRoute.name: (routeData) {
      final args = routeData.argsAs<BrandTrialRouteArgs>();
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.BrandTrialScreen(
          key: args.key,
          brand: args.brand,
        ),
      );
    },
    CategoryRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.CategoriesScreen(),
      );
    },
    CategoryProductRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CategoryProductRouteArgs>(
          orElse: () =>
              CategoryProductRouteArgs(categoryId: pathParams.getString('id')));
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.CategoryProductsScreen(
          key: args.key,
          categoryId: args.categoryId,
        ),
      );
    },
    CouponRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.CouponScreen(),
      );
    },
    DealsRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.DealsScreen(),
      );
    },
    EditAddressRoute.name: (routeData) {
      final args = routeData.argsAs<EditAddressRouteArgs>();
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.EditAddress(
          key: args.key,
          shipping: args.shipping,
        ),
      );
    },
    FAQHelpRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.FAQHelp(),
      );
    },
    FeedbackRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.FeedbackScreen(),
      );
    },
    FilterRoute.name: (routeData) {
      final args = routeData.argsAs<FilterRouteArgs>();
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.FilterScreen(
          key: args.key,
          onSubmit: args.onSubmit,
          selectedBrand: args.selectedBrand,
          selectedCategory: args.selectedCategory,
          screenName: args.screenName,
          productType: args.productType,
        ),
      );
    },
    HelpRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.HelpScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i16.HomeScreen(
          key: args.key,
          orderSuccess: args.orderSuccess,
          order: args.order,
        ),
      );
    },
    HotItemRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HotItemRouteArgs>(
          orElse: () =>
              HotItemRouteArgs(productId: pathParams.getString('id')));
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.HotItemScreen(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    ImageGalleryRoute.name: (routeData) {
      final args = routeData.argsAs<ImageGalleryRouteArgs>();
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.ImageGallery(
          key: args.key,
          images: args.images,
          index: args.index,
        ),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.LoginScreen(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    ExploreByBrandsRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.LoginScreen(),
      );
    },
    NavigatorRoute.name: (routeData) {
      final args = routeData.argsAs<NavigatorRouteArgs>(
          orElse: () => const NavigatorRouteArgs());
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.NavigatorScreen(
          key: args.key,
          orderSuccess: args.orderSuccess,
          order: args.order,
        ),
      );
    },
    NotificationRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.NotificationScreen(),
      );
    },
    OrderDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<OrderDetailsRouteArgs>(
          orElse: () =>
              OrderDetailsRouteArgs(orderId: pathParams.getString('id')));
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.OrderDetails(
          key: args.key,
          orderId: args.orderId,
        ),
      );
    },
    OrderHelpRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.OrderHelp(),
      );
    },
    OrderRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.OrdersScreen(),
      );
    },
    PaymentFailed.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PaymentFailedArgs>(
          orElse: () =>
              PaymentFailedArgs(paymentID: pathParams.getString('id')));
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i26.PaymentFailed(
          key: args.key,
          paymentID: args.paymentID,
        ),
      );
    },
    PaymentHelpRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.PaymentHelp(),
      );
    },
    PaymentSuccess.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PaymentSuccessArgs>(
          orElse: () =>
              PaymentSuccessArgs(paymentID: pathParams.getString('id')));
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i28.PaymentSuccess(
          key: args.key,
          paymentID: args.paymentID,
        ),
      );
    },
    PendingActionsRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i29.PendingActions(),
      );
    },
    PrivacyPolicyRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.PrivacyPolicy(),
      );
    },
    ProductSurveyRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductSurveyRouteArgs>(
          orElse: () =>
              ProductSurveyRouteArgs(productId: pathParams.getString('id')));
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i31.ProductSurvey(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.ProfileScreen(),
      );
    },
    RatingRoute.name: (routeData) {
      final args = routeData.argsAs<RatingRouteArgs>();
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i33.RatingScreen(
          key: args.key,
          product: args.product,
        ),
      );
    },
    RefundPolicyRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i34.RefundPolicy(),
      );
    },
    ShoppingHelpRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i35.ShoppingHelp(),
      );
    },
    CartRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.ShoppingScreen(),
      );
    },
    ShoppingTabOneDesktop.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.ShoppingTabOneDesktop(),
      );
    },
    ShoppingTabThreeDesktop.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ShoppingTabThreeDesktopArgs>(
          orElse: () => ShoppingTabThreeDesktopArgs(
              addressId: pathParams.getString('id')));
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i38.ShoppingTabThreeDesktop(
          key: args.key,
          addressId: args.addressId,
        ),
      );
    },
    ShoppingTabTwoDesktop.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i39.ShoppingTabTwoDesktop(),
      );
    },
    SignupRoute.name: (routeData) {
      final args = routeData.argsAs<SignupRouteArgs>();
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i40.SignupScreen(
          key: args.key,
          onResult: args.onResult,
          referCode: args.referCode,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i41.SplashScreen(),
      );
    },
    TermsConditionRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i42.TermsCondition(),
      );
    },
    TrialItemRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TrialItemRouteArgs>(
          orElse: () =>
              TrialItemRouteArgs(productId: pathParams.getString('id')));
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i43.TrialItemScreen(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    TrialRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i44.TrialScreen(),
      );
    },
    WishlistRoute.name: (routeData) {
      return _i46.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i45.WishlistScreenAll(),
      );
    },
  };
}

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

  static const _i46.PageInfo<AboutRouteArgs> page =
      _i46.PageInfo<AboutRouteArgs>(name);
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

  static const _i46.PageInfo<AddAddressRouteArgs> page =
      _i46.PageInfo<AddAddressRouteArgs>(name);
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

  static const _i46.PageInfo<AuthRouteArgs> page =
      _i46.PageInfo<AuthRouteArgs>(name);
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

  static const _i46.PageInfo<BrandItemRouteArgs> page =
      _i46.PageInfo<BrandItemRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<BrandTrialRouteArgs> page =
      _i46.PageInfo<BrandTrialRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<CategoryProductRouteArgs> page =
      _i46.PageInfo<CategoryProductRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<EditAddressRouteArgs> page =
      _i46.PageInfo<EditAddressRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<FilterRouteArgs> page =
      _i46.PageInfo<FilterRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<HomeRouteArgs> page =
      _i46.PageInfo<HomeRouteArgs>(name);
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

  static const _i46.PageInfo<HotItemRouteArgs> page =
      _i46.PageInfo<HotItemRouteArgs>(name);
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

  static const _i46.PageInfo<ImageGalleryRouteArgs> page =
      _i46.PageInfo<ImageGalleryRouteArgs>(name);
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

  static const _i46.PageInfo<LoginRouteArgs> page =
      _i46.PageInfo<LoginRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<NavigatorRouteArgs> page =
      _i46.PageInfo<NavigatorRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<OrderDetailsRouteArgs> page =
      _i46.PageInfo<OrderDetailsRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<PaymentFailedArgs> page =
      _i46.PageInfo<PaymentFailedArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<PaymentSuccessArgs> page =
      _i46.PageInfo<PaymentSuccessArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<ProductSurveyRouteArgs> page =
      _i46.PageInfo<ProductSurveyRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<RatingRouteArgs> page =
      _i46.PageInfo<RatingRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<ShoppingTabThreeDesktopArgs> page =
      _i46.PageInfo<ShoppingTabThreeDesktopArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<SignupRouteArgs> page =
      _i46.PageInfo<SignupRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<TrialItemRouteArgs> page =
      _i46.PageInfo<TrialItemRouteArgs>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
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

  static const _i46.PageInfo<void> page = _i46.PageInfo<void>(name);
}
