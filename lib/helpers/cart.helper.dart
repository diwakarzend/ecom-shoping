// ignore_for_file: depend_on_referenced_packages

/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/already.added.dart';

class CartHelper {
  static final CartHelper _instance = CartHelper._internal();

  late UrlHelper _urlHelper;

  CartHelper._internal() {
    initialize();
  }

  factory CartHelper() {
    return _instance;
  }

  initialize() {
    _urlHelper = UrlHelper.internal();
  }

  double ratingCalculationWishlist(AppProvider provider, WishlistItem product) {
    double rating = 0;
    for (var r in provider.feedbacks.where((element) => element.productId == product.productId)) {
      rating += r.quality;
    }
    int reviews = provider.feedbacks.where((element) => element.productId == product.productId).length;
    return rating > 0 ? rating / reviews : 0;
  }

  double ratingCalculation(AppProvider provider, Product product) {
    double rating = 0;
    for (var r in provider.feedbacks.where((element) => element.productId == product.id)) {
      rating += r.quality;
    }
    int reviews = provider.feedbacks.where((element) => element.productId == product.id).length;
    return rating > 0 ? rating / reviews : 0;
  }

  String getTime(DateTime time) {
    DateTime now = DateTime.now();
    String when;
    if (time.day == now.day) {
      when = DateFormat.jm().format(time);
    } else if (time.day == now.subtract(const Duration(days: 1)).day) {
      when = 'Yesterday';
    } else {
      when = DateFormat('d MMM, yyyy').format(time);
    }
    return when;
  }

