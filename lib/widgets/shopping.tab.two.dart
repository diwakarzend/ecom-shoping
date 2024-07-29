/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routes/router.gr.dart';

class ShoppingTabTwo extends StatefulWidget {
  final Shipping? selectedAddress;
  final Function(Shipping address) changeAddress;
  final Function() onContinue;

  const ShoppingTabTwo({super.key, this.selectedAddress, required this.changeAddress, required this.onContinue});

  @override
  State<ShoppingTabTwo> createState() => _ShoppingTabTwoState();
}

class _ShoppingTabTwoState extends State<ShoppingTabTwo> {
  bool paymentExpanded = true;

  late AppProvider _appProvider;

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    if (_appProvider.currentUser != null && _appProvider.currentUser!.shipping.length == 1) {
      Future.delayed(const Duration(seconds: 0)).then((value) => widget.changeAddress(_appProvider.currentUser!.shipping.first));
    }
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text(
                //         'Payment Details',
                //         style: TextHelper.subTitleStyle,
                //       ),
                //       IconButton(
                //         onPressed: () {
                //           setState(() {
                //             paymentExpanded = !paymentExpanded;
                //           });
                //         },
                //         enableFeedback: false,
                //         splashColor: Colors.transparent,
                //         highlightColor: Colors.transparent,
                //         iconSize: 20,
                //         icon: AnimatedSwitcher(
                //           duration: const Duration(milliseconds: 300),
                //           child: Icon(!paymentExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // if (paymentExpanded)
                //   Column(
                //     mainAxisSize: MainAxisSize.min,
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       if (provider.cartItems.where((element) => element.productType == trialProduct).isNotEmpty)
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 20),
                //           child: Row(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Trial Pack - Service Fee (${provider.cartItems.where((element) => element.productType == trialProduct).length} ${provider.cartItems.where((element) => element.productType == trialProduct).length > 1 ? 'items' : 'item'})',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //               Text(
                //                 '\u{20B9}${_cartHelper.calculateServiceChargeBase(provider).toStringAsFixed(2)}',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (provider.cartItems.where((element) => element.productType == brandStoreProduct).isNotEmpty) SizedBox(height: height * .02),
                //       if (provider.cartItems.where((element) => element.productType == brandStoreProduct).isNotEmpty)
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 20),
                //           child: Row(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Select Store - Service Charge (${provider.cartItems.where((element) => element.productType == brandStoreProduct).length} ${provider.cartItems.where((element) => element.productType == brandStoreProduct).length > 1 ? 'items' : 'item'})',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //               Text(
                //                 '\u{20B9}${_cartHelper.calculateBonusServiceChargeBase(provider)}',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (provider.cartItems.where((element) => element.productType == rewardStoreProduct).isNotEmpty) SizedBox(height: height * .02),
                //       if (provider.cartItems.where((element) => element.productType == rewardStoreProduct).isNotEmpty)
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 20),
                //           child: Row(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Reward Store (${provider.cartItems.where((element) => element.productType == rewardStoreProduct).length} ${provider.cartItems.where((element) => element.productType == rewardStoreProduct).length > 1 ? 'items' : 'item'})',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //               Text(
                //                 '\u{20B9}${_cartHelper.calculateRewardProductBaseTotal(provider).toStringAsFixed(2)}',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (provider.cartItems.where((element) => element.productType == hotDealProduct).isNotEmpty) SizedBox(height: height * .02),
                //       if (provider.cartItems.where((element) => element.productType == hotDealProduct).isNotEmpty)
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 20),
                //           child: Row(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Deal Store (${_cartHelper.hotDealCount(provider)} ${_cartHelper.hotDealCount(provider) > 1 ? 'items' : 'item'})',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //               Text(
                //                 '\u{20B9}${_cartHelper.calculateHotDealBaseTotal(provider).toStringAsFixed(2)}',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //             ],
                //           ),
                //         ),
                //       if (provider.cartItems.where((element) => element.productType == noTrailProduct).isNotEmpty) SizedBox(height: height * .02),
                //       if (provider.cartItems.where((element) => element.productType == noTrailProduct).isNotEmpty)
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 20),
                //           child: Row(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Bonus Trials (${provider.cartItems.where((element) => element.productType == noTrailProduct).length} ${provider.cartItems.where((element) => element.productType == noTrailProduct).length > 1 ? 'items' : 'item'})',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //               Text(
                //                 'FREE',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //             ],
                //           ),
                //         ),
                //       SizedBox(height: height * .02),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 20),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Text(
                //               'Delivery Fee',
                //               style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //             ),
                //             Text(
                //               '\u{20B9}${_cartHelper.calculateDeliveryChargeBase(provider).toStringAsFixed(2)}',
                //               style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //             ),
                //           ],
                //         ),
                //       ),
                //       SizedBox(height: height * .02),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 20),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Text(
                //               'GST',
                //               style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //             ),
                //             Text(
                //               '\u{20B9}${_cartHelper.calculateGST(provider).toStringAsFixed(2)}',
                //               style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //             ),
                //           ],
                //         ),
                //       ),
                //       if (provider.coupon != null) SizedBox(height: height * .02),
                //       if (provider.coupon != null)
                //         Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 20),
                //           child: Row(
                //             mainAxisSize: MainAxisSize.max,
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Text(
                //                 'Discount',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //               Text(
                //                 '\u{20B9}${_cartHelper.calculateDiscount(provider).toStringAsFixed(2)}',
                //                 style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                //               ),
                //             ],
                //           ),
                //         ),
                //       SizedBox(height: height * .03),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 20),
                //         child: Row(
                //           mainAxisSize: MainAxisSize.max,
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Text(
                //               'Total',
                //               style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w600),
                //             ),
                //             Text(
                //               '\u{20B9}${_cartHelper.calculateAllTotal(provider).toStringAsFixed(2)}',
                //               style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w600),
                //             ),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                SizedBox(height: height * .02),
                if (provider.currentUser != null)
                  ...provider.currentUser!.shipping.map(
                    (e) => Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  e.shippingName,
                                  style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Radio(
                                value: true,
                                toggleable: true,
                                visualDensity: VisualDensity.adaptivePlatformDensity,
                                groupValue: widget.selectedAddress != null && widget.selectedAddress?.id == e.id,
                                onChanged: (v) {
                                  widget.changeAddress(e);
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: height * .01),
                          Text(
                            e.shippingAddress,
                            maxLines: 5,
                            style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${e.shippingCity}, ${e.shippingState} ${e.shippingPincode}',
                            maxLines: 5,
                            style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.router.push(EditAddressRoute(shipping: e));
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: ColorConstants.colorPrimaryTwo,
                                  textStyle: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  'Change/Edit',
                                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.router.push(AddAddressRoute(fromCart: true));
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: ColorConstants.colorPrimaryTwo,
                                  textStyle: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  'Add New Address',
                                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                if (provider.currentUser != null && provider.currentUser!.shipping.isEmpty)
                  Align(
                    alignment: Alignment.topCenter,
                    child: TextButton(
                      style: TextButton.styleFrom(foregroundColor: ColorConstants.colorPrimary),
                      onPressed: () {
                        context.router.push(AddAddressRoute(fromCart: true));
                      },
                      child: const Text('Add New Address'),
                    ),
                  ),
                SizedBox(height: height * .02),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: widget.onContinue,
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
                        'Continue',
                        style: TextHelper.titleStyle.copyWith(color: Colors.white),
                      ),
                    ),
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
