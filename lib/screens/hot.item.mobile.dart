// ignore_for_file: depend_on_referenced_packages

/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HotItemMobile extends StatefulWidget {
  final String productId;

  const HotItemMobile({super.key, required this.productId});

  @override
  State<HotItemMobile> createState() => _HotItemMobileState();
}

class _HotItemMobileState extends State<HotItemMobile> with TickerProviderStateMixin {
  int productImageIndex = 0, tabIndex = 0, offerCurrentIndex = 0;
  final CartHelper _cartHelper = CartHelper();
  TabController? _tabController;
  bool expanded = true;
  late AnimationController controller;

  // Future<Uri> _createDynamicLink(bool short, String productId) async {
  //   final DynamicLinkParameters parameters = DynamicLinkParameters(
  //     uriPrefix: 'https://app.fabpiks.com',
  //     link: Uri.parse('https://app.fabpiks.com/?product=$productId'),
  //     androidParameters: const AndroidParameters(
  //       packageName: 'com.fabpiks.fabpiks',
  //       minimumVersion: 0,
  //     ),
  //     iosParameters: const IOSParameters(
  //       bundleId: 'com.fabpiks.fabpiks',
  //       minimumVersion: '0',
  //     ),
  //   );
  //
  //   Uri url;
  //   if (short) {
  //     final ShortDynamicLink shortLink = await dynamicLinks.buildShortLink(parameters);
  //     url = shortLink.shortUrl;
  //   } else {
  //     url = await dynamicLinks.buildLink(parameters);
  //   }
  //   return url;
  // }

  addFirebaseProduct() async {
    await FirebaseAnalytics.instance.logViewItem(
      currency: 'INR',
      value: _product?.productType == StringConstants.trialProduct || _product?.productType == StringConstants.brandStoreProduct
          ? 0
          : _product?.salePrice.toDouble(),
      items: [_product!.toGAP()],
    );

    // await facebookAppEvents.logViewContent(
    //   id: _product?.id,
    //   type: 'product',
    //   currency: 'INR',
    //   price: _product?.productType == StringConstants.trialProduct || _product?.productType == StringConstants.brandStoreProduct
    //       ? 0
    //       : _product?.salePrice.toDouble(),
    // );
  }

  // YoutubePlayerController? _controller;

  final DioHelper _dioHelper = DioHelper();

  likeProduct(AppProvider provider) async {
    final Response? response = await _dioHelper.post(
      'like',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
      data: {
        'product_id': _product?.id,
        'like': 1,
      },
    );
    if (response != null && response.data['status']) {
      provider.initWithLogin();
      if (!mounted) return;
      ScaffoldSnackBar.of(context).show('Product liked');
      if (mounted) {
        setState(() {
          _product?.like++;
        });
      }
    } else {
      if (response != null && response.data.containsKey('msg')) {
        if (!mounted) return;
        ScaffoldSnackBar.of(context).show(response.data['msg']);
      } else {
        if (!mounted) return;
        ScaffoldSnackBar.of(context).show('Something went wrong');
      }
      log(response?.data.toString() ?? '');
    }
  }

  Product? _product;

