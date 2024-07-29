// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderDetailsDesktop extends StatefulWidget {
  final String orderID;

  const OrderDetailsDesktop({super.key, required this.orderID});

  @override
  State<OrderDetailsDesktop> createState() => _OrderDetailsDesktopState();
}

class _OrderDetailsDesktopState extends State<OrderDetailsDesktop> {
  bool trialExpanded = true, brandExpanded = false, hotDealExpanded = false, bonusExpanded = false;

  final DioHelper _dioHelper = DioHelper();

  double calculateHotDealTotal() {
    double t = 0.00;
    if (order != null) {
      for (var p in order!.products.where((element) => element.productType == StringConstants.hotDealProduct)) {
        t += p.salePrice * p.quantity;
      }
    }
    return t;
  }

  double calculateServiceCharge(AppProvider provider) {
    double t = 0;
    if (order != null && order!.products.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty) {
      t += miniCharge(provider);
    }
    return t;
  }

  // late AppProvider _appProvider;

  int miniCharge(AppProvider provider) {
    num count = 0;
    if (order != null && order!.miniCharge > 0) {
      count = order!.miniCharge;
    } else {
      count = provider.appSettings?.generalSettings.miniCharge ?? 0;
    }
    return count.toInt();
  }

  int miniItemQuantity(AppProvider provider) {
    num count = 0;
    if (order != null && order!.miniItemQuantity > 0) {
      count = order!.miniItemQuantity;
    } else {
      count = provider.appSettings?.generalSettings.itemQty ?? 0;
    }
    return count.toInt();
  }

  int addonUnitPrice(AppProvider provider) {
    num count = 0;
    if (order != null && order!.addonUnitPrice > 0) {
      count = order!.addonUnitPrice;
    } else {
      count = (provider.appSettings?.generalSettings.addonUnitPrice ?? 0).toInt();
    }
    return count.toInt();
  }

  double calculateAddonServiceCharge(AppProvider provider) {
    double t = 0;
    if (order != null && order!.products.where((element) => element.productType == StringConstants.trialProduct).length > miniItemQuantity(provider)) {
      final trialLength = order!.products.where((element) => element.productType == StringConstants.trialProduct).length;
      final addonLength = trialLength - miniItemQuantity(provider);
      t += t + (addonLength * addonUnitPrice(provider));
    }
    return t;
  }

  double calculateBonusServiceCharge() {
    double t = 0;
    if (order != null) {
      for (var p in order!.products.where((element) => element.productType == StringConstants.brandStoreProduct)) {
        t += p.serviceCharge;
      }
    }
    return t;
  }

  double calculateAllTotal(AppProvider provider) {
    double t = calculateServiceCharge(provider) + calculateAddonServiceCharge(provider) + calculateBonusServiceCharge() + calculateHotDealTotal();
    double discountP = 0;
    if (order != null && order!.coupon != null) {
      discountP = t - calculateDiscount(provider);
      // discountP = t;
    } else {
      discountP = t;
    }
    return discountP;
  }

  double calculateSubTotal(AppProvider provider) {
    double t = calculateServiceCharge(provider) + calculateAddonServiceCharge(provider) + calculateBonusServiceCharge() + calculateHotDealTotal();
    double discountP = 0;
    if (order != null && order!.coupon != null) {
      discountP = t - calculateDiscount(provider);
      // discountP = t;
    } else {
      discountP = t;
    }
    return discountP;
  }

  double calculateSubTotalWithoutDiscount(AppProvider provider) {
    double t = calculateServiceCharge(provider) + calculateAddonServiceCharge(provider) + calculateBonusServiceCharge() + calculateHotDealTotal();
    return t;
  }

