/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:badges/badges.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return (provider.wishlist?.count ?? 0) > 0
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: const Text('My Wishlist here'),
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
                body: provider.wishlist != null
                    ? GridView.count(
                        crossAxisCount: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        physics: const BouncingScrollPhysics(),
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: provider.wishlist!.records.map((e) => WishlistProductCard(product: e)).toList(),
                      )
                    : null,
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: const Text('My Wishlist'),
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
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/shooping_cart.png',
                        width: width * .5,
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      'Your Wishlist is empty!',
                      style: TextHelper.titleStyle.copyWith(color: Colors.black.withOpacity(0.6)),
                    ),
                    SizedBox(height: height * .02),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'This feels too light! Go on, add all your favourites.',
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorGreyTwo),
                      ),
                    ),
                    SizedBox(height: height * .02),
                    InkWell(
                      onTap: () {
                        context.router.popUntilRouteWithName(NavigatorRoute.name);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.colorPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Text(
                          'Try Now',
                          style: TextHelper.titleStyle.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
