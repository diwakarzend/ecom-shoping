/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../routes/router.gr.dart';

class BrandTrialMobileScreen extends StatefulWidget {
  final Brand brand;

  const BrandTrialMobileScreen({
    super.key,
    required this.brand,
  });

  @override
  State<BrandTrialMobileScreen> createState() => _BrandTrialMobileScreenState();
}

class _BrandTrialMobileScreenState extends State<BrandTrialMobileScreen> with SingleTickerProviderStateMixin {
  bool listView = false;
  Brand? selectedBrand;
  Category? selectedCategory;

  int selectedIndex = 0;

  int bannerIndexOne = 0, bannerIndexTwo = 0;

  final CartHelper _cartHelper = CartHelper();

  bool gridview = true;

  int selectedPage = 1;

  List<Product> generateList(AppProvider provider, int page) {
    int count = 6;
    if (selectedIndex == 0 && selectedCategory != null) {
      List<Product> products =
          provider.miniProducts.where((element) => element.brand?.id == widget.brand.id && element.category?.id == selectedCategory?.id).toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    } else if (selectedIndex == 0 && selectedCategory == null) {
      List<Product> products = provider.miniProducts.where((element) => element.brand?.id == widget.brand.id).toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    } else if (selectedIndex != 0 && selectedCategory != null) {
      List<Product> products =
          provider.dealProducts.where((element) => element.brand?.id == widget.brand.id && element.category?.id == selectedCategory?.id).toList();
      if (products.length > (count * page)) {
        return products.take((count * page)).toList();
      } else {
        return products;
      }
    } else {
      List<Product> products = provider.dealProducts.where((element) => element.brand?.id == widget.brand.id).toList();
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
    selectedBrand = widget.brand;
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
        // addFirebaseAnalyticsRewardCategoryProducts(provider);
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.brand.name),
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
                icon: const Icon(
                  Ionicons.search_outline,
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            controller: _scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * .03),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomNetworkImage(
                    imageUrl: widget.brand.logo,
                    width: width,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: height * .02),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          height: height * .05,
                          decoration: BoxDecoration(
                            color: selectedIndex == 0 ? ColorConstants.colorBlackTwo : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Minis',
                            style: TextHelper.subTitleStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == 0 ? Colors.white : ColorConstants.colorBlackTwo,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          height: height * .05,
                          decoration: BoxDecoration(
                            color: selectedIndex == 1 ? ColorConstants.colorBlackTwo : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Deals & Combo',
                            style: TextHelper.subTitleStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == 1 ? Colors.white : ColorConstants.colorBlackTwo,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                        showBadge: selectedCategory != null,
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
                                    productType: selectedIndex == 0 ? 'mini' : 'deal',
                                    selectedCategory: selectedCategory,
                                    screenName: 'brand_p',
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
                GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridview ? 2 : 1,
                    childAspectRatio: gridview ? 0.6 : 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: generateList(provider, selectedPage).length,
                  itemBuilder: (BuildContext context, int index) {
                    final Product product = generateList(provider, selectedPage)[index];
                    if (product.productType == StringConstants.trialProduct) {
                      return MiniItems(
                        key: Key(product.id),
                        product: product,
                        onProductClick: () =>
                            _cartHelper.productClick(context: context, productId: product.id, productType: product.productType, provider: provider),
                        onProductTry: () => _cartHelper.tryNow(
                          provider: provider,
                          context: context,
                          productId: product.id,
                        ),
                        provider: provider,
                        cartHelper: _cartHelper,
                        gridView: true,
                      );
                    } else {
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
                        gridView: true,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
