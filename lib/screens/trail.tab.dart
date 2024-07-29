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
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

// @RoutePage(name: 'TrialRoute')
class TrailScreenTab extends StatefulWidget {
  const TrailScreenTab({
    super.key,
  });

  @override
  State<TrailScreenTab> createState() => _TrailScreenTabState();
}

class _TrailScreenTabState extends State<TrailScreenTab> {
  int trialIndex = 0;

  final CartHelper _cartHelper = CartHelper();

  bool gridview = true;

  addFirebaseAnalyticsTrialProducts(AppProvider provider) async {
    await FirebaseAnalytics.instance.logViewItemList(
      itemListId: 'trial store',
      itemListName: 'Trial store products',
      items: List<AnalyticsEventItem>.from(provider.miniProducts.map((x) => x.toGAP())),
    );
  }

  addFirebaseAnalyticsHotProducts(AppProvider provider) async {
    await FirebaseAnalytics.instance.logViewItemList(
      itemListId: 'trial store',
      itemListName: 'Hot Deal products',
      items: List<AnalyticsEventItem>.from(provider.miniProducts.map((x) => x.toGAP())),
    );
  }

  Brand? selectedBrand;
  Category? selectedCategory;

  int selectedPage = 1;

  List<Product> generateList(AppProvider provider, int page) {
    int count = 6;
    if (selectedBrand != null && trialIndex > 0) {
      List<Product> products = provider.miniProducts
          .where((element) => element.category?.id == provider.miniCategories[(trialIndex - 1)].id && element.brandId == selectedBrand?.id)
          .toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    } else if (selectedBrand != null && trialIndex == 0) {
      List<Product> products = provider.miniProducts.where((element) => element.brand?.id == selectedBrand?.id).toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    } else if (trialIndex > 0 && selectedBrand == null) {
      List<Product> products = provider.miniProducts.where((element) => element.category?.id == provider.miniCategories[(trialIndex - 1)].id).toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    } else {
      List<Product> products = provider.miniProducts.toList();
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        addFirebaseAnalyticsTrialProducts(provider);
        addFirebaseAnalyticsHotProducts(provider);
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (provider.banners.where((element) => element.type == StringConstants.trialBanner).isNotEmpty)
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, height * .02, 20, 0),
                      child: CarouselSlider.builder(
                        itemCount: provider.banners.where((element) => element.type == StringConstants.trialBanner).length,
                        itemBuilder: (BuildContext context, int i, int index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomNetworkImage(
                              imageUrl: provider.banners.where((element) => element.type == StringConstants.trialBanner).toList()[index].banner,
                              width: width,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          height: height * .25,
                          viewportFraction: 1,
                          // autoPlay: true,
                          // autoPlayInterval: const Duration(seconds: 2),
                          padEnds: true,
                        ),
                      ),
                    ),
                  SizedBox(height: height * .02),
                  Align(
                    child: Text(
                      'Shop Minis',
                      style: TextHelper.subTitleStyle.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: height * .01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Align(
                      child: Text(
                        'Shop Mini\'s: Choose from our wide range of brands & categories, Try any ${provider.appSettings?.generalSettings.itemQty} mini products for only Rs ${provider.appSettings?.generalSettings.miniCharge} (all inclusive).',
                        maxLines: 10,
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
                                        context.router.back();
                                        setState(() {
                                          selectedBrand = brand;
                                          selectedCategory = category;
                                        });
                                      },
                                      selectedBrand: selectedBrand,
                                      screenName: 'trial',
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
                                  key: const Key('s_all'),
                                  onTap: () {
                                    setState(() {
                                      trialIndex = 0;
                                    });
                                  },
                                  active: trialIndex == 0,
                                  name: 'All',
                                ),
                                ...provider.miniCategories
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
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.vertical,
                    addAutomaticKeepAlives: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridview ? 2 : 1,
                      childAspectRatio: gridview ? 0.6 : 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: generateList(provider, selectedPage).length,
                    itemBuilder: (BuildContext context, int index) {
                      final Product product = generateList(provider, selectedPage)[index];
                      return MiniItems(
                        product: product,
                        onProductClick: () {
                          _cartHelper.productClick(context: context, productId: product.id, productType: product.productType, provider: provider);
                        },
                        onProductTry: () {
                          _cartHelper.tryNow(provider: provider, context: context, productId: product.id);
                        },
                        provider: provider,
                        cartHelper: _cartHelper,
                        gridView: true,
                      );
                    },
                  ),
                  SizedBox(height: height * .02),
                  if (provider.banners.where((element) => element.type == StringConstants.trialSmall).isNotEmpty)
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, height * .02, 20, 0),
                      child: CarouselSlider(
                        items: [
                          ...provider.banners.where((element) => element.type == StringConstants.trialSmall).map(
                                (e) => ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
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
                          // autoPlay: true,
                          // autoPlayInterval: const Duration(seconds: 2),
                          height: height * .11,
                          viewportFraction: 1,
                          padEnds: true,
                        ),
                      ),
                    ),
                  SizedBox(height: height * .15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