  initProduct(AppProvider provider) {
    _product = provider.dealProducts.firstWhereOrNull((element) => element.id == widget.productId);
    if (_product != null) {
      _tabController ??= TabController(length: _product!.details.length, vsync: this);
      addFirebaseProduct();
      controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 400),
        reverseDuration: const Duration(milliseconds: 400),
      );
      if (_product?.videoLink != null) {
        // _controller = YoutubePlayerController(
        //   initialVideoId: _product!.videoLink!.replaceAll('https://youtu.be/', ''),
        //   flags: const YoutubePlayerFlags(
        //     autoPlay: false,
        //     mute: false,
        //   ),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        initProduct(provider);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            actions: [
              IconButton(
                iconSize: 25,
                onPressed: () async {
                  // final link = await _createDynamicLink(true, _product!.id);
                  // FlutterShare.share(
                  //   title: 'Checkout this cool product',
                  //   text: 'Checkout this cool product',
                  //   linkUrl: link.toString(),
                  // );
                },
                icon: const Icon(
                  Ionicons.share_social_outline,
                ),
              ),
              IconButton(
                iconSize: 25,
                onPressed: () async {
                  _cartHelper.addToWishList(provider: provider, context: context, productId: _product!.id);
                },
                icon: provider.wishlist?.records.any((element) => element.productId == _product?.id) ?? false
                    ? const Icon(
                        Ionicons.heart,
                        color: Colors.red,
                      )
                    : const Icon(
                        Ionicons.heart_outline,
                      ),
              ),
              IconButton(
                onPressed: () {
                  context.router.push(const CartRoute());
                },
                color: ColorConstants.colorBlackThree,
                iconSize: 35,
                icon: Badge(
                  showBadge: (provider.cart?.count ?? 0) > 0,
                  badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                  position: BadgePosition.topEnd(top: 0, end: 0),
                  badgeContent: Text(
                    provider.cart?.count.toString() ?? '',
                    style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                  ),
                  child: const Icon(
                    Ionicons.cart_outline,
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    if (_product != null)
                      CarouselSlider(
                        items: [
                          ..._product!.images
                              .asMap()
                              .map(
                                (i, img) => MapEntry(
                                  i,
                                  InkWell(
                                    onTap: () => context.router.push(ImageGalleryRoute(images: _product!.images, index: i)),
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                                      width: width,
                                      height: width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: ColorConstants.colorBlackTwo.withOpacity(0.5),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CustomNetworkImage(
                                          imageUrl: img,
                                          width: width,
                                          height: height,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .values,
                          // if (_controller != null)
                          //   Padding(
                          //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          //     child: YoutubePlayer(
                          //       controller: _controller!,
                          //       showVideoProgressIndicator: true,
                          //     ),
                          //   ),
                        ],
                        options: CarouselOptions(
                          aspectRatio: 1,
                          enableInfiniteScroll: false,
                          viewportFraction: 0.98,
                          onPageChanged: (i, r) {
                            setState(() {
                              productImageIndex = i;
                            });
                          },
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      left: width * .1,
                      child: Container(
                        transform: Matrix4.translationValues(0, height * .04, 0),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: width * .25,
                        width: width * .25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: ColorConstants.colorBlackTwo.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CustomNetworkImage(
                            imageUrl: _product?.brand?.logo ?? '',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * .01),
                if (_product != null)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ..._product!.images
                          .asMap()
                          .map(
                            (i, v) => MapEntry(
                              i,
                              Container(
                                width: productImageIndex == i ? 30 : 10,
                                height: 10,
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: productImageIndex == i
                                    ? BoxDecoration(
                                        color: ColorConstants.colorBlackTwo,
                                        borderRadius: BorderRadius.circular(5),
                                        shape: BoxShape.rectangle,
                                      )
                                    : const BoxDecoration(
                                        color: ColorConstants.colorGreyFive,
                                        shape: BoxShape.circle,
                                      ),
                              ),
                            ),
                          )
                          .values,
                      // if (_controller != null)
                      //   Container(
                      //     width: productImageIndex == _product?.images.length ? 30 : 10,
                      //     height: 10,
                      //     margin: const EdgeInsets.symmetric(horizontal: 2),
                      //     decoration: productImageIndex == _product?.images.length
                      //         ? BoxDecoration(
                      //             color: ColorConstants.colorPrimary,
                      //             borderRadius: BorderRadius.circular(5),
                      //             shape: BoxShape.rectangle,
                      //           )
                      //         : const BoxDecoration(
                      //             color: ColorConstants.colorGreyFive,
                      //             shape: BoxShape.circle,
                      //           ),
                      //   ),
                    ],
                  ),
                SizedBox(height: height * .02),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () => _cartHelper.addToCart(provider: provider, context: context, productId: _product!.id),
                    child: Container(
                      margin: const EdgeInsets.only(right: 25),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                        color: ColorConstants.colorBlueEighteen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextHelper.normalTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text.rich(
                    TextSpan(
                      text: _product?.brand != null ? _product?.brand!.name : '',
                      style: TextHelper.normalTextStyle.copyWith(color: ColorConstants.colorGreyTwo, fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: ' ${_product?.name}',
                          style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * .01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Text(
                        'MRP',
                        style: TextHelper.subTitleStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.colorBlackTwo,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Rs. ${_product?.mrp}',
                        style: TextHelper.subTitleStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.colorBlackTwo,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Rs. ${_product?.salePrice}',
                        style: TextHelper.subTitleStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorConstants.colorBlackTwo,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: height * .02),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.colorBlackTwo.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        child: Row(
                          children: [
                            if (_product != null)
                              RatingBar.builder(
                                initialRating: _cartHelper.ratingCalculation(provider, _product!),
                                minRating: 1,
                                direction: Axis.horizontal,
                                ignoreGestures: true,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 15,
                                itemPadding: EdgeInsets.zero,
                                itemBuilder: (context, _) => const Icon(
                                  Ionicons.star,
                                  color: ColorConstants.colorStar,
                                ),
                                onRatingUpdate: (rating) {
                                  debugPrint(rating.toString());
                                },
                              ),
                            const SizedBox(width: 5),
                            if (_product != null)
                              Text(
                                _cartHelper.ratingCalculation(provider, _product!).toStringAsFixed(1),
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => likeProduct(provider),
                        child: const Icon(
                          Ionicons.thumbs_up_outline,
                          color: ColorConstants.colorBlackTwo,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _product?.like.toString() ?? '',
                        style: TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  // padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.colorBlackTwo.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: 'Secure Payments',
                                style: TextHelper.normalTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.colorGreyEight.withOpacity(0.6),
                                ),
                                children: [
                                  TextSpan(
                                    text: '\nDummy Text',
                                    style: TextHelper.normalTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/upi.png', height: 20),
                                const SizedBox(width: 7),
                                Image.asset('assets/images/master.png', height: 20),
                                const SizedBox(width: 7),
                                Image.asset('assets/images/visa.png', height: 20),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: height * .1,
                        color: ColorConstants.colorBlack.withOpacity(0.5),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Trusted Delivery \n(3-5 Days)',
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.colorGreyEight.withOpacity(0.6),
                              ),
                            ),
                            // const SizedBox(height: 10),
                            // Row(
                            //   mainAxisSize: MainAxisSize.max,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Image.asset('assets/images/ship_rocket.png', height: 15),
                            //     const SizedBox(width: 10),
                            //     Image.asset('assets/images/pikkr_logo.png', height: 15),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * .02),
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: ColorConstants.colorBottomNavigation,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_product != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: Colors.black,
                            indicatorColor: ColorConstants.colorBlackTwo,
                            labelStyle: TextHelper.smallTextStyle,
                            onTap: (i) => setState(() {
                              tabIndex = i;
                            }),
                            tabs: _product!.details
                                .map(
                                  (e) => Tab(
                                    text: e.label,
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      if (_product != null)
                        IndexedStack(
                          index: tabIndex,
                          children: _product!.details
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  child: Text(
                                    e.description,
                                    maxLines: 1000000,
                                    style: TextHelper.smallTextStyle,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                    ],
                  ),
                ),
                if (provider.feedbacks.any((element) => element.productId == _product?.id && element.review.isNotEmpty)) SizedBox(height: height * .02),
                if (provider.feedbacks.any((element) => element.productId == _product?.id && element.review.isNotEmpty))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Reviews',
                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorGreyThree),
                        ),
                        InkWell(
                          onTap: () {
                            context.router.push(
                              RatingRoute(product: _product!),
                            );
                          },
                          child: Text(
                            'View All',
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreyThree),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (provider.feedbacks.any((element) => element.productId == _product?.id && element.review.isNotEmpty)) SizedBox(height: height * .02),
                if (provider.feedbacks.any((element) => element.productId == _product?.id && element.review.isNotEmpty))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: provider.feedbacks
                          .where((element) => element.productId == _product?.id && element.review.isNotEmpty)
                          .take(provider.feedbacks.where((element) => element.productId == _product?.id && element.review.isNotEmpty).length > 4
                              ? 4
                              : provider.feedbacks.where((element) => element.productId == _product?.id && element.review.isNotEmpty).length)
                          .toList()
                          .map(
                            (e) => Container(
                              width: (width - 60) / 2,
                              height: height * .09,
                              decoration: BoxDecoration(
                                color: ColorConstants.colorSample,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name ?? (e.user?.firstName ?? ''),
                                    style: TextHelper.normalTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.colorBlackTwo,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      e.review,
                                      maxLines: 2,
                                      style: TextHelper.normalTextStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: ColorConstants.colorGreyTwenty,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                SizedBox(height: height * .02),
                if (provider.dealProducts
                    .where((element) => _product?.brand != null && element.brandId == _product?.brand!.id && element.id != _product?.id)
                    .isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'More from ${_product?.brand != null ? _product?.brand!.name : ''}',
                          style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorGreyThree),
                        ),
                        InkWell(
                          onTap: () {
                            context.router.push(BrandTrialRoute(brand: _product!.brand!));
                          },
                          child: Text(
                            'View All',
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreyThree),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (provider.dealProducts
                    .where((element) => _product?.brand != null && element.brandId == _product?.brand!.id && element.id != _product?.id)
                    .isNotEmpty)
                  SizedBox(height: height * .02),
                if (provider.dealProducts
                    .where((element) => _product?.brand != null && element.brandId == _product?.brand!.id && element.id != _product?.id)
                    .isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CarouselSlider.builder(
                      itemCount: (provider.dealProducts.where((element) => element.brandId == _product?.brandId).length > 10
                          ? 10
                          : provider.dealProducts.where((element) => element.brandId == _product?.brand?.id).length),
                      itemBuilder: (BuildContext context, int index, int i) {
                        Product product = provider.dealProducts.where((element) => element.brandId == _product?.brandId).toList()[index];
                        return DealItems(
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
                        aspectRatio: 1.3,
                        viewportFraction: 0.47,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        disableCenter: true,
                        padEnds: false,
                      ),
                    ),
                  ),
                SizedBox(height: height * .02),
              ],
            ),
          ),
          bottomNavigationBar: InkWell(
            onTap: () => _cartHelper.addToCart(
              provider: provider,
              context: context,
              productId: _product!.id,
            ),
            child: Container(
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: height * .06,
              decoration: BoxDecoration(
                color: ColorConstants.colorBlueEighteen,
                borderRadius: BorderRadius.circular(height * .05),
              ),
              alignment: Alignment.center,
              child: Text(
                'Add to Cart',
                style: TextHelper.subTitleStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
