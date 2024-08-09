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
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';

import 'appbar/top.app.bar.dart';

// @RoutePage(name: 'BrandProductsRoute')
class BrandProductScreenDesktop extends StatefulWidget {
  const BrandProductScreenDesktop({super.key});

  @override
  State<BrandProductScreenDesktop> createState() => _BrandProductScreenDesktopState();
}

class _BrandProductScreenDesktopState extends State<BrandProductScreenDesktop> {
  bool listView = false;
  Brand? selectedBrand;
  Category? selectedCategory;
  int trialIndex = 0;

  bool gridview = true, supportExpanded = false;

  final CartHelper _cartHelper = CartHelper();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
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
                SizedBox(height: height * .06),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => context.router.navigate(const TrialRoute()),
                          child: Container(
                            width: double.infinity,
                            height: height * .07,
                            decoration: BoxDecoration(
                              color: ColorConstants.dealColor,
                              border: Border.all(color: ColorConstants.colorBorder),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Shop Minis',
                              textAlign: TextAlign.center,
                              style: TextHelper.subTitleStyle.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * .05),
                      Expanded(
                        child: InkWell(
                          onTap: () => context.router.navigate(const DealsRoute()),
                          child: Container(
                            width: double.infinity,
                            height: height * .07,
                            decoration: BoxDecoration(
                              color: ColorConstants.sampleColor,
                              border: Border.all(color: ColorConstants.colorBorder),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Shop Deals',
                              textAlign: TextAlign.center,
                              style: TextHelper.subTitleStyle.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * .05),
                      Expanded(
                        child: InkWell(
                          // onTap: () => context.router.navigate(const BrandProductsRoute()),
                          child: Container(
                            width: double.infinity,
                            height: height * .07,
                            decoration: BoxDecoration(
                              color: ColorConstants.colorBlueTwentyTwo,
                              border: Border.all(color: ColorConstants.colorBlueTwentyTwo),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Free Samples',
                              textAlign: TextAlign.center,
                              style: TextHelper.subTitleStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * .06),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: (provider.banners
                          .where((element) =>
                              element.type == StringConstants.brandBanner &&
                              element.deviceType == StringConstants.deviceTypeD)
                          .isNotEmpty)
                      ? CarouselSlider(
                          items: provider.banners
                              .where((element) =>
                                  element.type == StringConstants.brandBanner &&
                                  element.deviceType == StringConstants.deviceTypeD)
                              .map(
                                (e) => ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
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
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: height * .05),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12),
                  alignment: Alignment.center,
                  child: GridView.count(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.symmetric(vertical: height * .05),
                    scrollDirection: Axis.vertical,
                    addAutomaticKeepAlives: true,
                    crossAxisCount: 6,
                    childAspectRatio: 0.5,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      if (selectedBrand != null && trialIndex > 0)
                        ...provider.sampleProducts
                            .where((element) =>
                                element.category?.id == provider.sampleCategories[(trialIndex - 1)].id &&
                                element.brandId == selectedBrand?.id)
                            .map(
                              (e) => SampleItemDesktop(
                                key: Key(e.id),
                                product: e,
                                onProductClick: () => _cartHelper.productClick(
                                    context: context, productId: e.id, productType: e.productType, provider: provider),
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
                              (e) => SampleItemDesktop(
                                key: Key(e.id),
                                product: e,
                                onProductClick: () => _cartHelper.productClick(
                                    context: context, provider: provider, productId: e.id, productType: e.productType),
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
                        ...provider.sampleProducts
                            .where((element) => element.category?.id == provider.sampleCategories[(trialIndex - 1)].id)
                            .map(
                              (e) => SampleItemDesktop(
                                key: Key(e.id),
                                product: e,
                                onProductClick: () => _cartHelper.productClick(
                                    context: context, productType: e.productType, productId: e.id, provider: provider),
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
                          (e) => SampleItemDesktop(
                            key: Key(e.id),
                            product: e,
                            onProductClick: () => _cartHelper.productClick(
                                context: context, productId: e.id, productType: e.productType, provider: provider),
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
