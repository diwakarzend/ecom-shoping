// ignore_for_file: depend_on_referenced_packages

/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */
// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_razorpay_web/flutter_razorpay_web.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage(name: 'ShoppingTabThreeDesktop')
class ShoppingTabThreeDesktop extends StatefulWidget {
  final String addressId;

  const ShoppingTabThreeDesktop({
    super.key,
    @PathParam('id') required this.addressId,
  });

  @override
  State<ShoppingTabThreeDesktop> createState() => _ShoppingTabThreeDesktopState();
}

class _ShoppingTabThreeDesktopState extends State<ShoppingTabThreeDesktop> {
  bool paymentExpanded = true;
  String selectedPayment = '';

  final CartHelper _cartHelper = CartHelper();
  Order? _order;
  final DioHelper _dioHelper = DioHelper();

  late AppProvider _appProvider;

  Shipping? selectedAddress;

  initAddress(AppProvider provider) {
    selectedAddress = provider.currentUser?.shipping.firstWhereOrNull((element) => element.id == widget.addressId);
  }

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  String generateSha256(String orderId, String amount) {
    String value =
        'apiKey=15c920d0928a4f79903b19733fd5d1fe~clientId=4827460565764284~amount=$amount~orderId=${orderId}rAiaB9hKSl6iB';
    // String value =
    //     'apiKey=15c920d0928a4f79903b19733fd5d1fe~clientId=4827460565764284~amount=1~orderId=85858585MNNRrAiaB9hKSl6iB';
    log(value);
    var bytes = utf8.encode(value);
    var digest = sha256.convert(bytes);
    return digest.toString().toUpperCase();
  }

  Timer? _timer;

