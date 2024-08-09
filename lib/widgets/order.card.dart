/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
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
      (value) {
        if (mounted) ScaffoldLoaderDialog.of(context).hide();
      },
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
      context.maybePop();
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
        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        padding: const EdgeInsets.all(20),
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
                  style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack.withOpacity(0.8)),
                ),
                if (orderStatus() == 'accepted' && widget.order.cancelRequest == 0)
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (c) {
                          return _Dialog(
                            onTap: () {
                              cancelOrder(widget.order);
                            },
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
                  style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack.withOpacity(0.8)),
                ),
              ],
            ),
            const SizedBox(height: 15),
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
                            width: width * .1,
                            height: width * .1,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.colorOffWhite,
                            ),
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.center,
                            child: CustomNetworkImage(
                              imageUrl: product.image,
                              width: width * .1,
                              height: width * .1,
                            ),
                          ),
                        ),
                      )
                      .values,
                if (widget.order.products.length > 5)
                  Container(
                    width: width * .1,
                    height: width * .1,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.colorOffWhite,
                    ),
                    alignment: Alignment.center,
                    child: Text('+${widget.order.products.length - 5}'),
                  )
                else
                  ...widget.order.products
                      .asMap()
                      .map(
                        (index, product) => MapEntry(
                          index,
                          Container(
                            width: width * .1,
                            height: width * .1,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorConstants.colorOffWhite,
                            ),
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.center,
                            child: CustomNetworkImage(
                              imageUrl: product.image,
                              width: width * .1,
                              height: width * .1,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Status',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorGreyThree.withOpacity(0.5),
                        ),
                      ),
                      if (widget.order.courierStatus.isEmpty)
                        Text(
                          orderStatus().toUpperCase(),
                          maxLines: 2,
                          style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
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
                            fontWeight: FontWeight.w600,
                            color: ColorConstants.colorYellowThree,
                          ),
                        )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Products',
                        style: TextHelper.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w600, color: ColorConstants.colorGreyThree.withOpacity(0.5)),
                      ),
                      Text(
                        widget.order.products.length.toString(),
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w600, color: ColorConstants.colorGreyThree.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Price',
                        style: TextHelper.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w600, color: ColorConstants.colorGreyThree.withOpacity(0.5)),
                      ),
                      Text(
                        '\u{20B9}${widget.order.grandTotal.toDouble().toStringAsFixed(2)}',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w600, color: ColorConstants.colorGreyThree.withOpacity(0.8)),
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

class _Dialog extends StatelessWidget {
  final Function() onTap;

  const _Dialog({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: width,
            constraints: BoxConstraints(
              minHeight: height * .25,
              maxHeight: height * .7,
            ),
            // height: height * .4,
            margin: EdgeInsets.symmetric(horizontal: width * .05, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(horizontal: width * .05),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * .1),
                Text.rich(
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: ' Are you sure you want to cancel this order?',
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.colorBlack,
                      height: 1.3,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                SizedBox(height: height * .05 - 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.router.maybePop();
                          onTap();
                        },
                        child: Container(
                          width: width * .5,
                          height: height * .045,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorBrown,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Yes',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.router.maybePop();
                        },
                        child: Container(
                          width: width * .5,
                          height: height * .045,
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorBrown,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'No',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              transform: Matrix4.translationValues(0, -width * .125, 0),
              width: width * .3,
              height: width * .3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.colorGreenSeven.withOpacity(0.2),
              ),
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.colorGreenSeven.withOpacity(0.2),
                ),
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.colorGreenSeven.withOpacity(0.2),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.colorGreenSeven.withOpacity(1),
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      'assets/images/icons/puzzle.png',
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 30,
            top: 0,
            child: GestureDetector(
              onTap: () {
                context.router.maybePop();
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.colorOffWhite,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.clear_rounded,
                  color: ColorConstants.colorBlack,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