  double calculateDiscount(AppProvider provider) {
    double t = calculateServiceCharge(provider) + calculateAddonServiceCharge(provider) + calculateBonusServiceCharge() + calculateHotDealTotal();
    double f = 0;
    if (order != null && order!.coupon != null) {
      int discount = order!.coupon!.discountType == StringConstants.couponFlat
          ? int.parse(order!.coupon!.amount!)
          : int.parse(order!.coupon!.percentage!.replaceAll('%', ''));
      if (order!.coupon?.discountType == StringConstants.couponFlat) {
        f = discount.toDouble();
      } else {
        f = (t * (discount / 100));
      }
    }
    return f;
  }

  int hotDealCount() {
    num count = 0;
    if (order != null) {
      for (var p in order!.products.where((element) => element.productType == StringConstants.hotDealProduct)) {
        if (p.quantity == 1) {
          count++;
        } else {
          count = count + p.quantity;
        }
      }
    }
    return count.toInt();
  }

  saveReview(AppProvider provider, String review, double rating, String productId) async {
    final response = await _dioHelper.post(
      'feedback',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'review': review,
        'quality': rating,
        'product_id': productId,
        'order_id': order?.id,
        'user_id': provider.loginDetails?.uId,
      },
    );
    if (response != null && response.data['status']) {
      provider.initWithLogin();
      if (!mounted) return;
      ScaffoldSnackBar.of(context).show('Review placed successfully');
    }
  }

  Order? order;

  initOrder(AppProvider provider) {
    order = provider.currentUser?.orders.firstWhereOrNull((element) => element.id == widget.orderID);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        initOrder(provider);
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopAppBar(),
                SizedBox(height: height * .06),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          trialExpanded = !trialExpanded;
                        });
                      },
                      child: Container(
                        width: width,
                        height: height * .06,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.colorOffWhite,
                          borderRadius: BorderRadius.circular(height * .06),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Shop Mini',
                              style: TextHelper.smallTextStyle.copyWith(
                                color: ColorConstants.colorBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              trialExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                              color: ColorConstants.colorBlack,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (trialExpanded && order != null)
                  ...order!.products.where((element) => element.productType == StringConstants.trialProduct).map(
                    (e) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: width * .12),
                        alignment: Alignment.center,
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorGreenSix,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: e.image,
                                      width: width * .12,
                                      height: width * .12,
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.brand?.name ?? '',
                                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            e.name,
                                            maxLines: 3,
                                            style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      margin: const EdgeInsets.symmetric(horizontal: 15),
                                      color: ColorConstants.colorBlack,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Free',
                                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (order?.status == 'delivered')
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      ),
                                      isScrollControlled: true,
                                      builder: (c) => Padding(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: ProductRatingSheet(
                                          product: e,
                                          onSubmit: (double rating, String review) {
                                            saveReview(provider, review, rating, e.id);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: ColorConstants.colorBlack, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Rate This Product',
                                      style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorBlack, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.brandStoreProduct).isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          brandExpanded = !brandExpanded;
                        });
                      },
                      child: Container(
                        width: width,
                        height: height * .06,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: ColorConstants.colorOffWhite,
                          borderRadius: BorderRadius.circular(height * .06),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Free Sample',
                              style: TextHelper.smallTextStyle.copyWith(
                                color: ColorConstants.colorBlack,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              brandExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                              color: ColorConstants.colorBlack,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (brandExpanded && order != null)
                  ...order!.products.where((element) => element.productType == StringConstants.brandStoreProduct).map(
                    (e) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: width * .12),
                        alignment: Alignment.center,
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorGreenSix,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: e.image,
                                      width: width * .12,
                                      height: width * .12,
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.brand?.name ?? '',
                                            style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorBlack, fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            e.name,
                                            maxLines: 3,
                                            style: TextHelper.extraSmallTextStyle.copyWith(color: ColorConstants.colorBlack, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      margin: const EdgeInsets.symmetric(horizontal: 15),
                                      color: ColorConstants.colorBlack,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            e.salePrice > 0 ? '${StringConstants.rupeeSign}${e.salePrice}' : 'Free',
                                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (order?.status == 'delivered')
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      ),
                                      isScrollControlled: true,
                                      builder: (c) => Padding(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: ProductRatingSheet(
                                          product: e,
                                          onSubmit: (double rating, String review) {
                                            saveReview(provider, review, rating, e.id);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: ColorConstants.colorBlack, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Rate This Product',
                                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.hotDealProduct).isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          hotDealExpanded = !hotDealExpanded;
                        });
                      },
                      child: Container(
                        width: width,
                        height: height * .06,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: ColorConstants.colorOffWhite,
                          borderRadius: BorderRadius.circular(height * .06),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Deals & Combos',
                              style: TextHelper.smallTextStyle.copyWith(
                                color: ColorConstants.colorBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              hotDealExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                              color: ColorConstants.colorBlack,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (hotDealExpanded && order != null)
                  ...order!.products.where((element) => element.productType == StringConstants.hotDealProduct).map(
                    (e) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: width * .12),
                        alignment: Alignment.center,
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorGreenSix,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: e.image,
                                      width: width * .12,
                                      height: width * .12,
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.brand?.name ?? '',
                                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            e.name,
                                            maxLines: 3,
                                            style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      margin: const EdgeInsets.symmetric(horizontal: 15),
                                      color: ColorConstants.colorBlack,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'QTY - ${e.quantity}',
                                            textAlign: TextAlign.center,
                                            style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${StringConstants.rupeeSign}${e.salePrice}',
                                            style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (order?.status == 'delivered')
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      ),
                                      isScrollControlled: true,
                                      builder: (c) => Padding(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: ProductRatingSheet(
                                          product: e,
                                          onSubmit: (double rating, String review) {
                                            saveReview(provider, review, rating, e.id);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: ColorConstants.colorBlack, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Rate This Product',
                                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.noTrailProduct).isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        setState(() {
                          bonusExpanded = !bonusExpanded;
                        });
                      },
                      child: Container(
                        width: width,
                        height: height * .06,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: ColorConstants.colorOffWhite,
                          borderRadius: BorderRadius.circular(height * .06),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Bonus',
                              style: TextHelper.smallTextStyle.copyWith(
                                color: ColorConstants.colorBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              bonusExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                              color: ColorConstants.colorBlack,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (bonusExpanded && order != null)
                  ...order!.products.where((element) => element.productType == StringConstants.noTrailProduct).map(
                    (e) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: width * .12),
                        alignment: Alignment.center,
                        child: Container(
                          width: width,
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorGreenSix,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IntrinsicHeight(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl: e.image,
                                      width: width * .12,
                                      height: width * .12,
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.brand?.name ?? '',
                                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            e.name,
                                            maxLines: 3,
                                            style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      margin: const EdgeInsets.symmetric(horizontal: 15),
                                      color: ColorConstants.colorBlack,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Free',
                                            textAlign: TextAlign.center,
                                            style: TextHelper.normalTextStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstants.colorBlack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (order?.status == 'delivered')
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  highlightColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      ),
                                      isScrollControlled: true,
                                      builder: (c) => Padding(
                                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                        child: ProductRatingSheet(
                                          product: e,
                                          onSubmit: (double rating, String review) {
                                            saveReview(provider, review, rating, e.id);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: ColorConstants.colorBlack, width: 2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: const EdgeInsets.only(top: 15),
                                    child: Text(
                                      'Rate This Product',
                                      style: TextHelper.smallTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstants.colorBlack,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                SizedBox(height: height * .02),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Payment Details',
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.bold,fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: height * .015),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: const Divider(
                    color: ColorConstants.colorGreyTwo,
                  ),
                ),
                SizedBox(height: height * .02),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Shop Mini - Service Fee (${(order!.products.where((element) => element.productType == StringConstants.trialProduct).length - (order!.products.where((element) => element.productType == StringConstants.trialProduct).length - miniItemQuantity(provider)))} ${(order!.products.where((element) => element.productType == StringConstants.trialProduct).length - (order!.products.where((element) => element.productType == StringConstants.trialProduct).length - miniItemQuantity(provider))) > 1 ? 'items' : 'item'})',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                        Text(
                          '\u{20B9}${calculateServiceCharge(provider).toStringAsFixed(2)}',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                if (order != null &&
                    order!.products.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty &&
                    order!.products.where((element) => element.productType == StringConstants.trialProduct).length > miniItemQuantity(provider))
                  SizedBox(height: height * .02),
                if (order != null &&
                    order!.products.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty &&
                    order!.products.where((element) => element.productType == StringConstants.trialProduct).length > miniItemQuantity(provider))
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Shop Mini - Addon Product Fee (${order!.products.where((element) => element.productType == StringConstants.trialProduct).length - miniItemQuantity(provider)} ${(order!.products.where((element) => element.productType == StringConstants.trialProduct).length - miniItemQuantity(provider)) > 1 ? 'items' : 'item'})',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                        Text(
                          '\u{20B9}${calculateAddonServiceCharge(provider).toStringAsFixed(2)}',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.brandStoreProduct).isNotEmpty)
                  SizedBox(height: height * .02),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.brandStoreProduct).isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Free Sample - Service Fee (${order!.products.where((element) => element.productType == StringConstants.brandStoreProduct).length} ${order!.products.where((element) => element.productType == StringConstants.brandStoreProduct).length > 1 ? 'items' : 'item'})',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                        Text(
                          '\u{20B9}${calculateBonusServiceCharge().toStringAsFixed(2)}',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.hotDealProduct).isNotEmpty)
                  SizedBox(height: height * .02),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.hotDealProduct).isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Deals & Combos (${hotDealCount()} ${hotDealCount() > 1 ? 'items' : 'item'})',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                        Text(
                          '\u{20B9}${calculateHotDealTotal().toStringAsFixed(2)}',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.noTrailProduct).isNotEmpty)
                  SizedBox(height: height * .02),
                if (order != null && order!.products.where((element) => element.productType == StringConstants.noTrailProduct).isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Bonus Trials (${order!.products.where((element) => element.productType == StringConstants.noTrailProduct).length} ${order!.products.where((element) => element.productType == StringConstants.noTrailProduct).length > 1 ? 'items' : 'item'})',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                        Text(
                          'FREE',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                if (order?.paymentMode == 'cod') SizedBox(height: height * .02),
                if (order?.paymentMode == 'cod')
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'COD Fee',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                        Text(
                          '\u{20B9}${order?.codCharge}',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: height * .02),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'SubTotal',
                        style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 14.sp),
                      ),
                      if (order != null)
                        Text(
                          '\u{20B9}${(calculateSubTotalWithoutDiscount(provider) + (order?.paymentMode == 'cod' ? order!.codCharge : 0)).toStringAsFixed(2)}',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 14.sp),
                        ),
                    ],
                  ),
                ),
                if (order != null && order!.coupon != null) SizedBox(height: height * .02),
                if (order != null && order!.coupon != null)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
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
                            Text(
                              'Coupon Applied',
                              style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                            ),
                          ],
                        ),
                        Text(
                          '\u{20B9}${calculateDiscount(provider).toStringAsFixed(2)}',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: height * .03),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total',
                        style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 14.sp),
                      ),
                      if (order != null)
                        Text(
                          '\u{20B9}${(calculateAllTotal(provider) + (order?.paymentMode == 'cod' ? order!.codCharge : 0)).toStringAsFixed(2)}',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold,fontSize: 14.sp),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: height * .02),
                Align(
                  child: Text(
                    'Note : All Prices Are Inclusive of GST',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                        fontSize: 14.sp
                    ),
                  ),
                ),
                SizedBox(height: height * .1),
                const BottomAppBarPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
