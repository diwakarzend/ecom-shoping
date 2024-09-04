/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */
import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/contact.mobile.dart';
import 'package:fabpiks_web/screens/contact.screen.dart';
import 'package:fabpiks_web/screens/shipping.mobile.dart';
import 'package:fabpiks_web/screens/shipping.screen.dart';
import 'package:fabpiks_web/screens/term.screen.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:ionicons/ionicons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomDrawer extends Drawer {
  final AppProvider provider;
  final Function() onSupportExtend;
  final bool supportExpanded;
  final CartHelper cartHelper;

  const CustomDrawer({
    super.key,
    required this.provider,
    required this.onSupportExtend,
    required this.supportExpanded,
    required this.cartHelper,
  });

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    final kWidth = MediaQuery.of(context).size.width;
    final kHeight = MediaQuery.of(context).size.height;
    return Drawer(
      width: kWidth,
      backgroundColor: Colors.white,
      child: Container(
        height: kHeight,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: ColorConstants.colorGreyTwentyFour,
              automaticallyImplyLeading: false,
              elevation: 0,
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Ionicons.person_outline),
                    color: ColorConstants.colorBlackThree,
                    iconSize: 30,
                    onPressed: () {
                      Scaffold.of(context).closeDrawer();
                    },
                  );
                },
              ),
              titleSpacing: 0,
              title: Image.asset(
                'assets/images/fab_logo.png',
                height: kHeight * .03,
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () {
                    context.router.push(const NotificationRoute());
                  },
                  color: ColorConstants.colorBlackThree,
                  iconSize: 35,
                  icon: Badge(
                    showBadge: provider.reports
                        .where((element) =>
                    element.product != null &&
                        element.product!.stock > 0 &&
                        element.productId != null &&
                        element.qualified &&
                        !element.rejected &&
                        provider.currentUser != null &&
                        !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                        .isNotEmpty,
                    badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                    position: BadgePosition.topEnd(top: -5, end: 0),
                    badgeContent: Text(
                      provider.reports
                          .where((element) =>
                      element.product != null &&
                          element.product!.stock > 0 &&
                          element.productId != null &&
                          element.qualified &&
                          !element.rejected &&
                          provider.currentUser != null &&
                          !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                          .length
                          .toString(),
                      style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                    ),
                    child: const Icon(
                      Ionicons.notifications_outline,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    context.router.push(const CartRoute());
                  },
                  color: ColorConstants.colorBlackThree,
                  iconSize: 35,
                  icon: Badge(
                    showBadge: (provider.cart?.count ?? 0) > 0,
                    badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                    position: BadgePosition.topEnd(top: 0, end: 0),
                    badgeContent: Text(
                      provider.cart?.count.toString() ?? '',
                      style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                    ),
                    child: const Icon(
                      Ionicons.cart_outline,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                primary: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: kHeight * .03),
                    if (provider.currentUser != null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Builder(
                              builder: (context) {
                                return IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).closeDrawer();
                                  },
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.topCenter,
                                  color: ColorConstants.colorGreyTwo.withOpacity(0.5),
                                  iconSize: 25,
                                  icon: const Icon(
                                    Icons.west_rounded,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hey \n${provider.currentUser?.firstName}',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                                Text(
                                  'Logged in via ${provider.currentUser?.mobileNo}',
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => context.router.push(const ProfileRoute()),
                                splashFactory: NoSplash.splashFactory,
                                highlightColor: Colors.transparent,
                                child: provider.currentUser != null && provider.currentUser!.image != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(kWidth * .2),
                                  child: CustomNetworkImage(
                                    imageUrl: provider.currentUser?.image ?? '',
                                    width: kWidth * .15,
                                    height: kWidth * .15,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Container(
                                  width: kWidth * .15,
                                  height: kWidth * .15,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstants.colorGreyNine,
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    'assets/images/user-check.png',
                                    width: kWidth * .08,
                                    height: kWidth * .08,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: kWidth * .25,
                                child: Divider(
                                  color: ColorConstants.colorGreyTwo.withOpacity(0.6),
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    SizedBox(height: kHeight * .03),
                    SingleChildScrollView(
                      primary: false,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              context.router.push(const OrderRoute());
                            },
                            child: Container(
                              width: kWidth,
                              height: kHeight * .06,
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorGreyNine,
                                borderRadius: BorderRadius.circular(kHeight * .07),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Orders',
                                    style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.router.push(const PendingActionsRoute());
                            },
                            child: Container(
                              width: kWidth,
                              height: kHeight * .06,
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorGreyNine,
                                borderRadius: BorderRadius.circular(kHeight * .07),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Pending Actions',
                                    style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                  ),
                                  if (provider.reports
                                      .where((element) =>
                                  element.product != null &&
                                      element.product!.stock > 0 &&
                                      element.productId != null &&
                                      element.qualified &&
                                      !element.rejected &&
                                      provider.currentUser != null &&
                                      !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                                      .isNotEmpty)
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        provider.reports
                                            .where((element) =>
                                        element.product != null &&
                                            element.product!.stock > 0 &&
                                            element.productId != null &&
                                            element.qualified &&
                                            !element.rejected &&
                                            provider.currentUser != null &&
                                            !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                                            .length
                                            .toString(),
                                        style: TextHelper.subTitleStyle.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.router.push(const WishlistRoute());
                            },
                            child: Container(
                              width: kWidth,
                              height: kHeight * .06,
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorGreyNine,
                                borderRadius: BorderRadius.circular(kHeight * .07),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'My Wishlist',
                                    style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.router.push(const ProfileRoute());
                            },
                            child: Container(
                              width: kWidth,
                              height: kHeight * .06,
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorGreyNine,
                                borderRadius: BorderRadius.circular(kHeight * .07),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'My Profile',
                                    style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              onSupportExtend();
                            },
                            child: Container(
                              width: kWidth,
                              height: kHeight * .06,
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorGreyNine,
                                borderRadius: BorderRadius.circular(kHeight * .07),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Customer Support',
                                    style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                  ),
                                  Icon(
                                    supportExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                                    color: ColorConstants.colorBlack,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (supportExpanded)
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.router.push(AboutRoute());
                                  },
                                  child: Container(
                                    width: kWidth,
                                    height: kHeight * .06,
                                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorGreyNine,
                                      borderRadius: BorderRadius.circular(kHeight * .07),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'About Shubh',
                                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.router.push(const FAQHelpRoute());
                                  },
                                  child: Container(
                                    width: kWidth,
                                    height: kHeight * .06,
                                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorGreyNine,
                                      borderRadius: BorderRadius.circular(kHeight * .07),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'FAQ',
                                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.router.push(const RefundPolicyRoute());
                                  },
                                  child: Container(
                                    width: kWidth,
                                    height: kHeight * .06,
                                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorGreyNine,
                                      borderRadius: BorderRadius.circular(kHeight * .07),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Refund Policy',
                                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.router.push(const PrivacyPolicyRoute());
                                  },
                                  child: Container(
                                    width: kWidth,
                                    height: kHeight * .06,
                                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorGreyNine,
                                      borderRadius: BorderRadius.circular(kHeight * .07),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Privacy Policy',
                                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ShippingPolicyMobile()),
                                    );                                  },
                                  child: Container(
                                    width: kWidth,
                                    height: kHeight * .06,
                                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorGreyNine,
                                      borderRadius: BorderRadius.circular(kHeight * .07),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Shipping Policy',
                                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TermConditionAll()),
                                    );                                  },
                                  child: Container(
                                    width: kWidth,
                                    height: kHeight * .06,
                                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorGreyNine,
                                      borderRadius: BorderRadius.circular(kHeight * .07),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Term & Conditon',
                                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ContactUsMobile()),
                                    );                                  },
                                  child: Container(
                                    width: kWidth,
                                    height: kHeight * .06,
                                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorGreyNine,
                                      borderRadius: BorderRadius.circular(kHeight * .07),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Contact Us',
                                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.router.push(const HelpRoute());
                                  },
                                  child: Container(
                                    width: kWidth,
                                    height: kHeight * .06,
                                    margin: const EdgeInsets.only(bottom: 20, left: 20),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorGreyNine,
                                      borderRadius: BorderRadius.circular(kHeight * .07),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Need help with any issue?',
                                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                if (provider.currentUser != null) {
                                  provider.changeLoginStatus(false, null, '', '', '');
                                  context.router.popUntilRouteWithName(NavigatorRoute.name);
                                } else {
                                  context.router.push(AuthRoute(logOut: false));
                                }
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: kWidth * .3,
                                    height: kHeight * .06,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.colorGreyNine,
                                      borderRadius: BorderRadius.circular(kHeight * .07),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      provider.currentUser != null ? 'Logout' : 'Login',
                                      style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: kHeight * .1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}