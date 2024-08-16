// ignore_for_file: depend_on_referenced_packages
// ignore_for_file: avoid_web_libraries_in_flutter

/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'dart:developer';
import 'dart:html';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_razorpay_web/flutter_razorpay_web.dart';
import 'package:provider/provider.dart';

// @RoutePage(name: 'CartRoute')
class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  int stepIndex = 0;
  String selectedPayment = '';
  Shipping? selectedAddress;
  Order? _order;
  late AppProvider _appProvider;

  final DioHelper _dioHelper = DioHelper();

  //razorpay options

  openCheckout(AppProvider provider, double price) async {
    if (_order != null) {
      RazorpayWeb razorpayWeb = RazorpayWeb(onSuccess: handlePaymentSuccess, onCancel: handlePaymentCancel, onFailed: handlePaymentError);
      var razorpayAmount = price * 100;

      final Map<String, dynamic> options = {
        'key': (provider.appSettings?.paymentGateway.firstWhereOrNull((element) => element.gatway == 'razorpay'))?.key1 ?? '',
        'amount': razorpayAmount,
        'currency': 'INR',
        'image': 'https://lh3.googleusercontent.com/n-wZcjDIdIUahSl7k-Mf7d62O6_szbP2YXBuVpXSM9t4Y9EGxIRTi0pdwstdjEpSAQ',
        'order_id': _order?.paymentRefId,
        'timeout': '300',
        'description': 'Buying products',
        'prefill': {'contact': provider.currentUser?.mobileNo, 'email': provider.currentUser?.email},
        'readonly': {'contact': true, 'email': true},
        'send_sms_hash': true,
        'remember_customer': false,
        'retry': {'enabled': false},
        'hidden': {'contact': false, 'email': false}
      };

      try {
        razorpayWeb.open(options);
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
      }
    }
  }

  void handlePaymentSuccess(RpaySuccessResponse response) async {
    if (!mounted) return;
    _appProvider.initWithLogin();
    context.router.replace(HomeRoute(orderSuccess: true, order: _order));
    // orderSuccess(_order!, _appProvider);
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
            Future.delayed(const Duration(milliseconds: 1000)).then(
              (_) {
                if (!mounted) return;
                ScaffoldLoaderDialog.of(context).hide();
              },
            );
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
        // orderSuccess(temp, provider);
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

  // orderSuccess(Order order, AppProvider provider) async {
  //   await FirebaseAnalytics.instance.logPurchase(
  //     transactionId: order.id,
  //     currency: 'INR',
  //     value: order.grandTotal.toDouble(),
  //     shipping: order.shippingCost.toDouble(),
  //     tax: 0,
  //     items: List<AnalyticsEventItem>.from(order.products.map((e) => e.toGAP())),
  //   );
  //
  //   // await facebookAppEvents.logPurchase(
  //   //   amount: grandTotal ?? 0,
  //   //   currency: 'INR',
  //   // );
  // }

  // addProductsToFirebase(AppProvider provider) async {
  //   await FirebaseAnalytics.instance.logViewCart(
  //     currency: 'INR',
  //     value: _order?.grandTotal.toDouble() ?? 0,
  //     items: List<AnalyticsEventItem>.from(provider.cart!.records.map((x) => x.toGAP())),
  //   );
  // }

  // beginCheckout(AppProvider provider) async {
  //   await FirebaseAnalytics.instance.logBeginCheckout(
  //     currency: 'INR',
  //     value: _order?.grandTotal.toDouble() ?? 0,
  //     items: List<AnalyticsEventItem>.from(provider.cart!.records.map((x) => x.toGAP())),
  //   );
  //
  //   // await facebookAppEvents.logInitiatedCheckout(
  //   //   totalPrice: _cartHelper.calculateAllTotal(provider),
  //   //   currency: 'INR',
  //   // );
  // }

  // addShipping(AppProvider provider) async {
  //   await FirebaseAnalytics.instance.logAddShippingInfo(
  //     currency: 'INR',
  //     value: _order?.grandTotal.toDouble() ?? 0,
  //     items: List<AnalyticsEventItem>.from(provider.cart!.records.map((x) => x.toGAP())),
  //   );
  // }

  // addPayment(AppProvider provider) async {
  //   await FirebaseAnalytics.instance.logAddPaymentInfo(
  //     paymentType: selectedPayment,
  //     currency: 'INR',
  //     value: _order?.grandTotal.toDouble() ?? 0,
  //     items: List<AnalyticsEventItem>.from(provider.cart!.records.map((x) => x.toGAP())),
  //   );
  // }

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        // addProductsToFirebase(provider);
        return (provider.cart?.count ?? 0) > 0
            ? Scaffold(
                appBar: AppBar(
                  centerTitle: false,
                  title: const Text('Shopping Cart'),
                ),
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * .02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * .1),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (stepIndex > 0) {
                                setState(() {
                                  stepIndex = 0;
                                });
                              }
                            },
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            child: CircleAvatar(
                              radius: 17,
                              backgroundColor: stepIndex == 0 ? ColorConstants.colorPrimaryTwo : ColorConstants.colorGreySix,
                              child: const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 2,
                              color: ColorConstants.colorGreyTwo,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (stepIndex > 1) {
                                setState(() {
                                  stepIndex = 1;
                                });
                              }
                            },
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            child: CircleAvatar(
                              backgroundColor: stepIndex == 1 ? ColorConstants.colorPrimaryTwo : ColorConstants.colorGreySix,
                              radius: 17,
                              child: const Icon(
                                Icons.my_location_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 2,
                              color: ColorConstants.colorGreyTwo,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (stepIndex > 2) {
                                setState(() {
                                  stepIndex = 2;
                                });
                              }
                            },
                            splashFactory: NoSplash.splashFactory,
                            highlightColor: Colors.transparent,
                            child: CircleAvatar(
                              backgroundColor: stepIndex == 2 ? ColorConstants.colorPrimaryTwo : ColorConstants.colorGreySix,
                              radius: 17,
                              child: const Icon(
                                Icons.payment_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .01),
                    Expanded(
                      child: IndexedStack(
                        index: stepIndex,
                        children: [
                          ShoppingTabOne(
                            onCheckout: () {
                              if (provider.cart != null &&
                                  provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >=
                                      provider.appSettings!.generalSettings.itemQty) {
                                if (provider.cart!.records.any((element) => element.productType == StringConstants.noTrailProduct)) {
                                  setState(() {
                                    stepIndex = 1;
                                  });
                                } else {
                                  BuildContext? dialogContext;
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (c) {
                                      dialogContext = c;
                                      return CustomDialog(
                                        onTap: () {
                                          // dialogContext?.popRoute();
                                        },
                                        onClose: () {
                                          // dialogContext?.popRoute();
                                          setState(() {
                                            stepIndex = 1;
                                          });
                                          // beginCheckout(provider);
                                        },
                                        icon: 'assets/images/icons/sad.png',
                                        buttonName: 'Add Bonus Products',
                                        title: 'Reminder',
                                        message:
                                            'You haven\'t picked the bonus trial products.\nChoose any of the ${provider.appSettings?.generalSettings.samplesLimit ?? 2} and proceed to checkout',
                                        haveButtons: true,
                                      );
                                    },
                                  );
                                }
                              } else {
                                setState(() {
                                  stepIndex = 1;
                                });
                              }
                              // if (provider.currentUser != null &&
                              //     provider.cartItems.any((element) => element.productType == trialProduct) &&
                              //     provider.currentUser!.trialPoint - _cartHelper.calculateTrailPoints(provider) > 0) {
                              //   BuildContext? dialogContext;
                              //   showDialog(
                              //     context: context,
                              //     barrierDismissible: false,
                              //     builder: (c) {
                              //       dialogContext = c;
                              //       return CustomDialog(
                              //         onTap: () {
                              //           dialogContext?.popRoute();
                              //           dialogContext?.router.popUntilRouteWithName(NavigatorRoute.name);
                              //         },
                              //         onClose: () {
                              //           dialogContext?.popRoute();
                              //           setState(() {
                              //             stepIndex = 1;
                              //           });
                              //           beginCheckout(provider);
                              //         },
                              //         icon: 'assets/images/icons/puzzle.png',
                              //         buttonName: 'Add trials',
                              //         title: 'Heads Up!',
                              //         message:
                              //             'You still have ${_cartHelper.calculateAvailableTrialPoint(provider)} trial points left! Sure you want to proceed?',
                              //         haveButtons: true,
                              //       );
                              //     },
                              //   );
                              // } else {
                              //   setState(() {
                              //     stepIndex = 1;
                              //   });
                              // }
                            },
                          ),
                          ShoppingTabTwo(
                            changeAddress: (Shipping address) {
                              setState(() {
                                address.selected = true;
                                selectedAddress = address;
                              });
                            },
                            selectedAddress: selectedAddress,
                            onContinue: () {
                              if (selectedAddress != null) {
                                setState(() {
                                  stepIndex = 2;
                                });
                                // addShipping(provider);
                              } else {
                                ScaffoldSnackBar.of(context).show('Please select shipping address');
                              }
                            },
                          ),
                          ShoppingTabThree(
                            selectedPayment: selectedPayment,
                            onChanged: (String? v) {
                              setState(() {
                                selectedPayment = v!;
                              });
                            },
                            placeOrder: () {
                              if (provider.cart != null && provider.cart!.charges.grandTotal > 0) {
                                if (selectedPayment.isNotEmpty) {
                                  saveOrder(provider: provider);
                                } else {
                                  ScaffoldSnackBar.of(context).show('Please select payment method');
                                }
                              } else {
                                saveOrder(provider: provider);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(
                    color: Colors.black,
                  ),
                  centerTitle: false,
                  title: const Text(
                    'Shopping Cart',
                  ),
                ),
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * .1),
                    Align(
                      child: Image.asset(
                        'assets/images/shooping_cart.png',
                        height: height * .3,
                      ),
                    ),
                    Text(
                      'Your Cart is empty!',
                      style: TextHelper.titleStyle.copyWith(color: Colors.black.withOpacity(0.6)),
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'This feels too light! Go on, add all your favourites.',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextHelper.normalTextStyle,
                      ),
                    ),
                    SizedBox(height: height * .05),
                    InkWell(
                      onTap: () {
                        context.router.popUntilRouteWithName(NavigatorRoute.name);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.colorBlueEighteen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(
                          'Try Now',
                          style: TextHelper.titleStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
