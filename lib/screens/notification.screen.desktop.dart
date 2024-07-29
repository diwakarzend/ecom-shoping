/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// @RoutePage(name: 'NotificationRoute')
class NotificationScreenDesktop extends StatefulWidget {
  const NotificationScreenDesktop({super.key});

  @override
  State<NotificationScreenDesktop> createState() => _NotificationScreenDesktopMobileState();
}

class _NotificationScreenDesktopMobileState extends State<NotificationScreenDesktop> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh(AppProvider provider) async {
    provider.initWithLogin();
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          // appBar: AppBar(
          //   elevation: 0.0,
          //   automaticallyImplyLeading: false,
          //   backgroundColor: Colors.white,
          //   title: const Text(''),
          //   centerTitle: false,
          // ),
          body: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: () => _onRefresh(provider),
            child: Column(
              children: [
                const TopAppBar(),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 170, vertical: 30),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...provider.reports
                          .where((element) =>
                              element.product != null &&
                              element.product!.stock > 0 &&
                              element.productId != null &&
                              element.qualified &&
                              !element.rejected &&
                              provider.currentUser != null &&
                              !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                          .map(
                        (e) {
                          return Container(
                            width: width,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(4, 0),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomNetworkImage(
                                  imageUrl: e.product?.image ?? '',
                                  width: width * .14,
                                  height: width * .14,
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'YOUR FREE SAMPLES HAS BEEN APPROVED',
                                        maxLines: 2,
                                        style: TextHelper.smallTextStyle.copyWith(
                                          color: ColorConstants.colorBlueTwentyOne,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text.rich(
                                        TextSpan(
                                          text: e.product?.brand?.name ?? '',
                                          style: TextHelper.smallTextStyle.copyWith(
                                            color: ColorConstants.colorBlack,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' ${e.product?.name ?? ''}',
                                              style: TextHelper.smallTextStyle.copyWith(
                                                color: ColorConstants.colorBlack,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Service Fee ${StringConstants.rupeeSign}${e.product?.serviceCharge}',
                                        style: TextHelper.smallTextStyle.copyWith(
                                          color: ColorConstants.colorBlack,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      InkWell(
                                        onTap: () {
                                          if (e.product != null &&
                                              provider.cart != null &&
                                              !provider.cart!.records.any((element) => element.id == e.product?.id)) {
                                            showModalBottomSheet(
                                              context: context,
                                              backgroundColor: Colors.transparent,
                                              isScrollControlled: true,
                                              builder: (c) => _Dialog(
                                                height: height,
                                                width: width,
                                                product: e.product!,
                                                onCheckout: () {
                                                  provider.addCartItems(productID: e.productId ?? '');
                                                  context.router.pop();
                                                  context.router.push(const ShoppingTabOneDesktop());
                                                },
                                                onContinue: () {
                                                  provider.addCartItems(productID: e.productId ?? '');
                                                  context.router.popUntilRouteWithName(NavigatorRoute.name);
                                                },
                                              ),
                                            );
                                          } else {
                                            ScaffoldSnackBar.of(context).show('Already added to cart');
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: ColorConstants.colorBlueTwentyOne,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'Add to cart',
                                            style: TextHelper.extraSmallTextStyle.copyWith(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 13.sp),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '"Hurry! Our exclusive offer is valid until stocks are available. Don\'t miss out, ORDER NOW"',
                                        maxLines: 5,
                                        style: TextHelper.extraSmallTextStyle.copyWith(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 13.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      if (provider.reports
                          .where((element) =>
                              element.productId != null &&
                              element.qualified &&
                              !element.rejected &&
                              provider.currentUser != null &&
                              !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                          .isEmpty)
                        Container(
                          margin: EdgeInsets.symmetric(vertical: height * .12, horizontal: width * .15),
                          alignment: Alignment.center,
                          child: Text(
                            'No approvals showing \nPull Down To Refresh',
                            textAlign: TextAlign.center,
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                    ],
                  ),
                ),
                const BottomAppBarPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Dialog extends StatelessWidget {
  final double height;
  final double width;
  final Product product;
  final Function() onCheckout;
  final Function() onContinue;

  const _Dialog({required this.height, required this.width, required this.product, required this.onCheckout, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: width,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
                bottom: Radius.circular(10),
              ),
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: width,
                      padding: EdgeInsets.only(top: height * .05, bottom: height * .08, left: 20, right: 20),
                      margin: EdgeInsets.only(bottom: height * .09),
                      decoration: const BoxDecoration(
                        color: ColorConstants.colorPrimary,
                      ),
                      child: Text(
                        'Congratulations on your successful match!',
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: TextHelper.smallTextStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,fontSize: 13.sp,
                        ),
                      ),
                    ),
                    Positioned(
                      left: width * .15,
                      bottom: 15,
                      right: width * .19,
                      child: Container(
                        transform: Matrix4.translationValues(width * .01, 0,0),
                        width: width * .10,
                        height: height * .12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        alignment: Alignment.center,
                        child: CustomNetworkImage(
                          imageUrl: product.image,
                          width: width * .10,
                          height: height * .12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .02),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Your trial for ${product.name} has been approved. We look forward to your feedback and brand experience.',
                      maxLines: 1000,
                      textAlign: TextAlign.center,
                      style: TextHelper.smallTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                if (product.serviceCharge > 0) SizedBox(height: height * .03),
                if (product.serviceCharge > 0)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      TextSpan(
                        text: 'Note: ',
                        style: TextHelper.smallTextStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: 'An amount of ${StringConstants.rupeeSign}${product.serviceCharge} shall be payable towards service/delivery fee.',
                            style: TextHelper.smallTextStyle.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(height: height * .03),
                Align(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Please confirm your dispatch by clicking on the checkout button.',
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      style: TextHelper.smallTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                InkWell(
                  onTap: onCheckout,
                  child: Container(
                    width: width * .2,
                    height: height * .055,
                    decoration: BoxDecoration(
                      color: ColorConstants.colorPrimary,
                      borderRadius: BorderRadius.circular(height * .06),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Checkout',
                      style: TextHelper.smallTextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                InkWell(
                  onTap: onContinue,
                  child: Container(
                    width: width * .2,
                    height: height * .055,
                    decoration: BoxDecoration(
                      color: ColorConstants.colorPrimary,
                      borderRadius: BorderRadius.circular(height * .06),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Continue Shopping',
                      style: TextHelper.smallTextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: InkWell(
              onTap: () => context.router.pop(),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xffEDEBEB),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.close_rounded,
                  color: Color(0xff606060),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
