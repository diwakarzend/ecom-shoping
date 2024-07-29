/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../routes/router.gr.dart';

// @RoutePage(name: 'BrandProductsRoute')
class BrandProductScreenTab extends StatefulWidget {
  const BrandProductScreenTab({super.key});

  @override
  State<BrandProductScreenTab> createState() => _BrandProductScreenTabState();
}

class _BrandProductScreenTabState extends State<BrandProductScreenTab> {
  addFirebaseAnalyticsBrandProducts(AppProvider provider) async {
    await FirebaseAnalytics.instance.logViewItemList(
      itemListId: 'brand store',
      itemListName: 'Brand store products',
      items: List<AnalyticsEventItem>.from(provider.dealProducts.map((x) => x.toGAP())),
    );
  }

  bool listView = false;
  Brand? selectedBrand;
  Category? selectedCategory;
  int trialIndex = 0;

  bool gridview = true;

  final CartHelper _cartHelper = CartHelper();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        addFirebaseAnalyticsBrandProducts(provider);
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            primary: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (provider.banners.where((element) => element.type == StringConstants.brandBanner).isNotEmpty)
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, height * .03, 20, 0),
                    child: CarouselSlider(
                      items: [
                        ...provider.banners.where((element) => element.type == StringConstants.brandBanner).map(
                              (e) => Container(
                                key: Key(e.id),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: CustomNetworkImage(
                                  imageUrl: e.banner,
                                  width: width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      ],
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        height: height * .23,
                        viewportFraction: 1,
                        padEnds: true,
                      ),
                    ),
                  ),
                SizedBox(height: height * .02),
                Align(
                  child: Text(
                    'Free Samples',
                    style: TextHelper.subTitleStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: height * .01),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Align(
                    child: Text(
                      'Free Samples: Explore exciting brands & products for free! Apply for our free sample offers & if you are a match, you only pay a small delivery free ( max Rs 40-80) to get the product home delivered.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: height * .02),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .1),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Badge(
                        showBadge: selectedBrand != null,
                        position: BadgePosition.topEnd(top: 7, end: 7),
                        child: Row(
                          children: [
                            Text(
                              'Filter',
                              style: TextHelper.smallTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.colorBlackTwo,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.router.push(
                                  FilterRoute(
                                    onSubmit: ({Brand? brand, Category? category}) {
                                      context.router.popUntilRouteWithName(BrandProductsRoute.name);
                                      setState(() {
                                        selectedBrand = brand;
                                        selectedCategory = category;
                                      });
                                    },
                                    selectedBrand: selectedBrand,
                                    screenName: 'brand',
                                  ),
                                );
                              },
                              icon: const Icon(Ionicons.filter),
                              color: ColorConstants.colorBlueNineteen,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Grid View',
                            style: TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.colorBlackTwo,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                gridview = !gridview;
                              });
                            },
                            icon: gridview ? const Icon(Ionicons.grid) : const Icon(Ionicons.list),
                            color: ColorConstants.colorBlueNineteen,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * .02),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              NewCategoryItems(
                                key: const Key('b_all'),
                                onTap: () {
                                  setState(() {
                                    trialIndex = 0;
                                  });
                                },
                                active: trialIndex == 0,
                                name: 'All',
                              ),
                              ...provider.sampleCategories
                                  .asMap()
                                  .map(
                                    (i, c) => MapEntry(
                                      i,
                                      NewCategoryItems(
                                        key: Key(c.id),
                                        onTap: () {
                                          setState(() {
                                            trialIndex = i + 1;
                                          });
                                        },
                                        active: (trialIndex == (i + 1)),
                                        name: c.name,
                                      ),
                                    ),
                                  )
                                  .values,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
                SizedBox(height: height * .02),
                GridView.count(
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: gridview ? 2 : 1,
                  childAspectRatio: gridview ? 0.6 : 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    if (selectedBrand != null && trialIndex > 0)
                      ...provider.sampleProducts
                          .where((element) => element.category?.id == provider.sampleCategories[(trialIndex - 1)].id && element.brandId == selectedBrand?.id)
                          .map(
                            (e) => SampleItems(
                              key: Key(e.id),
                              product: e,
                              onProductClick: () => _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                              onTry: () => _cartHelper.applyToTry(
                                provider: provider,
                                context: context,
                                productId: e.id,
                                width: width,
                                height: height,
                              ),
                              provider: provider,
                              cartHelper: _cartHelper,
                              gridView: true,
                            ),
                          )
                    else if (selectedBrand != null && trialIndex == 0)
                      ...provider.sampleProducts.where((element) => element.brand?.id == selectedBrand?.id).map(
                            (e) => SampleItems(
                              key: Key(e.id),
                              product: e,
                              onProductClick: () => _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                              onTry: () => _cartHelper.applyToTry(
                                provider: provider,
                                context: context,
                                productId: e.id,
                                width: width,
                                height: height,
                              ),
                              provider: provider,
                              cartHelper: _cartHelper,
                              gridView: true,
                            ),
                          )
                    else if (trialIndex > 0 && selectedBrand == null)
                      ...provider.sampleProducts.where((element) => element.category?.id == provider.sampleCategories[(trialIndex - 1)].id).map(
                            (e) => SampleItems(
                              key: Key(e.id),
                              product: e,
                              onProductClick: () => _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                              onTry: () => _cartHelper.applyToTry(
                                provider: provider,
                                context: context,
                                productId: e.id,
                                width: width,
                                height: height,
                              ),
                              provider: provider,
                              cartHelper: _cartHelper,
                              gridView: true,
                            ),
                          )
                    else
                      ...provider.sampleProducts.map(
                        (e) => SampleItems(
                          key: Key(e.id),
                          product: e,
                          onProductClick: () => _cartHelper.productClick(context: context, productId: e.id, productType: e.productType, provider: provider),
                          onTry: () => _cartHelper.applyToTry(
                            provider: provider,
                            context: context,
                            productId: e.id,
                            width: width,
                            height: height,
                          ),
                          provider: provider,
                          cartHelper: _cartHelper,
                          gridView: true,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: height * .2),
              ],
            ),
          ),
        );
      },
    );
  }
}
