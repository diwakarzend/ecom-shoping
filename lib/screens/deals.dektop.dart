/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';

import '../routes/router.gr.dart';

class DealsScreendesktop extends StatefulWidget {
  final bool fromCart;

  const DealsScreendesktop({super.key, this.fromCart = false});

  @override
  State<DealsScreendesktop> createState() => _DealsScreendesktopState();
}

class _DealsScreendesktopState extends State<DealsScreendesktop> {
  int trialIndex = 0;

  final CartHelper _cartHelper = CartHelper();

  bool gridview = true;
  Brand? selectedBrand;
  Category? selectedCategory;

  addFirebaseAnalyticsHotProducts(AppProvider provider) async {
    await FirebaseAnalytics.instance.logViewItemList(
      itemListId: 'hot deal store',
      itemListName: 'Hot Deal Products',
      items: List<AnalyticsEventItem>.from(provider.dealProducts.map((x) => x.toGAP())),
    );
  }

  int selectedPage = 1;

  List<Product> generateList(AppProvider provider, int page) {
    int count = 60;
    if (selectedBrand != null && trialIndex > 0) {
      List<Product> products = provider.dealProducts
          .where((element) => element.category?.id == provider.dealCategories[(trialIndex - 1)].id && element.brandId == selectedBrand?.id)
          .toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    } else if (selectedBrand != null && trialIndex == 0) {
      List<Product> products = provider.dealProducts.where((element) => element.brand?.id == selectedBrand?.id).toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    } else if (trialIndex > 0 && selectedBrand == null) {
      List<Product> products = provider.dealProducts.where((element) => element.category?.id == provider.dealCategories[(trialIndex - 1)].id).toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    } else {
      List<Product> products = provider.dealProducts.toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          setState(() {
            selectedPage++;
          });
        }
      },
    );
    super.initState();
  }

  bool supportExpanded = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        addFirebaseAnalyticsHotProducts(provider);
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
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            primary: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopAppBar(),
                // SizedBox(height: height * .06),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: width * .12),
                //   alignment: Alignment.center,
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Expanded(
                //         child: InkWell(
                //           onTap: () => context.router.navigate(const TrialRoute()),
                //           child: Container(
                //             width: double.infinity,
                //             height: height * .07,
                //             decoration: BoxDecoration(
                //               color: ColorConstants.dealColor,
                //               border: Border.all(color: ColorConstants.colorBorder),
                //               borderRadius: BorderRadius.circular(10),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.black.withOpacity(0.1),
                //                   blurRadius: 15,
                //                   offset: const Offset(0, 4),
                //                 ),
                //               ],
                //             ),
                //             alignment: Alignment.center,
                //             child: Text(
                //               'Shop Minis here',
                //               textAlign: TextAlign.center,
                //               style: TextHelper.subTitleStyle.copyWith(
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(width: width * .05),
                //       Expanded(
                //         child: InkWell(
                //           // onTap: () => context.router.navigate(const DealsRoute()),
                //           child: Container(
                //             width: double.infinity,
                //             height: height * .07,
                //             decoration: BoxDecoration(
                //               color: ColorConstants.colorBlueTwentyTwo,
                //               border: Border.all(color: ColorConstants.colorBlueTwentyTwo),
                //               borderRadius: BorderRadius.circular(10),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.black.withOpacity(0.1),
                //                   blurRadius: 15,
                //                   offset: const Offset(0, 4),
                //                 ),
                //               ],
                //             ),
                //             alignment: Alignment.center,
                //             child: Text(
                //               'Shop Deals',
                //               textAlign: TextAlign.center,
                //               style: TextHelper.subTitleStyle.copyWith(
                //                 fontWeight: FontWeight.w600,
                //                 color: Colors.white,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(width: width * .05),
                //       Expanded(
                //         child: InkWell(
                //           onTap: () => context.router.navigate(const BrandProductsRoute()),
                //           child: Container(
                //             width: double.infinity,
                //             height: height * .07,
                //             decoration: BoxDecoration(
                //               color: ColorConstants.sampleColor,
                //               border: Border.all(color: ColorConstants.colorBorder),
                //               borderRadius: BorderRadius.circular(10),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.black.withOpacity(0.1),
                //                   blurRadius: 15,
                //                   offset: const Offset(0, 4),
                //                 ),
                //               ],
                //             ),
                //             alignment: Alignment.center,
                //             child: Text(
                //               'Free Samples',
                //               textAlign: TextAlign.center,
                //               style: TextHelper.subTitleStyle.copyWith(
                //                 fontWeight: FontWeight.w600,
                //               ),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: height * .06),
                (provider.banners
                        .where((element) => element.type == StringConstants.referBanner && element.deviceType == StringConstants.deviceTypeD)
                        .isNotEmpty)
                    ? CarouselSlider(
                        items: provider.banners
                            .where((element) => element.type == StringConstants.referBanner && element.deviceType == StringConstants.deviceTypeD)
                            .map(
                              (e) => ClipRRect(
                                // borderRadius: BorderRadius.circular(10),
                                child: CustomNetworkImage(
                                  imageUrl: e.banner,
                                  width: width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            .toList(),
                        options: CarouselOptions(
                          disableCenter: true,
                          viewportFraction: 1,
                          height: height * .8,
                          autoPlay: true,
                        ),
                      )
                    : const SizedBox.shrink(),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: width * .12),
                //   alignment: Alignment.center,
                //   child: Padding(
                //     padding: EdgeInsets.only(top: height * .05),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.max,
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Expanded(
                //           child: SingleChildScrollView(
                //             scrollDirection: Axis.horizontal,
                //             child: Row(
                //               mainAxisSize: MainAxisSize.max,
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               crossAxisAlignment: CrossAxisAlignment.center,
                //               children: [
                //                 NewCategoryItems(
                //                   key: const Key('d_all'),
                //                   onTap: () {
                //                     setState(() {
                //                       trialIndex = 0;
                //                     });
                //                   },
                //                   active: trialIndex == 0,
                //                   name: 'All',
                //                 ),
                //                 ...provider.dealCategories
                //                     .asMap()
                //                     .map(
                //                       (i, c) => MapEntry(
                //                         i,
                //                         NewCategoryItems(
                //                           key: Key(c.id),
                //                           onTap: () {
                //                             setState(() {
                //                               trialIndex = i + 1;
                //                             });
                //                           },
                //                           active: (trialIndex == (i + 1)),
                //                           name: c.name,
                //                         ),
                //                       ),
                //                     )
                //                     .values,
                //               ],
                //             ),
                //           ),
                //         ),
                //         const SizedBox(width: 20),
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.symmetric(vertical: height * .05),
                    scrollDirection: Axis.vertical,
                    addAutomaticKeepAlives: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: generateList(provider, selectedPage).length,
                    itemBuilder: (BuildContext context, int index) {
                      final Product product = generateList(provider, selectedPage)[index];
                      return DealItemDesktop(
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
                        gridView: true, sub_category: '',
                      );
                    },
                  ),
                ),
                const BottomAppBarPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
