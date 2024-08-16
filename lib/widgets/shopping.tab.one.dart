/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/deals.screen.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ShoppingTabOne extends StatefulWidget {
  final Function() onCheckout;

  const ShoppingTabOne({
    super.key,
    required this.onCheckout,
  });

  @override
  State<ShoppingTabOne> createState() => _ShoppingTabOneState();
}

class _ShoppingTabOneState extends State<ShoppingTabOne> {
  bool trialExpanded = true, hotDealExpanded = true, brandExpanded = true, bonusExpanded = true, rewardExpanded = true;

  final CartHelper _cartHelper = CartHelper();

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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * .02,
                ),
                Text(
                  'Items in your cart',
                  style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                ),
                SizedBox(height: height * .02),
                if (provider.cart != null)
                  ...provider.cart!.records.map(
                    (e) {
                      switch (e.productType) {
                        case StringConstants.trialProduct:
                          return _TrialItem(
                            key: Key(e.id),
                            cartItem: e,
                            provider: provider,
                            onDelete: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (c) => DeleteCartItem(
                                  product: e,
                                  remove: () {
                                    context.router.maybePop();
                                    provider.deleteCartItem(e.id);
                                  },
                                  move: () {
                                    context.router.maybePop();
                                    provider.moveCartItem(e.id);
                                  },
                                ),
                              );
                            },
                            onClick: () {
                              _cartHelper.productClick(context: context, productId: e.productId, productType: e.productType, provider: provider);
                            },
                          );
                        case StringConstants.brandStoreProduct:
                          return _SelectItems(
                            cartItem: e,
                            provider: provider,
                            onDelete: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (c) => DeleteCartItem(
                                  product: e,
                                  remove: () {
                                    context.router.maybePop();
                                    provider.deleteCartItem(e.id);
                                  },
                                  move: () {
                                    context.router.maybePop();
                                    provider.moveCartItem(e.productId);
                                  },
                                ),
                              );
                            },
                            onClick: () {
                              _cartHelper.productClick(context: context, productId: e.productId, productType: e.productType, provider: provider);
                            },
                          );
                        // case rewardStoreProduct:
                        //   return _RewardItems(
                        //     cartItem: e,
                        //     provider: provider,
                        //     onDelete: () {
                        //       showModalBottomSheet(
                        //         context: context,
                        //         shape: const RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.vertical(
                        //             top: Radius.circular(20),
                        //           ),
                        //         ),
                        //         builder: (c) => DeleteCartItem(
                        //           product: e,
                        //           remove: () {
                        //             context.router.pop();
                        //             provider.deleteCartItem(e);
                        //           },
                        //           move: () {
                        //             context.router.pop();
                        //             provider.moveCartItem(e);
                        //           },
                        //         ),
                        //       );
                        //     },
                        //     onClick: () {
                        //       _cartHelper.productClick(context: context, product: e.toProduct());
                        //     },
                        //   );
                        case StringConstants.noTrailProduct:
                          return _NoTrialItem(
                            cartItem: e,
                            provider: provider,
                            onDelete: () {
                              provider.deleteCartItem(e.id);
                            },
                          );
                        case StringConstants.hotDealProduct:
                          return _HotItems(
                            cartItem: e,
                            provider: provider,
                            onDelete: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (c) => DeleteCartItem(
                                  product: e,
                                  remove: () {
                                    context.router.maybePop();
                                    provider.deleteCartItem(e.id);
                                  },
                                  move: () {
                                    context.router.maybePop();
                                    provider.moveCartItem(e.productId);
                                  },
                                ),
                              );
                            },
                            onClick: () {
                              _cartHelper.productClick(context: context, productId: e.productId, productType: e.productType, provider: provider);
                            },
                          );
                        case StringConstants.surprisedProduct:
                          return _SurpriseTrialItem(
                            cartItem: e,
                            provider: provider,
                          );
                        default:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                if (provider.cart != null &&
                    provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >=
                        provider.appSettings!.generalSettings.itemQty)
                  if (provider.noTrailProducts.isNotEmpty &&
                      provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length <
                          (provider.appSettings?.generalSettings.samplesLimit ?? 2))
                    Text(
                      'Bonus Trial Offers',
                      style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorBlack),
                    ),
                if (provider.cart != null &&
                    provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >=
                        provider.appSettings!.generalSettings.itemQty)
                  if (provider.noTrailProducts.isNotEmpty &&
                      provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length <
                          (provider.appSettings?.generalSettings.samplesLimit ?? 2))
                    SizedBox(height: height * .01),
                if (provider.cart != null &&
                    provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >=
                        provider.appSettings!.generalSettings.itemQty)
                  if (provider.noTrailProducts.isNotEmpty &&
                      provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length <
                          (provider.appSettings?.generalSettings.samplesLimit ?? 2))
                    Padding(
                      padding: EdgeInsets.only(bottom: height * .01),
                      child: Text(
                        'Exclusively for you! Choose upto 2 items, 100% FREE',
                        maxLines: 5,
                        style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorBlack, fontWeight: FontWeight.w500),
                      ),
                    ),
                if (provider.cart != null &&
                    provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >=
                        provider.appSettings!.generalSettings.itemQty)
                  if (provider.noTrailProducts.isNotEmpty &&
                      provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length <
                          (provider.appSettings?.generalSettings.samplesLimit ?? 2))
                    CarouselSlider(
                      items: provider.noTrailProducts
                          .map(
                            (e) => _BonusItems(product: e, provider: provider),
                          )
                          .toList(),
                      options: CarouselOptions(
                        aspectRatio: 1.3,
                        viewportFraction: 0.47,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        disableCenter: true,
                        padEnds: false,
                      ),
                    ),
                SizedBox(height: height * .02),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstants.colorPinkTwo,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        'Deals & Combo',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        // onTap: () => context.router.naviga(const DealsRoute()),
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (c) => const DealsScreen(),
                          ),
                        ),
                        child: Text(
                          'View All',
                          style: TextHelper.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .01),
                Text(
                  'Deals & Combo\'s: Special deals & combo offers with best discounts on top brands. Dare to compare pricing .',
                  maxLines: 10,
                  style: TextHelper.smallTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.colorGreySeven,
                  ),
                ),
                SizedBox(height: height * .01),
                CarouselSlider.builder(
                  itemCount: (provider.dealProducts.length > 10 ? 10 : provider.dealProducts.length),
                  itemBuilder: (BuildContext context, int index, int i) {
                    Product product = provider.dealProducts[index];
                    return DealItems(
                      key: Key(product.id),
                      product: product,
                      onProductClick: () =>
                          _cartHelper.productClick(context: context, productId: product.id, productType: product.productType, provider: provider),
                      onAddToCart: () => _cartHelper.addToCart(
                        provider: provider,
                        context: context,
                        productId: product.id,
                      ),
                      provider: provider,
                      cartHelper: _cartHelper,
                      gridView: false,
                    );
                  },
                  options: CarouselOptions(
                    aspectRatio: 1.2,
                    viewportFraction: 0.47,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    reverse: false,
                    disableCenter: true,
                    padEnds: false,
                  ),
                ),
                SizedBox(height: height * .02),
                InkWell(
                  onTap: () => context.router.push(const CouponRoute()),
                  splashFactory: NoSplash.splashFactory,
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: width,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: ColorConstants.colorBlueEighteen,
                      borderRadius: BorderRadius.circular(height * .06),
                      border: Border.all(
                        color: ColorConstants.colorBlueEighteen,
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      leading: const SizedBox(
                        width: 30,
                        height: 30,
                        child: Align(
                          child: Icon(
                            Icons.local_offer_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      title: Text(
                        'Coupons & Offers',
                        style: TextHelper.subTitleStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                Text(
                  'Payment Details',
                  style: TextHelper.subTitleStyle,
                ),
                SizedBox(height: height * .015),
                const Divider(
                  color: ColorConstants.colorGreyTwo,
                ),
                SizedBox(height: height * .02),
                if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty)
                  Row(
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
                if (provider.cart != null &&
                    provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty &&
                    provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >
                        provider.appSettings!.generalSettings.itemQty)
                  SizedBox(height: height * .02),
                if (provider.cart != null &&
                    provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).isNotEmpty &&
                    provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >
                        provider.appSettings!.generalSettings.itemQty)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Shop Mini - Addon Product Fee (${provider.cart!.charges.addonQuantity} ${(provider.cart!.charges.addonQuantity) > 1 ? 'items' : 'item'})',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\u{20B9}${provider.cart?.charges.addonUnitPrice.toStringAsFixed(2)}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).isNotEmpty)
                  SizedBox(height: height * .02),
                if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.brandStoreProduct).isNotEmpty)
                  Row(
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
                if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.hotDealProduct).isNotEmpty)
                  SizedBox(height: height * .02),
                if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.hotDealProduct).isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Deals Combos (${_cartHelper.hotDealCount(provider)} ${_cartHelper.hotDealCount(provider) > 1 ? 'items' : 'item'})',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '\u{20B9}${provider.cart?.charges.hotDealsCharge.toStringAsFixed(2)}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).isNotEmpty)
                  SizedBox(height: height * .02),
                if (provider.cart != null && provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).isNotEmpty)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(height: height * .02),
                if (provider.cart != null)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'SubTotal',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '\u{20B9}${provider.cart!.charges.subTotalWithoutDiscount.toStringAsFixed(2)}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w700),
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
                      InkWell(
                        onTap: () {
                          provider.removeCoupon();
                        },
                        child: Tooltip(
                          message: 'Remove Coupon',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Coupon Applied',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                              ),
                              const Icon(
                                Icons.close,
                                size: 17,
                                color: ColorConstants.colorRed,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '\u{20B9}${provider.cart?.charges.discount.toStringAsFixed(2)}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
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
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '\u{20B9}${provider.cart!.charges.grandTotal.toStringAsFixed(2)}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                SizedBox(height: height * .05),
                if (provider.cart != null && provider.cart!.records.any((element) => element.productType == StringConstants.trialProduct))
                  if (provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length >=
                      provider.appSettings!.generalSettings.itemQty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: widget.onCheckout,
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        child: Container(
                          width: width * .4,
                          height: height * .06,
                          decoration: BoxDecoration(
                            color: ColorConstants.colorBlueEighteen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Check out',
                            style: TextHelper.titleStyle.copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  else
                    Align(
                      child: (provider.cart != null)
                          ? Text(
                              'Add more ${provider.appSettings!.generalSettings.itemQty - provider.cart!.records.where((element) => element.productType == StringConstants.trialProduct).length} for checkout',
                              style: TextHelper.normalTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const SizedBox.shrink(),
                    )
                else
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: widget.onCheckout,
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      child: Container(
                        width: width * .4,
                        height: height * .06,
                        decoration: BoxDecoration(
                          color: ColorConstants.colorPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Check out',
                          style: TextHelper.titleStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: height * .02),
                Align(
                  child: Text(
                    'Note : All Prices Are Inclusive of GST',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextHelper.smallTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
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

class _HotItems extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;
  final Function() onDelete;
  final Function() onClick;

  const _HotItems({
    required this.cartItem,
    required this.provider,
    required this.onDelete,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => onClick(),
            child: CustomNetworkImage(
              imageUrl: cartItem.image,
              width: width * .25,
              height: width * .25,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Deals store)',
                  style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '${StringConstants.rupeeSign}${cartItem.mrp}',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, decoration: TextDecoration.lineThrough),
                    ),
                    Container(
                      width: 5,
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      color: ColorConstants.colorBlack,
                    ),
                    Text(
                      '${StringConstants.rupeeSign}${cartItem.salePrice}',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => provider.removeCartItems(cartItem.productId),
                      child: Container(
                        width: 25,
                        height: 25,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.colorRedFive,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '-',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    Text(
                      provider.cart != null && provider.cart!.records.any((element) => element.id == cartItem.id)
                          ? provider.cart!.records.firstWhere((element) => element.id == cartItem.id).quantity.toString()
                          : '0',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () => provider.addCartItems(productID: cartItem.productId),
                      child: Container(
                        width: 25,
                        height: 25,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorConstants.colorGreenFour,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '+',
                          style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: onDelete,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/images/trash_can.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(ColorConstants.colorBlack.withOpacity(0.5), BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectItems extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;
  final Function() onDelete;
  final Function() onClick;

  const _SelectItems({
    required this.cartItem,
    required this.provider,
    required this.onDelete,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => onClick(),
            child: CustomNetworkImage(
              imageUrl: cartItem.image,
              width: width * .25,
              height: width * .25,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Free Sample)',
                  style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.smallTextStyle
                          .copyWith(fontWeight: FontWeight.w500, color: cartItem.salePrice > 0 ? ColorConstants.colorBlack : ColorConstants.colorGreenTwo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.smallTextStyle.copyWith(color: Colors.transparent),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: onDelete,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/images/trash_can.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(ColorConstants.colorBlack.withOpacity(0.5), BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoTrialItem extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;
  final Function() onDelete;

  const _NoTrialItem({
    required this.cartItem,
    required this.provider,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomNetworkImage(
            imageUrl: cartItem.image,
            width: width * .25,
            height: width * .25,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Bonus store)',
                  style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'FREE',
                      style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreenTwo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.smallTextStyle.copyWith(color: Colors.transparent),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: onDelete,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/images/trash_can.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(ColorConstants.colorBlack.withOpacity(0.5), BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrialItem extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;
  final Function() onDelete;
  final Function() onClick;

  const _TrialItem({
    super.key,
    required this.cartItem,
    required this.provider,
    required this.onDelete,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            onTap: () => onClick(),
            child: CustomNetworkImage(
              imageUrl: cartItem.image,
              width: width * .25,
              height: width * .25,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Shop Mini)',
                  style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                // const SizedBox(height: 5),
                // Row(
                //   children: [
                //     Text(
                //       '${cartItem.trialPoint} points used',
                //       style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.smallTextStyle.copyWith(color: Colors.transparent),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          InkWell(
            onTap: onDelete,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/images/trash_can.svg',
                width: 25,
                height: 25,
                colorFilter: ColorFilter.mode(ColorConstants.colorBlack.withOpacity(0.5), BlendMode.srcIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BonusItems extends StatelessWidget {
  final Product product;
  final AppProvider provider;

  const _BonusItems({required this.product, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: ColorConstants.colorPinkTwo,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: CustomNetworkImage(
                    imageUrl: product.image,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.brand?.name ?? '',
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      product.name,
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorConstants.colorBlackFour,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Worth Rs.${product.mrp}',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // const SizedBox(height: 3),
                    // Row(
                    //   mainAxisSize: MainAxisSize.max,
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Text(
                    //         'Rating ${product.review}',
                    //         style: TextHelper.extraSmallTextStyle.copyWith(
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 8.sp,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Checkbox(
          visualDensity: VisualDensity.comfortable,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          value: provider.cart != null &&
              provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct && element.id == product.id).isNotEmpty,
          onChanged: (v) {
            if (v != null && v) {
              // if (provider.currentUser != null &&
              //     provider.currentUser!.orders
              //             .where((element) =>
              //                 element.status.toLowerCase() != 'cancelled' &&
              //                 element.products.any((p) => p.id == e.id))
              //             .length <
              //         e.maximumQty) {
              if (provider.cart != null &&
                  provider.cart!.records.where((element) => element.productType == StringConstants.noTrailProduct).length <
                      (provider.appSettings?.generalSettings.samplesLimit ?? 2)) {
                provider.addCartItems(productID: product.id);
              } else {
                ScaffoldSnackBar.of(context).show('Oops you are eligible for ${(provider.appSettings?.generalSettings.samplesLimit ?? 2)} Bonus trials');
              }
              // } else {
              //   showSnackBar(
              //       context: context,
              //       content: 'Sorry! You have already availed this product.');
              // }
            } else {
              if (provider.cart != null && provider.cart!.records.any((element) => element.id == product.id)) {
                provider.deleteCartItem(product.id);
              }
            }
          },
        ),
      ],
    );
  }
}

class _SurpriseTrialItem extends StatelessWidget {
  final CartItem cartItem;
  final AppProvider provider;

  const _SurpriseTrialItem({
    required this.cartItem,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomNetworkImage(
            imageUrl: cartItem.image,
            width: width * .25,
            height: width * .25,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  maxLines: 2,
                  TextSpan(
                    text: cartItem.brand.name,
                    style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: ' ${cartItem.name}',
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '(Surprised Product)',
                  style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'FREE',
                      style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreenTwo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      cartItem.salePrice > 0 ? '${StringConstants.rupeeSign}${cartItem.salePrice}' : 'FREE',
                      style: TextHelper.smallTextStyle.copyWith(color: Colors.transparent),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
