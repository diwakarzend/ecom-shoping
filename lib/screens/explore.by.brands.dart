/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/brand.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

// @RoutePage(name: 'ExploreByBrandsRoute')
class ExploreByBrandsMobile extends StatefulWidget {
  const ExploreByBrandsMobile({super.key,});

  @override
  State<ExploreByBrandsMobile> createState() => _ExploreByBrandsMobileState();
}

class _ExploreByBrandsMobileState extends State<ExploreByBrandsMobile> {
  int selectedPage = 1;

  List<Brand> generateList(AppProvider provider, int page) {
    int count = 27;
    List<Brand> brands = provider.brands.toList();
    if (brands.length > (count * page)) {
      return brands.take((count * page)).toList();
    } else {
      return brands;
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
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Explore By Brands'),
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
          body: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 3,
            ),
            itemCount: generateList(provider, selectedPage).length,
            itemBuilder: (BuildContext context, int index) {
              final Brand e = generateList(provider, selectedPage)[index];
              return InkWell(
                onTap: () {
                  context.router.push(BrandTrialRoute(brand: e));
                },
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorConstants.colorBlack.withOpacity(0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: e.logo.isNotEmpty ? CustomNetworkImage(imageUrl: e.logo) : null,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
