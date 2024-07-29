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
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// @RoutePage(name: 'CouponRoute')
class CouponScreenDesktop extends StatefulWidget {
  const CouponScreenDesktop({super.key});

  @override
  State<CouponScreenDesktop> createState() => _CouponScreenDesktopState();
}

class _CouponScreenDesktopState extends State<CouponScreenDesktop> {
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
            // appBar: AppBar(c
            //   title: const Text('Apply Coupon desktop here'),
            //   centerTitle: false,
            // ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TopAppBar(),
                  Container(
                    padding: EdgeInsets.only(top: height * .10, left: width * .125),
                    width: width,
                    height: height * .20,
                    color: const Color(0xff030d4e),
                    child: const Text(
                      'Apply Coupon',
                      style: TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Container(
                    width: width,
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: ColorConstants.colorGreyTwo,
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
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
                  ...provider.coupons
                      .where((element) => element.expiryStatus == 1 && (provider.cart?.charges.grandTotal ?? 0) >= int.parse(element.cartValue))
                      .map(
                        (e) => Container(
                          width: width,
                          margin: EdgeInsets.only(bottom: 2, left: width * .12, right: width * .12),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorOffWhite,
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
                                  context.router.pop();
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
                  if (provider.coupons
                      .where((element) => element.expiryStatus == 1 && (provider.cart?.charges.grandTotal ?? 0) >= int.parse(element.cartValue))
                      .isEmpty)
                    Container(
                      width: width,
                      height: height * .4,
                      margin: EdgeInsets.symmetric(horizontal: width * .12),
                      alignment: Alignment.center,
                      child: Text(
                        'Coupons not available',
                        style: TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(height: height * .03),
                  const BottomAppBarPage(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
