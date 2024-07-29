/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage(name: 'FilterRoute')
class FilterScreen extends StatefulWidget {
  final Brand? selectedBrand;
  final Category? selectedCategory;
  final String screenName;
  final String? productType;
  final Function({Brand? brand, Category? category}) onSubmit;

  const FilterScreen({
    super.key,
    required this.onSubmit,
    this.selectedBrand,
    this.selectedCategory,
    required this.screenName,
    this.productType,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int activeFilterIndex = 0;
  Brand? selectedBrand;
  Category? selectedCategory;

  initValues() {
    selectedBrand = widget.selectedBrand;
    selectedCategory = widget.selectedCategory;
    if (mounted) setState(() {});
  }

  List<Category> filterCategories(AppProvider provider) {
    switch (widget.screenName) {
      case 'brand_p':
        if (widget.productType == 'mini') {
          return provider.categories.where((element) => provider.miniProducts.any((p) => p.category?.id == element.id)).toList();
        } else {
          return provider.categories.where((element) => provider.sampleProducts.any((p) => p.category?.id == element.id)).toList();
        }
      // case 'reward':
      //   return provider.categories
      //       .where((element) => provider.rewardProducts.any((p) => p.category?.id == element.id))
      //       .toList();
      default:
        return [];
    }
  }

  List<Brand> filterBrands(AppProvider provider) {
    switch (widget.screenName) {
      case 'brand':
        return provider.brands.where((element) => provider.sampleProducts.any((p) => p.brandId == element.id)).toList();
      case 'deal':
        return provider.brands.where((element) => provider.sampleProducts.any((p) => p.brandId == element.id)).toList();
      // case 'reward':
      //   return provider.brands.where((element) => provider.rewardProducts.any((p) => p.brandId == element.id)).toList();
      case 'category':
        if (widget.productType == 'mini') {
          return provider.brands.where((element) => provider.miniProducts.any((p) => p.brandId == element.id)).toList();
        } else {
          return provider.brands.where((element) => provider.dealProducts.any((p) => p.brandId == element.id)).toList();
        }
      default:
        return provider.brands.where((element) => provider.miniProducts.any((p) => p.brandId == element.id)).toList();
    }
  }

  @override
  void initState() {
    initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text('More Filters'),
            actions: [
              TextButton(
                onPressed: () {
                  if (widget.screenName == 'trial') {
                    setState(() {
                      selectedBrand = null;
                    });
                  } else {
                    setState(() {
                      selectedBrand = selectedCategory = null;
                    });
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: ColorConstants.colorRedFive,
                  textStyle: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                child: const Text('Clear All'),
              ),
            ],
          ),
          body: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: height,
                  decoration: const BoxDecoration(
                    color: ColorConstants.colorGreySixteen,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * .03),
                      if (widget.screenName != 'brand_p')
                        InkWell(
                          onTap: () {
                            setState(() {
                              activeFilterIndex = 0;
                            });
                          },
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorConstants.colorGreyTwo.withOpacity(0.5),
                                  width: 0.2,
                                ),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Brand',
                              style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreySeventeen),
                            ),
                          ),
                        ),
                      if (widget.screenName == 'brand_p' && filterCategories(provider).isNotEmpty)
                        InkWell(
                          onTap: () {
                            setState(() {
                              activeFilterIndex = 1;
                            });
                          },
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorConstants.colorGreyTwo.withOpacity(0.5),
                                  width: 0.2,
                                ),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Category',
                              style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreySeventeen),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: IndexedStack(
                    index: activeFilterIndex,
                    children: [
                      if (widget.screenName != 'brand_p')
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * .03),
                              ...filterBrands(provider).map(
                                (e) => Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: ColorConstants.colorGreyTwo.withOpacity(0.5),
                                        width: 0.2,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Radio(
                                        value: e,
                                        groupValue: selectedBrand,
                                        activeColor: ColorConstants.colorBlueFive,
                                        onChanged: (_) {
                                          setState(() {
                                            selectedBrand = e;
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Text(
                                          e.name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreySeventeen),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (widget.screenName == 'brand_p')
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * .03),
                              ...filterCategories(provider).map(
                                (e) => Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: ColorConstants.colorGreyTwo.withOpacity(0.5),
                                        width: 0.2,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Radio(
                                        value: e,
                                        groupValue: selectedCategory,
                                        activeColor: ColorConstants.colorBlueFive,
                                        onChanged: (_) {
                                          setState(() {
                                            selectedCategory = e;
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: Text(
                                          e.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorGreySeventeen),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            width: width,
            height: height * .07 + MediaQuery.of(context).padding.bottom,
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                BuildContext? dialogContext;
                showDialog(
                  context: context,
                  useSafeArea: false,
                  barrierColor: Colors.transparent,
                  builder: (c) {
                    dialogContext = c;
                    return Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: Container(
                        width: width,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Do you want to discard your changes?',
                              textAlign: TextAlign.center,
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'You modified some filters. what would you like to do with these changes?',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.colorGreyEightTeen,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    widget.onSubmit(brand: selectedBrand, category: selectedCategory);
                                  },
                                  child: Text(
                                    'Apply',
                                    style: TextHelper.normalTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.colorBlueFive,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedBrand = selectedCategory = null;
                                    });
                                    dialogContext?.popRoute();
                                    widget.onSubmit(brand: selectedBrand, category: selectedCategory);
                                  },
                                  child: Text(
                                    'Discard',
                                    style: TextHelper.normalTextStyle
                                        .copyWith(fontWeight: FontWeight.w500, color: ColorConstants.colorBlueFive, decoration: TextDecoration.none),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              child: Container(
                width: width,
                height: height * .045,
                decoration: BoxDecoration(
                  color: ColorConstants.colorBlueFive,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Apply',
                  style: TextHelper.titleStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
