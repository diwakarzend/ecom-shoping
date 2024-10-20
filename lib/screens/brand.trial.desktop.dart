/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';

class BrandTrialDesktopScreen extends StatefulWidget {
  final Brand brand;

  const BrandTrialDesktopScreen({
    super.key,
    required this.brand,
  });

  @override
  State<BrandTrialDesktopScreen> createState() => _BrandTrialDesktopScreenState();
}

class _BrandTrialDesktopScreenState extends State<BrandTrialDesktopScreen> with SingleTickerProviderStateMixin {
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

  bool supportExpanded = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        // addFirebaseAnalyticsRewardCategoryProducts(provider);
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
            controller: _scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopAppBar(),
                SizedBox(height: height * .03),
                ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: CustomNetworkImage(
                    imageUrl: widget.brand.logo,
                    width: width,
                    height: height * .5,
                  ),
                ),
                SizedBox(height: height * .03),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 0;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: width * .1,
                          height: height * .05,
                          decoration: BoxDecoration(
                            color: selectedIndex == 0 ? ColorConstants.colorBlackTwo : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Minis',
                            style: TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == 0 ? Colors.white : ColorConstants.colorBlackTwo,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = 1;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: width * .1,
                          height: height * .05,
                          decoration: BoxDecoration(
                            color: selectedIndex == 1 ? ColorConstants.colorBlackTwo : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Deals & Combo',
                            style: TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == 1 ? Colors.white : ColorConstants.colorBlackTwo,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * .06),
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
                      Product product = generateList(provider, selectedPage)[index];
                      if (product.productType == StringConstants.trialProduct) {
                        return MiniItemDesktop(
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
                          gridView: true,
                        );
                      }
                    },
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
