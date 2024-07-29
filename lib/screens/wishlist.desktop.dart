/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';

// @RoutePage(name: 'WishlistRoute')
class WishlistScreenDesktop extends StatefulWidget {
  const WishlistScreenDesktop({super.key});

  @override
  State<WishlistScreenDesktop> createState() => _WishlistScreenDesktopState();
}

class _WishlistScreenDesktopState extends State<WishlistScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return (provider.wishlist?.count ?? 0) > 0
            ? Scaffold(
                backgroundColor: Colors.white,
                // appBar: AppBar(
                //   title: const Text('My Wishlist Desktop hello'),
                //   iconTheme: const IconThemeData(color: Colors.black),
                //   elevation: 0,
                //   actions: [
                //     IconButton(
                //       onPressed: () {
                //         context.router.push(const CartRoute());
                //       },
                //       color: colorBlackThree,
                //       iconSize: 35,
                //       icon: Badge(
                //         showBadge: provider.cartItems.isNotEmpty,
                //         badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                //         position: BadgePosition.topEnd(top: 0, end: 0),
                //         badgeContent: Text(
                //           provider.cartItems.length.toString(),
                //           style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                //         ),
                //         child: const Icon(
                //           Ionicons.cart_outline,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const TopAppBar(),
                      Container(
                        padding: EdgeInsets.only(top: height * .13, left: width * .12, right: width * .12),
                        width: width,
                        height: height * .25,
                        color: const Color(0xff030d4e),
                        child: const Text(
                          'Wishlist',
                          style: TextStyle(fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                        ),
                      ),
                      if (provider.wishlist != null)
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 5,
                          padding: EdgeInsets.symmetric(horizontal: width * .12, vertical: 30),
                          physics: const BouncingScrollPhysics(),
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          children: provider.wishlist!.records.map((e) => WishlistProductCard(product: e)).toList(),
                        ),
                      const BottomAppBarPage(),
                    ],
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                // appBar: AppBar(
                //   title: const Text('wishlist here'),
                //   iconTheme: const IconThemeData(color: Colors.black),
                //   elevation: 0,
                //   actions: [
                //     // IconButton(
                //     //   onPressed: () {
                //     //     showSearch(context: context, delegate: DataSearch());
                //     //   },
                //     //   icon: const Icon(
                //     //     Ionicons.search_outline,
                //     //   ),
                //     // ),
                //     IconButton(
                //       onPressed: () {
                //         context.router.push(const CartRoute());
                //       },
                //       color: colorBlackThree,
                //       iconSize: 35,
                //       icon: Badge(
                //         showBadge: provider.cartItems.isNotEmpty,
                //         badgeStyle: const BadgeStyle(badgeColor: Colors.red),
                //         position: BadgePosition.topEnd(top: 0, end: 0),
                //         badgeContent: Text(
                //           provider.cartItems.length.toString(),
                //           style: TextHelper.smallTextStyle.copyWith(color: Colors.white),
                //         ),
                //         child: const Icon(
                //           Ionicons.cart_outline,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TopAppBar(),
                      Container(
                        padding: EdgeInsets.only(top: height * .23, left: width * .12, right: width * .12),
                        width: width,
                        height: height * .20,
                        color: const Color(0xff030d4e),
                        child: const Text(
                          'Wishlist',
                          style: TextStyle(fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/shooping_cart.png',
                          width: width * .1,
                        ),
                      ),
                      // SizedBox(height: height * .02),
                      Text(
                        'Your Wishlist is empty!',
                        style: TextHelper.smallTextStyle.copyWith(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: height * .02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'This feels too light! Go on, add all your favourites.',
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextHelper.extraSmallTextStyle.copyWith(color: ColorConstants.colorGreyTwo),
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
                          child: InkWell(
                            onTap: () {
                              context.router.navigate(HomeRoute());
                            },
                            child: Text(
                              'Try Now',
                              style: TextHelper.extraSmallTextStyle.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * .02),
                      const BottomAppBarPage(),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