  String trialStatus(AppProvider provider, Product product) {
    final GeneralSettings? settings = provider.appSettings?.generalSettings;
    if (settings != null && provider.cart != null) {
      if (provider.cart!.records.any((element) => element.id == product.id)) {
        return 'already_added';
      } else if (provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).isEmpty) {
        return 'first_item';
      } else if ((settings.itemQty - 1) > provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length) {
        return 'items_left';
      } else if (provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >= (settings.itemQty - 1)) {
        if (provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length == (settings.itemQty - 1)) {
          return 'item_complete';
        } else if (provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length > (settings.itemQty - 1) &&
            provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length <
                ((settings.itemQty + settings.addonQty) - 1)) {
          return 'addon_item_left';
        } else if (provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >=
            (settings.itemQty + settings.addonQty)) {
          return 'all_product_added';
        } else {
          return 'cart_complete';
        }
      } else if (provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >=
          (settings.itemQty + settings.addonQty)) {
        return 'all_product_added';
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  int calculateProductOrderLength(AppProvider provider, Product product) {
    List<String> valuesToCheck = ['cancelled', 'failed'];
    int count = provider.currentUser!.orders
        .where((element) => element.products.any((p) => p.id == product.id) && !valuesToCheck.contains(element.status.toLowerCase()))
        .length;
    return count;
  }

  void tryNow({required AppProvider provider, required BuildContext context, required String productId, bool fromProductPage = false}) {
    final Product? product = provider.miniProducts.firstWhereOrNull((element) => element.id == productId);
    if (provider.appSettings != null && provider.cart != null && product != null) {
      if (provider.currentUser != null) {
        if (calculateProductOrderLength(provider, product) < product.maximumQty) {
          switch (trialStatus(provider, product)) {
            case 'already_added':
              // ScaffoldBanner.of(context).show('Already added to cart!');
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  return Alreadyadded(
                    onTap: () {
                      context.router.maybePop();
                    },
                    icon: 'assets/images/icons/happy.png',
                    buttonName: '',
                    title: 'Already added to cart!',
                    message: '',
                    // message: ' add ${(provider.appSettings?.generalSettings.itemQty ?? 0) - 1} more products to complete your cart',
                    haveButtons: true,
                  );
                },
              );

              break;
            case 'first_item':
              provider.addCartItems(productID: productId);
              BuildContext? dialogContext;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  dialogContext = c;
                  return CustomDialog(
                    onTap: () {
                      if (fromProductPage) {
                        dialogContext?.router.popUntilRouteWithName(NavigatorRoute.name);
                      } else {
                        dialogContext?.maybePop();
                      }
                    },
                    icon: 'assets/images/icons/happy.png',
                    buttonName: 'Add more minis',
                    title: 'Great choice',
                    message: 'You have to choose minimum of ${(provider.appSettings?.generalSettings.itemQty ?? 0)} products! ',
                    // message: ' add ${(provider.appSettings?.generalSettings.itemQty ?? 0) - 1} more products to complete your cart',
                    haveButtons: true,
                  );
                },
              );
              ScaffoldBanner.of(context).show('Products added to cart!');
              break;
            case 'items_left':
              provider.addCartItems(productID: productId);
              BuildContext? dialogContext;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  dialogContext = c;
                  return CustomDialog(
                    onTap: () {
                      dialogContext?.maybePop();
                    },
                    icon: 'assets/images/icons/happy.png',
                    buttonName: 'Add more minis',
                    title: '',
                    message:
                        'Please add ${provider.appSettings!.generalSettings.itemQty - provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length} more products to complete your cart',
                    // message:
                    // 'Product added to cat add ${provider.appSettings!.generalSettings.itemQty - provider.cartItems.where((element) => element.productType == trialProduct).length} more for checkout',
                    haveButtons: true,
                  );
                },
              );
              break;
            case 'item_complete':
              provider.addCartItems(productID: productId);
              BuildContext? dialogContext;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  dialogContext = c;
                  return CustomDialog(
                    onTap: () {
                      if (Device.width >= 1024) {
                        context.router.push(const ShoppingTabOneDesktop());
                      } else {
                        context.router.push(const CartRoute());
                      }
                    },
                    icon: 'assets/images/icons/happy.png',
                    buttonName: 'Checkout',
                    buttonName2: 'Continue Shopping',
                    on2ndButtonClicked: () {
                      if (fromProductPage) {
                        dialogContext?.router.popUntilRouteWithName(NavigatorRoute.name);
                      } else {
                        dialogContext?.maybePop();
                      }
                    },
                    have2ndButton: true,
                    title: 'Great Choice!',
                    message:
                        'You have completed your  ${provider.appSettings!.generalSettings.itemQty} mini’s selection. Or You can select upto ${provider.appSettings!.generalSettings.addonQty} more mini’s for Rs ${provider.appSettings!.generalSettings.addonUnitPrice} each',
                    // message:
                    //     'Your cart is complete, You can checkout now or you can add more ${provider.appSettings!.generalSettings.addonQty} at Rs. ${provider.appSettings!.generalSettings.addonUnitPrice} per product',
                    haveButtons: true,
                  );
                },
              );
              break;
            case 'addon_item_left':
              provider.addCartItems(productID: productId);
              BuildContext? dialogContext;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  dialogContext = c;
                  return CustomDialog(
                    onTap: () {
                      if (Device.width >= 1024) {
                        context.router.push(const ShoppingTabOneDesktop());
                      } else {
                        context.router.push(const CartRoute());
                      }
                    },
                    icon: 'assets/images/icons/happy.png',
                    buttonName: 'Checkout',
                    buttonName2: 'Continue Shopping',
                    on2ndButtonClicked: () {
                      if (fromProductPage) {
                        dialogContext?.router.popUntilRouteWithName(NavigatorRoute.name);
                      } else {
                        dialogContext?.maybePop();
                      }
                    },
                    have2ndButton: true,
                    title: '',
                    message:
                        'Your cart is complete, You can checkout now or you can add more ${provider.appSettings!.generalSettings.addonQty - 1} at Rs. ${provider.appSettings!.generalSettings.addonUnitPrice} per product',
                    haveButtons: true,
                  );
                },
              );
              break;
            case 'cart_complete':
              provider.addCartItems(productID: productId);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  return CustomDialog(
                    onTap: () {
                      if (Device.width >= 1024) {
                        context.router.push(const ShoppingTabOneDesktop());
                      } else {
                        context.router.push(const CartRoute());
                      }
                    },
                    icon: 'assets/images/icons/happy.png',
                    buttonName: 'Checkout',
                    title: '',
                    message: 'You have completed your, checkout now',
                    haveButtons: true,
                  );
                },
              );
              break;
            case 'all_product_added':
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  return CustomDialog(
                    onTap: () {
                      if (Device.width >= 1024) {
                        context.router.push(const ShoppingTabOneDesktop());
                      } else {
                        context.router.push(const CartRoute());
                      }
                    },
                    icon: 'assets/images/icons/happy.png',
                    buttonName: 'Checkout',
                    title: 'Sorry!',
                    message: 'Your cart is complete',
                    haveButtons: true,
                  );
                },
              );
              break;
            default:
              break;
          }
        } else {
          ScaffoldSnackBar.of(context).show('Sorry! You have already availed this product.');
        }
      } else {
        ScaffoldSnackBar.of(context).show('Please login first');
        context.router.push(AuthRoute(logOut: false));
      }
    }
  }

  void regularPackBuy({required AppProvider provider, required BuildContext context, required Product product}) {
    if (provider.currentUser != null) {
      if (product.retargetProduct?.type == 'internal') {
        Product? pr = provider.dealProducts.firstWhereOrNull((element) => element.id == product.retargetProduct?.productId);
        if (pr != null) {
          productClick(context: context, productId: pr.id, productType: pr.productType, provider: provider);
        } else {
          ScaffoldSnackBar.of(context).show('Sorry product not available');
        }
      } else {
        _urlHelper.launchNonUrl(url: product.retargetProduct?.productLink ?? '');
      }
    } else {
      ScaffoldSnackBar.of(context).show('Please login first');
      context.router.push(AuthRoute(logOut: false));
    }
  }

  void applyToTry(
      {required AppProvider provider, required String productId, required double width, required double height, required BuildContext context}) async {
    Product? product = provider.sampleProducts.firstWhereOrNull((element) => element.id == productId);
    if (provider.currentUser != null) {
      if (product != null && provider.currentUser!.orders.where((element) => element.products.any((p) => p.id == productId)).length < product.maximumQty) {
        if (product.pSurvey != null) {
          if (provider.reports.any((element) => element.surveyId == product.pSurvey?.id)) {
            ScaffoldSnackBar.of(context).show('You have already requested for this mini offer.');
          } else {
            await context.router.push(
              ProductSurveyRoute(productId: product.id),
            );
          }
        } else {
          if (provider.cart != null && provider.cart!.records.any((element) => element.id == product.id)) {
            ScaffoldBanner.of(context).show('Product already added to cart!');
          } else {
            provider.addCartItems(productID: product.id);
            bool closed = false;
            showCupertinoModalPopup(
              context: context,
              barrierColor: Colors.transparent,
              useRootNavigator: true,
              builder: (c) {
                return Container(
                  width: width,
                  height: height * .11,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_rounded,
                        color: ColorConstants.colorGreenTwo,
                        size: 35,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Product Added to cart ',
                        style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorGreyTwo, decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                );
              },
            ).whenComplete(() => closed = !closed);

            Future.delayed(const Duration(seconds: 5), () {
              if (!closed) context.router.maybePop();
            });
          }
        }
      } else {
        ScaffoldSnackBar.of(context).show('Sorry! You have already availed this product.');
      }
    } else {
      ScaffoldSnackBar.of(context).show('Please login');
      context.router.push(AuthRoute());
    }
  }

  void addToCart({required AppProvider provider, required BuildContext context, required String productId}) {
    // if (provider.orders.where((element) => element.products.any((p) => p.id == product.id)).length < product.maximumQty) {
    if (provider.cart != null && !provider.cart!.records.any((element) => element.productId == productId)) {
      provider.addCartItems(productID: productId);
      // ScaffoldBanner.of(context).show('Products added to cart!');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Alreadyadded(
            onTap: () {
              context.router.maybePop();
            },
            icon: 'assets/images/icons/happy.png',
            buttonName: '',
            title: 'Product added to cart!',
            message: '',
            // message: ' add ${(provider.appSettings?.generalSettings.itemQty ?? 0) - 1} more products to complete your cart',
            haveButtons: true,
          );
        },
      );
    } else {
      // ScaffoldBanner.of(context).show('Product already added to cart!');
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return Alreadyadded(
            onTap: () {
              context.router.maybePop();
            },
            icon: 'assets/images/icons/happy.png',
            buttonName: '',
            title: 'Already added to cart!',
            message: '',
            // message: ' add ${(provider.appSettings?.generalSettings.itemQty ?? 0) - 1} more products to complete your cart',
            haveButtons: true,
          );
        },
      );
    }
    // } else {
    //   showSnackBar(context: context, content: 'Sorry! You have already availed this product.');
    // }
  }

  void productClick({
    required BuildContext context,
    required String productType,
    required AppProvider provider,
    required String productId,
  }) {
    switch (productType) {
      case StringConstants.trialProduct:
        context.router.push(TrialItemRoute(productId: productId));
        break;
      // case rewardStoreProduct:
      //   context.router.push(RewardItemRoute(product: product));
      //   break;
      case StringConstants.brandStoreProduct:
        context.router.push(BrandItemRoute(productId: productId));
        break;
      case StringConstants.hotDealProduct:
        context.router.push(HotItemRoute(productId: productId));
        break;
    }
  }

  void addToWishList({required AppProvider provider, required BuildContext context, required String productId}) {
    if (provider.currentUser != null && provider.wishlist != null) {
      if (!provider.wishlist!.records.any((element) => element.productId == productId)) {
        provider.addToWishList(productId);
        ScaffoldSnackBar.of(context).show('Added to wish list');
      } else {
        provider.addToWishList(productId);
        ScaffoldSnackBar.of(context).show('Removed from wish list');
      }
    } else {
      ScaffoldSnackBar.of(context).show('Please login first');
      context.router.push(AuthRoute());
    }
  }

  int hotDealCount(AppProvider provider) {
    int count = 0;
    if (provider.cart != null) {
      for (var p in provider.cart!.records.where((element) => element.productType == StringConstants.hotDealProduct)) {
        if (p.quantity == 1) {
          count++;
        } else {
          count = count + p.quantity.toInt();
        }
      }
    }
    return count;
  }
}
