/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/coupon.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// @RoutePage(name: 'CouponRoute')
class CouponScreenTab extends StatefulWidget {
  const CouponScreenTab({super.key});

  @override
  State<CouponScreenTab> createState() => _CouponScreenTabState();
}

class _CouponScreenTabState extends State<CouponScreenTab> {
  TextEditingController controller = TextEditingController();

  final DioHelper _dioHelper = DioHelper();

  findCoupon(AppProvider provider) async {
    final response = await _dioHelper.get('find-coupon/${controller.text.toUpperCase()}');
    log(response?.data.toString() ?? '');
    if (response != null && response.data['status']) {
      Coupon temp = Coupon.fromRes(response.data['record']);
      provider.applyCoupon(temp);
      if (!mounted) return;
      ScaffoldSnackBar.of(context).show('Coupon applied');
      context.router.popUntilRouteWithName(CartRoute.name);
    } else {
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      ScaffoldSnackBar.of(context).show('Coupon not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Apply Coupon'),
              centerTitle: false,
            ),
            body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * .03),
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: ColorConstants.colorGreyTwo,
                      width: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: 'Check coupon code',
                            hintStyle: TextHelper.normalTextStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          findCoupon(provider);
                        },
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        child: Text(
                          'CHECK',
                          style: TextHelper.normalTextStyle.copyWith(color: ColorConstants.colorBlueFour),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * .03),
                Expanded(
                  child: Container(
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...provider.coupons
                              .where((element) => element.expiryStatus == 1 && (provider.cart?.charges.grandTotal ?? 0) >= int.parse(element.cartValue))
                              .map(
                                (e) => Container(
                                  width: width,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Radio(
                                        value: provider.coupon,
                                        groupValue: e,
                                        activeColor: ColorConstants.colorPrimary,
                                        visualDensity: VisualDensity.adaptivePlatformDensity,
                                        onChanged: (_) {
                                          provider.applyCoupon(e);
                                          ScaffoldSnackBar.of(context).show('Coupon applied successfully!');
                                          context.router.maybePop();
                                        },
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(top: 15, bottom: 0),
                                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: ColorConstants.colorGreenTwo,
                                              ),
                                              child: Text(
                                                e.couponCode,
                                                style: TextHelper.smallTextStyle.copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              e.description,
                                              maxLines: 10000,
                                              style: TextHelper.normalTextStyle,
                                            ),
                                            const SizedBox(height: 15),
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