  initTimer({
    required String amount,
    required String orderId,
    required String apiToken,
    required String idToken,
    required bool qr,
  }) async {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) async {
        try {
          Dio dio = Dio();
          final Response finalRsp = await dio.get(
            'https://collect.ship9x.com/collect-service/api/upi/check/status/$orderId',
            options: Options(
              headers: {
                'Accept': 'application/json',
                'api-Authorization': 'Bearer $apiToken',
                'Authorization': 'Bearer $idToken',
              },
            ),
          );
          final finData = finalRsp.data as Map<String, dynamic>;
          if (finData.containsKey('success') && finData['success']) {
            if (finData['data']['orderStatus'] == 'SUCCESS') {
              if (mounted) context.router.maybePopTop();
              _timer?.cancel();
              successOrder(_appProvider);
            } else if (finData['data']['orderStatus'] == 'FAILED') {
              if (!mounted) return;
              context.router.maybePopTop();
              _timer?.cancel();
              final rsp = await cancelApi(finData['msg'] ?? '');
              if (rsp?.data == 'Success') {
                if (!mounted) return;
                showDialog(
                  context: context,
                  builder: (c) => const AlertDialog(
                    title: Text('Payment Failed!!'),
                    content: Text("Seems like, Payment did not complete. Don't worry, "
                        'We will add your money to wallet once we receive confirmation from bank'),
                  ),
                );
              }
            }
          } else if (finData.containsKey('success') && !finData['success'] && finData.containsKey('msg')) {
            if (!mounted) return;
            context.router.maybePopTop();
            _timer?.cancel();
            final rsp = await cancelApi(finData['msg'] ?? '');
            if (rsp?.data == 'Success') {
              if (!mounted) return;
              showDialog(
                context: context,
                builder: (c) => const AlertDialog(
                  title: Text('Payment Failed!!'),
                  content: Text("Seems like, Payment did not complete. Don't worry, "
                      'We will add your money to wallet once we receive confirmation from bank'),
                ),
              );
            }
          }
        } on DioException catch (e, _) {
          log(e.response?.data.toString() ?? '');
        }
      },
    );
  }

  successOrder(AppProvider provider) async {
    await _dioHelper.post(
      'ordder-accept',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'id': _order?.id,
      },
    );
  }

  openCheckout(AppProvider provider, double price) async {
    if (_order != null) {
      final response = await _dioHelper.dio.post(
        'https://collect.ship9x.com/collect-service/api/authenticateByHash',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        ),
        // "4d6ada1aed0aa695455cd87e37a6b82ef25ccb984418092552a95a418da23453"
        // "02BA2331B1CBA2C25CDC4A6A71C1BEFFFFED46C2ED7BBF6646BAE83A16C9CC0E"
        data: {
          'amount': _order?.grandTotal,
          'apiKey': '15c920d0928a4f79903b19733fd5d1fe',
          'orderId': _order?.id,
          'clientId': '4827460565764284',
          'hash': generateSha256(_order?.id ?? '', _order?.grandTotal.toString() ?? '0'),
        },
      );
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data.containsKey('api_token') && data.containsKey('id_token') && data.containsKey('userName')) {
          final rr = await _dioHelper.dio.post(
            'https://collect.ship9x.com/collect-service/api/upi/get-dynamic-qr-collect',
            options: Options(
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'api-authorization': 'Bearer ${data['api_token']}',
                'Authorization': 'Bearer ${data['id_token']}',
              },
            ),
            data: {
              'amount': _order?.grandTotal,
              'orderId': _order?.id,
              'customerEmail': provider.currentUser?.email ?? 'email@email.com',
              'customerMobile': provider.currentUser?.mobileNo ?? '',
              'transactionRemark': 'test',
              // 'payerVpa': 'fpay.shipan@finobank'
            },
          );
          if (rr.statusCode == 200) {
            initTimer(
              amount: _order?.grandTotal.toString() ?? '',
              orderId: _order?.id ?? '',
              apiToken: data['api_token'],
              idToken: data['id_token'],
              qr: true,
            );
            if (!mounted) return;
            final Uint8List qrImage = base64Decode(rr.data['data']['code']);
            showDialog(
              context: context,
              builder: (c) => _PayNow(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                total:
                    '\u{20B9}${(provider.cart!.charges.grandTotal + (selectedPayment == 'cod' ? (provider.appSettings?.generalSettings.codCharge ?? 0) : 0)).toStringAsFixed(2)}',
                image: qrImage,
              ),
            );
          }
        }
      }
    }
  }

  void handlePaymentSuccess(RpaySuccessResponse response) async {
    if (!mounted) return;
    _appProvider.initWithLogin();
    context.router.replace(HomeRoute(orderSuccess: true, order: _order));
  }

  void handlePaymentCancel(RpayCancelResponse response) {
    cancelApi(response.desc);
    try {
      ScaffoldSnackBar.of(context).show('Payment failed ${response.desc}');
    } catch (e) {
      log(e.toString());
    }
  }

  void handlePaymentError(RpayFailedResponse response) async {
    // razorpayModel = null;
    // if (mounted) setState(() {});
    cancelApi(response.desc);
    try {
      ScaffoldSnackBar.of(context).show('Payment failed ${response.desc}');
    } catch (e) {
      log(e.toString());
    }
  }

  cancelApi(String msg) async {
    await _dioHelper.get('temp-instant-cancel/${_order?.id}?message=$msg');
  }

  // razorpay options

  saveOrder({required AppProvider provider}) async {
    if (selectedPayment != 'cod') {
      if (_order != null && _order?.paymentMode == selectedPayment) {
        if (selectedPayment == 'razorpay') {
          openCheckout(provider, _order?.grandTotal.toDouble() ?? 0);
        } else {
          window.location.href = _order?.intUrl ?? '';
        }
      } else {
        try {
          ScaffoldLoaderDialog.of(context).show();
        } catch (e) {
          debugPrint(e.toString());
        }

        final response = await _dioHelper.post(
          'order2',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: {
            'payment_mode': selectedPayment,
            'shipping_id': selectedAddress?.id,
            'coupon_id': provider.coupon?.id,
            'f_url': '${provider.appSettings?.generalSettings.webAppUrl}/payment-failed',
            's_url': '${provider.appSettings?.generalSettings.webAppUrl}/payment-success',
          },
        );

        if (response != null && response.data['status']) {
          if (mounted) {
            setState(() {
              _order = Order.fromJson(response.data['data']);
            });
            ScaffoldLoaderDialog.of(context).hide();
            if (selectedPayment == 'razorpay') {
              openCheckout(provider, _order?.grandTotal.toDouble() ?? 0);
            } else {
              window.location.href = _order?.intUrl ?? '';
            }
          }
        } else {
          provider.initWithLogin();
          try {
            String msg = response?.data['msg'] ?? 'Something went wrong';
            if (msg.contains('out of stock please remove the product')) {
              // String productString = msg.replaceAll('out of stock please remove the product ', '').toString();
              // productString = productString.replaceAll('`', '');
              // provider.removeCartItemsWithName(productString);
              // if (mounted) {
              //   setState(() {
              //     stepIndex = 0;
              //   });
              // }
              if (!mounted) return;
              context.router.popUntilRouteWithName(ShoppingTabOneDesktop.name);
              ScaffoldSnackBar.of(context).show(msg);
              ScaffoldLoaderDialog.of(context).hide();
            } else {
              if (!mounted) return;
              ScaffoldSnackBar.of(context).show(response?.data['msg'] ?? 'Something went wrong');
              ScaffoldLoaderDialog.of(context).hide();
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      }
    } else {
      try {
        ScaffoldLoaderDialog.of(context).show();
      } catch (e) {
        debugPrint(e.toString());
      }

      final response = await _dioHelper.post(
        'order',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'payment_mode': selectedPayment,
          'shipping_id': selectedAddress?.id,
          'coupon_id': provider.coupon?.id,
        },
      );
      if (response != null && response.data['status']) {
        // provider.cartReset();
        provider.initWithLogin();
        Order temp = Order.fromJson(response.data['data']);
        if (!mounted) return;
        ScaffoldLoaderDialog.of(context).hide();
        if (!mounted) return;
        context.router.maybePop();
        if (!mounted) return;
        context.router.replace(HomeRoute(orderSuccess: true, order: temp));
      } else {
        provider.initWithLogin();
        try {
          String msg = response?.data['msg'] ?? 'Something went wrong';
          if (msg.contains('out of stock please remove the product')) {
            // String productString = msg.replaceAll('out of stock please remove the product ', '').toString();
            // productString = productString.replaceAll('`', '');
            // provider.removeCartItemsWithName(productString);
            // if (mounted) {
            //   setState(() {
            //     stepIndex = 0;
            //   });
            // }
            if (!mounted) return;
            context.router.popUntilRouteWithName(ShoppingTabOneDesktop.name);
            ScaffoldSnackBar.of(context).show(msg);
            ScaffoldLoaderDialog.of(context).hide();
          } else {
            if (!mounted) return;
            ScaffoldSnackBar.of(context).show(response?.data['msg'] ?? 'Something went wrong');
            ScaffoldLoaderDialog.of(context).hide();
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }
  }

  // static final facebookAppEvents = FacebookAppEvents();

  bool supportExpanded = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        initAddress(provider);
        return Scaffold(
          drawer: CustomDrawerDesktop(
            provider: provider,
            onSupportExtend: () {
              setState(() {
                supportExpanded = !supportExpanded;
              });
            },
            supportExpanded: supportExpanded,
            cartHelper: _cartHelper,
          ),
          body: Container(
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
                  const TopAppBar(),
                  SizedBox(height: height * .06),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Payment Details',
                          style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
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
                            child: Icon(
                                !paymentExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (paymentExpanded)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * .12),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (provider.cart != null &&
                              provider.cart!.records
                                  .where((element) => element.productType == StringConstants.trialProduct)
                                  .isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Shop Mini - Service Fee (${provider.cart?.charges.miniItemQuantity} ${(provider.cart?.charges.miniItemQuantity ?? 0) > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.serviceCharge.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          if (provider.cart != null &&
                              provider.cart!.records
                                  .where((element) => element.productType == StringConstants.trialProduct)
                                  .isNotEmpty &&
                              provider.cart!.records
                                      .where((element) => element.productType == StringConstants.trialProduct)
                                      .length >
                                  provider.appSettings!.generalSettings.itemQty)
                            SizedBox(height: height * .02),
                          if (provider.cart != null &&
                              provider.cart!.records
                                  .where((element) => element.productType == StringConstants.trialProduct)
                                  .isNotEmpty &&
                              provider.cart!.records
                                      .where((element) => element.productType == StringConstants.trialProduct)
                                      .length >
                                  provider.appSettings!.generalSettings.itemQty)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Shop Mini - Addon Product Fee (${provider.cart?.charges.addonQuantity} ${(provider.cart?.charges.addonQuantity ?? 0) > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.addonUnitPrice.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          if (provider.cart != null &&
                              provider.cart!.records
                                  .where((element) => element.productType == StringConstants.brandStoreProduct)
                                  .isNotEmpty)
                            SizedBox(height: height * .02),
                          if (provider.cart != null &&
                              provider.cart!.records
                                  .where((element) => element.productType == StringConstants.brandStoreProduct)
                                  .isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Free Sample - Service Fee (${provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).length} ${provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).length > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.bounsServiceCharge.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          if (provider.cart != null &&
                              provider.cart!.records
                                  .where((element) => element.productType == StringConstants.hotDealProduct)
                                  .isNotEmpty)
                            SizedBox(height: height * .02),
                          if (provider.cart != null &&
                              provider.cart!.records
                                  .where((element) => element.productType == StringConstants.hotDealProduct)
                                  .isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Deals & Combos (${_cartHelper.hotDealCount(provider)} ${_cartHelper.hotDealCount(provider) > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.hotDealsCharge.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          if (provider.cart != null &&
                              provider.cart!.records
                                  .where((element) => element.productType == StringConstants.noTrailProduct)
                                  .isNotEmpty)
                            SizedBox(height: height * .02),
                          if (provider.cart != null &&
                              provider.cart!.records
                                  .where((element) => element.productType == StringConstants.noTrailProduct)
                                  .isNotEmpty)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Bonus Trials (${provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length} ${provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length > 1 ? 'items' : 'item'})',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  'FREE',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          if (selectedPayment == 'cod') SizedBox(height: height * .02),
                          if (selectedPayment == 'cod')
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'COD Fee',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${(provider.appSettings?.generalSettings.codCharge ?? 0)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          SizedBox(height: height * .02),
                          if (provider.cart != null)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'SubTotal',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                                ),
                                Text(
                                  '\u{20B9}${(provider.cart!.charges.subTotalWithoutDiscount + (selectedPayment == 'cod' ? (provider.appSettings?.generalSettings.codCharge ?? 0) : 0)).toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                                ),
                              ],
                            ),
                          if (provider.coupon != null) SizedBox(height: height * .02),
                          if (provider.coupon != null && provider.cart != null)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Coupon Applied',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                                Text(
                                  '\u{20B9}${provider.cart?.charges.discount.toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          SizedBox(height: height * .02),
                          if (provider.cart != null)
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Total',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                                ),
                                Text(
                                  '\u{20B9}${(provider.cart!.charges.grandTotal + (selectedPayment == 'cod' ? (provider.appSettings?.generalSettings.codCharge ?? 0) : 0)).toStringAsFixed(2)}',
                                  style:
                                      TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  SizedBox(height: height * .03),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: width * .12),
                  //   alignment: Alignment.center,
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.max,
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Choose Your Payment Mode',
                  //         style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: height * .02),
                  // ...?provider.appSettings?.paymentGateway.where((element) => element.isActive).map(
                  //       (e) => Container(
                  //         margin: EdgeInsets.symmetric(horizontal: width * .12),
                  //         alignment: Alignment.center,
                  //         child: Container(
                  //           width: width,
                  //           margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             border: Border(
                  //               bottom: BorderSide(
                  //                 color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                  //               ),
                  //             ),
                  //           ),
                  //           padding: const EdgeInsets.symmetric(vertical: 5),
                  //           child: Row(
                  //             mainAxisSize: MainAxisSize.max,
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment: CrossAxisAlignment.center,
                  //             children: [
                  //               SvgPicture.asset(
                  //                 e.gatway == 'razorpay' ? 'assets/images/razorpay.svg' : 'assets/images/easebuzz.svg',
                  //                 height: height * .06,
                  //               ),
                  //               Radio(
                  //                 value: e.gatway,
                  //                 groupValue: selectedPayment,
                  //                 onChanged: (v) {
                  //                   setState(() {
                  //                     selectedPayment = v!;
                  //                   });
                  //                 },
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  if ((provider.cart?.charges.grandTotal ?? 0) >= 500 &&
                      (provider.cart?.charges.grandTotal ?? 0) <= 1500)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * .12),
                      alignment: Alignment.center,
                      child: Container(
                        width: width,
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
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
                                      style: TextHelper.extraSmallTextStyle
                                          .copyWith(fontSize: 13.sp, fontWeight: FontWeight.bold),
                                      children: [
                                        TextSpan(
                                          text:
                                              ' (${StringConstants.rupeeSign}${(provider.appSettings?.generalSettings.codCharge ?? 0)} COD charges)',
                                          style: TextHelper.extraSmallTextStyle
                                              .copyWith(fontSize: 13.sp, fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    style: TextHelper.smallTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            Radio(
                              value: 'cod',
                              groupValue: selectedPayment,
                              onChanged: (v) {
                                setState(() {
                                  selectedPayment = v!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: height * .03),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Container(
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
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * .02),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          if (provider.cart != null && provider.cart!.charges.grandTotal > 0) {
                            // if (selectedPayment.isNotEmpty) {
                            setState(() {
                              selectedPayment = 'razorpay';
                            });
                            saveOrder(provider: provider);
                            // } else {
                            //   ScaffoldSnackBar.of(context).show('Please select payment method');
                            // }
                          } else {
                            saveOrder(provider: provider);
                          }
                        },
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        child: Container(
                          width: width * .3,
                          height: height * .06,
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorBlueEighteen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Place Order',
                            style: TextHelper.smallTextStyle
                                .copyWith(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Note : All Prices Are Inclusive of GST',
                          maxLines: 5,
                          style: TextHelper.extraSmallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: ColorConstants.colorGreyThree.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'COD available on Orders above ${StringConstants.rupeeSign}400 (COD Charge ${StringConstants.rupeeSign}${(provider.appSettings?.generalSettings.codCharge ?? 0)})',
                          maxLines: 5,
                          style: TextHelper.extraSmallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            color: ColorConstants.colorGreyThree.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Delivery within 3-5 days',
                          maxLines: 5,
                          style: TextHelper.extraSmallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
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
                              style: TextHelper.extraSmallTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: ColorConstants.colorGreyThree.withOpacity(0.7),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/images/ship_rocket.png',
                              height: 20,
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/images/pikkr_logo.png',
                              height: 20,
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
                              style: TextHelper.extraSmallTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
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
                                  style: TextHelper.extraSmallTextStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
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
    return AlertDialog(
      contentPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      content: Stack(
        children: [
          Container(
            width: (Device.width >= 1024) ? width * .15 : width,
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
                  style: TextHelper.extraSmallTextStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  'In transit orders - ${StringConstants.rupeeSign}60 shall be deducted for orders in transit, users can email at care@Amanapay.com for cancellations.',
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  style: TextHelper.extraSmallTextStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  'COD available only for orders above ${StringConstants.rupeeSign}500 at a charge of ${StringConstants.rupeeSign}${(provider.appSettings?.generalSettings.codCharge ?? 0)}.',
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  style: TextHelper.extraSmallTextStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  'Refunds (for orders received) - upto 5 days from receipt of order, subject to user not opening any items/package. Return pick up charges - ${StringConstants.rupeeSign}60',
                  maxLines: 1000,
                  textAlign: TextAlign.center,
                  style: TextHelper.extraSmallTextStyle,
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

class _PayNow extends StatelessWidget {
  final double height, width;
  final String total;
  final Uint8List image;

  const _PayNow({required this.height, required this.width, required this.total, required this.image});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Scan QR to Pay',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * .02),
          Image.memory(image, width: height * .4),
          SizedBox(height: height * .02),
          Text(
            'Order Amount $total',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * .02),
          ElevatedButton(
            onPressed: () {
              context.router.maybePopTop();
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: ColorConstants.colorPrimary, foregroundColor: Colors.white),
            child: const Text('Cancel'),
          ),
          SizedBox(height: height * .02),
        ],
      ),
    );
  }
}
