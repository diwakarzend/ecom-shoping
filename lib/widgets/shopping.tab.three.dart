/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ShoppingTabThree extends StatefulWidget {
  final String selectedPayment;
  final Function(String? v) onChanged;
  final Function() placeOrder;

  const ShoppingTabThree({super.key, required this.selectedPayment, required this.onChanged, required this.placeOrder});

  @override
  State<ShoppingTabThree> createState() => _ShoppingTabThreeState();
}

class _ShoppingTabThreeState extends State<ShoppingTabThree> {
  bool paymentExpanded = true;

  final CartHelper _cartHelper = CartHelper();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => widget.onChanged(''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * .02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Payment Details',
                        style: TextHelper.subTitleStyle,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            paymentExpanded = !paymentExpanded;
                          });
                        },
                        enableFeedback: false,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        iconSize: 20,
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Icon(!paymentExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded),
                        ),
                      ),
                    ],
                  ),
                ),
                if (paymentExpanded)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Shop Mini - Service Fee (${provider.cart?.charges.miniItemQuantity} ${(provider.cart?.charges.miniItemQuantity ?? 0) > 1 ? 'items' : 'item'})',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\u{20B9}${provider.cart?.charges.serviceCharge.toStringAsFixed(2)}',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      if (provider.cart != null &&
                          provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty &&
                          provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >
                              provider.appSettings!.generalSettings.itemQty)
                        SizedBox(height: height * .02),
                      if (provider.cart != null &&
                          provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty &&
                          provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >
                              provider.appSettings!.generalSettings.itemQty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Shop Mini - Addon Product Fee (${provider.cart?.charges.addonQuantity} ${(provider.cart?.charges.addonQuantity ?? 0) > 1 ? 'items' : 'item'})',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\u{20B9}${provider.cart?.charges.addonUnitPrice.toStringAsFixed(2)}',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      if (provider.cart != null &&
                          provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).isNotEmpty)
                        SizedBox(height: height * .02),
                      if (provider.cart != null &&
                          provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Free Sample - Service Fee (${provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).length} ${provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).length > 1 ? 'items' : 'item'})',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\u{20B9}${provider.cart?.charges.bounsServiceCharge.toStringAsFixed(2)}',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.hotDealProduct).isNotEmpty)
                        SizedBox(height: height * .02),
                      if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.hotDealProduct).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Deals & Combos (${_cartHelper.hotDealCount(provider)} ${_cartHelper.hotDealCount(provider) > 1 ? 'items' : 'item'})',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\u{20B9}${provider.cart?.charges.hotDealsCharge.toStringAsFixed(2)}',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).isNotEmpty)
                        SizedBox(height: height * .02),
                      if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Bonus Trials (${provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length} ${provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length > 1 ? 'items' : 'item'})',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'FREE',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      if (widget.selectedPayment == 'cod') SizedBox(height: height * .02),
                      if (widget.selectedPayment == 'cod')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'COD Fee',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\u{20B9}${(provider.appSettings?.generalSettings.codCharge ?? 0)}',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: height * .02),
                      if (provider.cart != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'SubTotal',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '\u{20B9}${(provider.cart!.charges.subTotalWithoutDiscount + (widget.selectedPayment == 'cod' ? (provider.appSettings?.generalSettings.codCharge ?? 0) : 0)).toStringAsFixed(2)}',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      if (provider.coupon != null) SizedBox(height: height * .02),
                      if (provider.coupon != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Coupon Applied',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\u{20B9}${provider.cart?.charges.discount.toStringAsFixed(2)}',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: height * .02),
                      if (provider.cart != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w700),
                              ),
                              Text(
                                '\u{20B9}${(provider.cart!.charges.grandTotal + (widget.selectedPayment == 'cod' ? (provider.appSettings?.generalSettings.codCharge ?? 0) : 0)).toStringAsFixed(2)}',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                SizedBox(height: height * .03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Choose Your Payment Mode',
                    style: TextHelper.subTitleStyle,
                  ),
                ),
                SizedBox(height: height * .02),
                ...?provider.appSettings?.paymentGateway.where((element) => element.isActive).map(
                      (e) => Container(
                        width: width,
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              e.gatway == 'razorpay' ? 'assets/images/razorpay.svg' : 'assets/images/easebuzz.svg',
                              height: height * .03,
                            ),
                            Radio(
                              value: e.gatway,
                              groupValue: widget.selectedPayment,
                              onChanged: widget.onChanged,
                            ),
                          ],
                        ),
                      ),
                    ),
                if ((provider.cart?.charges.grandTotal ?? 0) >= 500 && (provider.cart?.charges.grandTotal ?? 0) <= 1500)
                  Container(
                    width: width,
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorConstants.colorGreenThree,
                              child: Image.asset('assets/images/cod.png'),
                            ),
                            const SizedBox(width: 15),
                            FittedBox(
                              child: Text.rich(
                                TextSpan(
                                  text: 'Pay on delivery',
                                  children: [
                                    TextSpan(
                                      text: ' (${StringConstants.rupeeSign}${(provider.appSettings?.generalSettings.codCharge ?? 0)} COD charges)',
                                      style: TextHelper.smallTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextHelper.subTitleStyle,
                              ),
                            ),
                          ],
                        ),
                        Radio(
                          value: 'cod',
                          groupValue: widget.selectedPayment,
                          onChanged: widget.onChanged,
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: height * .03),
                Container(
                  width: width,
                  color: ColorConstants.colorGreyNine,
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_rounded,
                        color: Colors.black.withOpacity(0.5),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '100% Safe Payments',
                        style: TextHelper.subTitleStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * .02),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      if ((provider.cart?.charges.grandTotal ?? 0) >= 200) {
                        widget.placeOrder();
                      } else {
                        widget.onChanged('razorpay');
                        widget.placeOrder();
                      }
                    },
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: Container(
                      width: width * .4,
                      height: height * .06,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: ColorConstants.colorBlueEighteen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Place Order',
                        style: TextHelper.subTitleStyle.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .03),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Note : All Prices Are Inclusive of GST',
                        maxLines: 5,
                        style: TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorGreyThree.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'COD available on Orders above ${StringConstants.rupeeSign}400 (COD Charge ${StringConstants.rupeeSign}${(provider.appSettings?.generalSettings.codCharge ?? 0)})',
                        maxLines: 5,
                        style: TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorGreyThree.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Delivery within 3-5 days',
                        maxLines: 5,
                        style: TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorGreyThree.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Delivery Partner',
                            maxLines: 5,
                            style: TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.colorGreyThree.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/images/ship_rocket.png',
                            height: 15,
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/images/pikkr_logo.png',
                            height: 15,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Easy Cancellations, ',
                            maxLines: 5,
                            style: TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: ColorConstants.colorGreyThree.withOpacity(0.7),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (c) => _Dialog(
                                    height: height,
                                    width: width,
                                    provider: provider,
                                  ),
                                );
                              },
                              child: Text(
                                'click to read terms and conditions',
                                maxLines: 5,
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.colorBlueFifteen,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * .1),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Dialog extends StatelessWidget {
  final AppProvider provider;
  final double height;
  final double width;

  const _Dialog({
    required this.height,
    required this.width,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Before dispatch - Simply cancel any order from your dashboard using the cancel button.',
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  style: TextHelper.smallTextStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  'In transit orders - ${StringConstants.rupeeSign}60 shall be deducted for orders in transit, users can email at care@fabpiks.com for cancellations.',
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  style: TextHelper.smallTextStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  'COD available only for orders above ${StringConstants.rupeeSign}500 at a charge of ${StringConstants.rupeeSign}${(provider.appSettings?.generalSettings.codCharge ?? 0)}.',
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  style: TextHelper.smallTextStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  'Refunds (for orders received) - upto 5 days from receipt of order, subject to user not opening any items/package. Return pick up charges - ${StringConstants.rupeeSign}60',
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  style: TextHelper.smallTextStyle,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 25,
            child: InkWell(
              onTap: () => context.router.maybePop(),
              child: Container(
                width: 40,
                height: 40,
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
