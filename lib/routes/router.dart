/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:hive_flutter/hive_flutter.dart';

@AutoRouterConfig(
  replaceInRouteName: 'routes',
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/'),
        AutoRoute(page: ExploreByBrandsRoute.page, path: '/brands'),
        AutoRoute(page: AuthRoute.page, path: '/auth'),
        AutoRoute(page: SignupRoute.page, path: '/signup'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: NotificationRoute.page, path: '/notifications'),
        AutoRoute(page: AboutRoute.page, path: '/about'),
        AutoRoute(page: RatingRoute.page, path: '/ratting'),
        AutoRoute(page: NavigatorRoute.page, path: '/dashboard'),
        AutoRoute(page: HomeRoute.page, path: '/home'),
        AutoRoute(page: TrialRoute.page, path: '/trials'),
        AutoRoute(page: DealsRoute.page, path: '/deals'),
        AutoRoute(page: BrandProductsRoute.page, path: '/product-by-brands'),
        AutoRoute(page: CategoryRoute.page, path: '/category'),
        AutoRoute(page: CartRoute.page, guards: [AuthGuard()], path: '/cart'),
        AutoRoute(page: OrderRoute.page, guards: [AuthGuard()], path: '/orders'),
        AutoRoute(page: OrderDetailsRoute.page, guards: [AuthGuard()], path: '/order-details/:id'),
        AutoRoute(page: PendingActionsRoute.page, guards: [AuthGuard()], path: '/pending-actions'),
        AutoRoute(page: TrialItemRoute.page, path: '/mini-item/:id'),
        AutoRoute(page: BrandItemRoute.page, path: '/sample-item/:id'),
        AutoRoute(page: HotItemRoute.page, path: '/deal-items/:id'),
        AutoRoute(page: AddAddressRoute.page, guards: [AuthGuard()], path: '/add-address'),
        AutoRoute(page: EditAddressRoute.page, guards: [AuthGuard()], path: '/edit-address'),
        AutoRoute(page: WishlistRoute.page, guards: [AuthGuard()], path: '/wish-list'),
        AutoRoute(page: ProfileRoute.page, guards: [AuthGuard()], path: '/profile'),
        AutoRoute(page: CategoryProductRoute.page, path: '/category-products/:id'),
        AutoRoute(page: FilterRoute.page, path: '/product-filters'),
        AutoRoute(page: HelpRoute.page, path: '/help'),
        AutoRoute(page: CouponRoute.page, guards: [AuthGuard()], path: '/coupon'),
        AutoRoute(page: ProductSurveyRoute.page, guards: [AuthGuard()], path: '/product-survey/:id'),
        AutoRoute(page: BrandTrialRoute.page, path: '/brand-trials'),
        AutoRoute(page: FeedbackRoute.page, path: '/feedback'),
        AutoRoute(page: PaymentHelpRoute.page, path: '/payment-help'),
        AutoRoute(page: ShoppingHelpRoute.page, path: '/shopping-help'),
        AutoRoute(page: OrderHelpRoute.page, path: '/order-help'),
        AutoRoute(page: FAQHelpRoute.page, path: '/faq'),
        AutoRoute(page: ImageGalleryRoute.page, guards: [AuthGuard()], path: '/product-images'),
        AutoRoute(page: TermsConditionRoute.page, path: '/terms'),
        AutoRoute(page: PrivacyPolicyRoute.page, path: '/privacy'),
        AutoRoute(page: ContactRoute.page, path: '/contact'),
        AutoRoute(page: ShippingRoute.page, path: '/shipping-policy'),
        AutoRoute(page: TermRoute.page, path: '/term-condition'),
        AutoRoute(page: RefundPolicyRoute.page, path: '/refund-policy'),
        AutoRoute(page: ShoppingTabOneDesktop.page, guards: [AuthGuard()], path: '/checkout-one'),
        AutoRoute(page: ShoppingTabTwoDesktop.page, guards: [AuthGuard()], path: '/checkout-two'),
        AutoRoute(page: ShoppingTabThreeDesktop.page, guards: [AuthGuard()], path: '/checkout-final/:id'),
        AutoRoute(page: PaymentFailed.page, guards: [AuthGuard()], path: '/payment-failed/:id'),
        AutoRoute(page: PaymentSuccess.page, guards: [AuthGuard()], path: '/payment-success/:id'),
      ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    Box loginBox = Hive.box<LoginDetails>(StringConstants.loginBoxKey);
    LoginDetails? loginDetails = await loginBox.get('login');
    if (loginDetails != null) {
      resolver.next(true);
    } else {
      resolver.redirect(
        LoginRoute(
          onResult: (bool success) {
            resolver.next(success);
          },
        ),
      );
    }
  }
}
