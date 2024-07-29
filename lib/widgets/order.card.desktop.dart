/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderCardDesktop extends StatefulWidget {
  final Order order;

  const OrderCardDesktop({super.key, required this.order});

  @override
  State<OrderCardDesktop> createState() => _OrderCardDesktopState();
}

class _OrderCardDesktopState extends State<OrderCardDesktop> {
  late AppProvider _appProvider;

  final DioHelper _dioHelper = DioHelper();

  String orderStatus() {
    if (widget.order.cancelRequest != 1) {
      switch (widget.order.status.toLowerCase()) {
        case 'pending':
          return 'pending';
        case 'accept':
          return 'pending';
        case 'accepted':
          return 'accepted';
        default:
          return widget.order.status.toLowerCase();
      }
    } else {
      if (widget.order.cancelRequest == 1 && widget.order.status == 'cancelled') {
        return 'cancelled';
      } else if (widget.order.cancelRequest == 1 && widget.order.status == 'accepted') {
        return 'cancellation request';
      } else {
        switch (widget.order.status.toLowerCase()) {
          case 'pending':
            return 'pending';
          case 'accept':
            return 'pending';
          case 'accepted':
            return 'accepted';
          default:
            return widget.order.status.toLowerCase();
        }
      }
    }
  }

  cancelOrder(Order order) async {
    Future.delayed(const Duration(seconds: 0)).then(
      (value) => ScaffoldLoaderDialog.of(context).hide(),
    );
    try {
      final response = await _dioHelper.get(
        'order-cancel/${order.id}',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${_appProvider.loginDetails?.token}',
          },
        ),
      );
      if (response != null && response.data['status']) {
        _appProvider.initWithLogin();
      }
      if (!mounted) return;
      context.popRoute();
    } on DioException catch (_, e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      // onTap: () => orderStatus() == 'cancelled' ? null : context.router.push(OrderDetailsRoute(order: widget.order)),
      onTap: () => context.router.push(OrderDetailsRoute(orderId: widget.order.id)),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorConstants.colorGreenSix,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Order No. #${widget.order.orderNumber}'.toUpperCase(),
                  style: TextHelper.extraSmallTextStyle.copyWith(color: ColorConstants.colorBlack.withOpacity(0.8), fontWeight: FontWeight.bold,fontSize: 11.sp),
                ),
                if (orderStatus() == 'accepted' && widget.order.cancelRequest == 0)
                  InkWell(
                    onTap: () {
                      BuildContext? dialogContext;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (c) {
                          dialogContext = c;
                          return CustomDialog(
                            onTap: () {
                              dialogContext?.popRoute();
                              cancelOrder(widget.order);
                            },
                            on2ndButtonClicked: () {
                              dialogContext?.popRoute();
                            },
                            icon: 'assets/images/icons/sad.png',
                            buttonName: 'Yes',
                            buttonName2: 'No',
                            have2ndButton: true,
                            title: '',
                            message: 'Are you sure you want to cancel this order?',
                            haveButtons: true,
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: ColorConstants.colorRed,
                        borderRadius: BorderRadius.circular(70),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextHelper.extraSmallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  '${DateFormat('dd MMM y').format(widget.order.orderDate)} | ${DateFormat('hh:mm').format(widget.order.orderDate)}',
                  style: TextHelper.smallTextStyle.copyWith(
                    color: ColorConstants.colorBlack.withOpacity(0.8),
                    fontWeight: FontWeight.w500,fontSize: 13.sp,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.order.products.length > 5)
                  ...widget.order.products
                      .take(5)
                      .toList()
                      .asMap()
                      .map(
                        (index, product) => MapEntry(
                          index,
                          Container(
                            width: width * .02,
                            height: width * .02,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.colorOffWhite,
                            ),
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.center,
                            child: CustomNetworkImage(
                              imageUrl: product.image,
                              width: width * .02,
                              height: width * .02,
                            ),
                          ),
                        ),
                      )
                      .values,
                if (widget.order.products.length > 5)
                  Container(
                    width: width * .02,
                    height: width * .02,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.colorOffWhite,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+${widget.order.products.length - 5}',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.sp,
                      ),
                    ),
                  )
                else
                  ...widget.order.products
                      .asMap()
                      .map(
                        (index, product) => MapEntry(
                          index,
                          Container(
                            width: width * .02,
                            height: width * .02,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.colorOffWhite,
                            ),
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.center,
                            child: CustomNetworkImage(
                              imageUrl: product.image,
                              width: width * .02,
                              height: width * .02,
                            ),
                          ),
                        ),
                      )
                      .values
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Status',
                        style: TextHelper.extraSmallTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.colorGreyThree.withOpacity(0.5),fontSize: 10.sp,
                        ),
                      ),
                      if (widget.order.courierStatus.isEmpty)
                        Text(
                          orderStatus().toUpperCase(),
                          maxLines: 2,
                          style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 9.sp,
                            color: orderStatus() == 'cancelled'
                                ? Colors.red
                                : widget.order.status.toLowerCase() == 'accepted'
                                    ? Colors.red
                                    : widget.order.status.toLowerCase() == 'delivered'
                                        ? ColorConstants.colorGreen
                                        : ColorConstants.colorYellowThree,
                          ),
                        )
                      else
                        Text(
                          widget.order.courierStatus,
                          maxLines: 2,
                          style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorConstants.colorYellowThree,
                            fontSize: 10.sp,
                          ),
                        )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Products',
                        style: TextHelper.extraSmallTextStyle.copyWith(fontWeight: FontWeight.bold, color: ColorConstants.colorGreyThree.withOpacity(0.5),fontSize: 10.sp),
                      ),
                      Text(
                        widget.order.products.length.toString(),
                        style: TextHelper.extraSmallTextStyle
                            .copyWith(fontWeight: FontWeight.bold, color: ColorConstants.colorGreyThree.withOpacity(0.8), fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Price',
                        style: TextHelper.extraSmallTextStyle.copyWith(fontWeight: FontWeight.bold, color: ColorConstants.colorGreyThree.withOpacity(0.5),fontSize: 10.sp),
                      ),
                      Text(
                        '\u{20B9}${widget.order.grandTotal.toDouble().toStringAsFixed(2)}',
                        style: TextHelper.extraSmallTextStyle
                            .copyWith(fontWeight: FontWeight.bold, color: ColorConstants.colorGreyThree.withOpacity(0.8), fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
