/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../helpers/text.helper.dart';
import '../routes/router.gr.dart';
import '../widgets/custom.network.image.dart';
import '../widgets/data.search.dart';

class CategoriesMobile extends StatefulWidget {
  const CategoriesMobile({super.key});

  @override
  State<CategoriesMobile> createState() => _CategoriesMobileState();
}

class _CategoriesMobileState extends State<CategoriesMobile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('All Categories'),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...provider.categories.toList().map(
                      (e) => InkWell(
                        key: Key(e.id),
                        onTap: () {
                          context.router.push(CategoryProductRoute(categoryId: e.id));
                        },
                        splashFactory: NoSplash.splashFactory,
                        highlightColor: Colors.transparent,
                        child: Container(
                          width: width,
                          clipBehavior: Clip.antiAlias,
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CustomNetworkImage(
                            imageUrl: e.banner ?? '',
                            width: width,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        );
      },
    );
  }
}
