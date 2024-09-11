// ignore_for_file: depend_on_referenced_packages

/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'appbar/bottom.app.bar.dart';

class HotItemDesktop extends StatefulWidget {
  final String productId;

  const HotItemDesktop({super.key, required this.productId});

  @override
  State<HotItemDesktop> createState() => _HotItemDesktopState();
}

class _HotItemDesktopState extends State<HotItemDesktop> with TickerProviderStateMixin {
  bool supportExpanded = false, liked = false;
  final CartHelper _cartHelper = CartHelper();

  String? selectedImage;

  final DioHelper _dioHelper = DioHelper();

  TabController? _tabController;

  int tabIndex = 0;

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
          liked = true;
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
    }
  }

  Product? _product;

  initProduct(AppProvider provider) {
    _product = provider.dealProducts.firstWhereOrNull((element) => element.id == widget.productId);
    if (_product != null) {
      selectedImage ??= _product!.images.first;
      _tabController ??= TabController(length: _product!.details.length, vsync: this);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        initProduct(provider);
        return Scaffold(
          backgroundColor: Colors.white,
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopAppBar(),
                SizedBox(height: height * .06),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: width * .12),
                //   alignment: Alignment.center,
                //   child: Container(
                //     margin: EdgeInsets.symmetric(vertical: height * .03),
                //     width: width,
                //     decoration: const BoxDecoration(
                //       color: Colors.transparent,
                //     ),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.max,
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Expanded(
                //           child: InkWell(
                //             onTap: () => context.router.navigate(const TrialRoute()),
                //             child: Container(
                //               width: double.infinity,
                //               height: height * .08,
                //               decoration: BoxDecoration(
                //                 color: ColorConstants.miniColor,
                //                 border: Border.all(color: ColorConstants.colorBorder),
                //                 borderRadius: BorderRadius.circular(10),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: Colors.black.withOpacity(0.1),
                //                     blurRadius: 15,
                //                     offset: const Offset(0, 4),
                //                   ),
                //                 ],
                //               ),
                //               alignment: Alignment.center,
                //               child: Text(
                //                 'Shop Minis',
                //                 textAlign: TextAlign.center,
                //                 style: TextHelper.normalTextStyle.copyWith(
                //                   fontWeight: FontWeight.w600,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //         SizedBox(width: width * .05),
                //         Expanded(
                //           child: InkWell(
                //             onTap: () => context.router.navigate(const DealsRoute()),
                //             child: Container(
                //               width: double.infinity,
                //               height: height * .08,
                //               decoration: BoxDecoration(
                //                 color: ColorConstants.dealColor,
                //                 border: Border.all(color: ColorConstants.colorBorder),
                //                 borderRadius: BorderRadius.circular(10),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: Colors.black.withOpacity(0.1),
                //                     blurRadius: 15,
                //                     offset: const Offset(0, 4),
                //                   ),
                //                 ],
                //               ),
                //               alignment: Alignment.center,
                //               child: Text(
                //                 'Shop Deals',
                //                 textAlign: TextAlign.center,
                //                 style: TextHelper.normalTextStyle.copyWith(
                //                   fontWeight: FontWeight.w600,
                //                   fontSize: 25.0,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //         SizedBox(width: width * .05),
                //         Expanded(
                //           child: InkWell(
                //             onTap: () => context.router.navigate(const BrandProductsRoute()),
                //             child: Container(
                //               width: double.infinity,
                //               height: height * .08,
                //               decoration: BoxDecoration(
                //                 color: ColorConstants.sampleColor,
                //                 border: Border.all(color: ColorConstants.colorBorder),
                //                 borderRadius: BorderRadius.circular(10),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: Colors.black.withOpacity(0.1),
                //                     blurRadius: 15,
                //                     offset: const Offset(0, 4),
                //                   ),
                //                 ],
                //               ),
                //               alignment: Alignment.center,
                //               child: Text(
                //                 'Free Samples',
                //                 textAlign: TextAlign.center,
                //                 style: TextHelper.normalTextStyle.copyWith(
                //                   fontWeight: FontWeight.w600,
                //                   fontSize: 25.0,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: width * .12),
                //   alignment: Alignment.center,
                //   child: Container(
                //     width: width,
                //     height: height * .07,
                //     decoration: BoxDecoration(
                //       border: Border.all(
                //         color: colorBlack.withOpacity(0.6),
                //         width: 2,
                //       ),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     alignment: Alignment.center,
                //     child: Text(
                //       _product?.category?.name ?? '',
                //       style: TextHelper.subTitleStyle.copyWith(
                //         fontWeight: FontWeight.w600,
                //         color: colorBlack.withOpacity(0.6),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(height: height * .06),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(right: width * .03),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (selectedImage != null)
                                AnimatedContainer(
                                  width: double.infinity,
                                  height: height * .45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: ColorConstants.colorBlack.withOpacity(0.6),
                                      width: 1.5,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 300),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CustomNetworkImage(
                                      width: double.infinity,
                                      height: height * .5,
                                      imageUrl: selectedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              SizedBox(height: height * .01),
                              if (_product != null)
                                SingleChildScrollView(
                                  primary: false,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: _product!.images
                                        .map(
                                          (e) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedImage = e;
                                          });
                                        },
                                        splashFactory: NoSplash.splashFactory,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        child: Container(
                                          width: height * .06,
                                          height: height * .08,
                                          margin: const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: ColorConstants.colorBlack.withOpacity(0.6),
                                            ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: CustomNetworkImage(
                                              imageUrl: e,
                                              width: height * .06,
                                              height: height * .08,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                        .toList(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: _product?.brand != null ? _product?.brand!.name : '',
                                style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 15.sp),
                                children: [
                                  TextSpan(
                                    text: ' ${_product?.name}',
                                    style:
                                    TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w600, color: ColorConstants.colorGreyTwo, fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height * .007),
                            Text(
                              'MRP Rs. ${_product?.mrp}',
                              style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.bold, color: ColorConstants.colorBlackTwo, fontSize: 15.sp),
                            ),
                            SizedBox(height: height * .03),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: double.infinity,
                                    height: height * .08,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorConstants.colorBlack.withOpacity(0.6),
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        if (_product != null)
                                          RatingBar.builder(
                                            initialRating: _cartHelper.ratingCalculation(provider, _product!),
                                            minRating: 1,
                                            ignoreGestures: true,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 30,
                                            itemPadding: EdgeInsets.zero,
                                            itemBuilder: (context, _) => const Icon(
                                              Icons.star,
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
                                              fontWeight: FontWeight.w600,
                                              color: ColorConstants.colorBlack,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(width: width * .02),
                                      InkWell(
                                        onTap: () => likeProduct(provider),
                                        child: Icon(
                                          liked ? Ionicons.thumbs_up : Ionicons.thumbs_up_outline,
                                          color: liked ? ColorConstants.colorBlueSeventeen : ColorConstants.colorBlueSeventeen,
                                          size: 35,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        _product?.like.toString() ?? '',
                                        // "500",
                                        style: TextHelper.normalTextStyle.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstants.colorBlack.withOpacity(0.6),
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * .04),
                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                    style: TextHelper.extraSmallTextStyle.copyWith(
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
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Image.asset('assets/images/upi.png', height: 30),
                                                const SizedBox(width: 7),
                                                Image.asset('assets/images/master.png', height: 30),
                                                const SizedBox(width: 7),
                                                Image.asset('assets/images/visa.png', height: 30),
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
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Trusted Delivery(3-5 Days)',
                                              maxLines: 3,
                                              textAlign: TextAlign.center,
                                              style: TextHelper.normalTextStyle.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: ColorConstants.colorGreyEight.withOpacity(0.6),
                                              ),
                                            ),
                                            // const SizedBox(height: 20),
                                            // Row(
                                            //   mainAxisSize: MainAxisSize.max,
                                            //   mainAxisAlignment: MainAxisAlignment.start,
                                            //   crossAxisAlignment: CrossAxisAlignment.start,
                                            //   children: [
                                            //     Image.asset('assets/images/ship_rocket.png', height: 25),
                                            //     const SizedBox(width: 10),
                                            //     Image.asset('assets/images/pikkr_logo.png', height: 25),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: height * .03,
                            // ),
                            // InkWell(
                            //   onTap: () => _cartHelper.addToCart(provider: provider, context: context, productId: _product!.id),
                            //   child: Container(
                            //     alignment: Alignment.center,
                            //     height: height * .07,
                            //     width: width * .17,
                            //     padding: EdgeInsets.symmetric(vertical: 4, horizontal: width * .01),
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(10),
                            //       color: Colors.blueAccent,
                            //     ),
                            //     child: Text(
                            //       'Add to Cartrrrrrr',
                            //       style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * .06),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: Container(
                    width: width,
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
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
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
                ),
                SizedBox(height: height * .04),
                if (provider.dealProducts
                    .where((element) => _product?.brand != null && element.brandId == _product?.brand!.id && element.id != _product?.id)
                    .isNotEmpty)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * .12),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'More from ${_product?.brand != null ? _product?.brand!.name : ''}',
                          // style: TextHelper.normalTextStyle.copyWith(
                          style: TextHelper.normalTextStyle.copyWith(
                            color: ColorConstants.colorGreyThree,
                            fontWeight: FontWeight.w600,
                            // fontWeight: FontWeight.w600,
                          ),
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
                  SizedBox(height: height * .03),
                if (provider.dealProducts
                    .where((element) => _product?.brand != null && element.brandId == _product?.brand!.id && element.id != _product?.id)
                    .isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * .06),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            )),
                        Expanded(
                          flex: 12,
                          child: CarouselSlider.builder(
                            itemCount: (provider.dealProducts.where((element) => element.brandId == _product?.brandId).length > 10
                                ? 10
                                : provider.dealProducts.where((element) => element.brandId == _product?.brand?.id).length),
                            itemBuilder: (BuildContext context, int index, int i) {
                              Product product = provider.dealProducts.where((element) => element.brandId == _product?.brandId).toList()[index];
                              return DealItemDesktop(
                                product: product,
                                onProductClick: () =>
                                    _cartHelper.productClick(context: context, productId: product.id, productType: product.productType, provider: provider),
                                provider: provider,
                                cartHelper: _cartHelper,
                                gridView: false,
                                onAddToCart: () {
                                  _cartHelper.addToCart(
                                    provider: provider,
                                    context: context,
                                    productId: product.id,
                                  );
                                }, sub_category: '',
                              );
                            },
                            options: CarouselOptions(
                              // aspectRatio: 4.5,
                              // viewportFraction: 0.15,
                              // initialPage: 0,
                              // enableInfiniteScroll: false,
                              // reverse: false,
                              // disableCenter: true,
                              // padEnds: false,
                              aspectRatio: 3.4,
                              viewportFraction: .2,
                              // viewportFraction: 0.15,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              reverse: false,
                              disableCenter: true,
                              padEnds: false,
                              autoPlay: true,
                            ),
                          ),
                        ),
                        const Expanded(
                            flex: 1,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                SizedBox(height: height * .06),
                const BottomAppBarPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}