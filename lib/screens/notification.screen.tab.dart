/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// @RoutePage(name: 'NotificationRoute')
class NotificationScreenTab extends StatefulWidget {
  const NotificationScreenTab({super.key});

  @override
  State<NotificationScreenTab> createState() => _NotificationScreenTabMobileState();
}

class _NotificationScreenTabMobileState extends State<NotificationScreenTab> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh(AppProvider provider) async {
    provider.initWithLogin();
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Notification'),
            centerTitle: false,
          ),
          body: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: () => _onRefresh(provider),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ...provider.reports
                      .where((element) =>
                          element.product != null &&
                          element.product!.stock > 0 &&
                          element.productId != null &&
                          element.qualified &&
                          !element.rejected &&
                          provider.currentUser != null &&
                          !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                      .map(
                    (e) {
                      return Container(
                        width: width,
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(4, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomNetworkImage(
                              imageUrl: e.product?.image ?? '',
                              width: width * .14,
                              height: width * .14,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'YOUR FREE SAMPLES HAS BEEN APPROVED',
                                    maxLines: 2,
                                    style: TextHelper.smallTextStyle.copyWith(
                                      color: ColorConstants.colorBlueTwentyOne,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  InkWell(
                                    onTap: () {
                                      if (provider.cart != null && provider.cart!.records.any((element) => element.id == e.productId)) {
                                        ScaffoldSnackBar.of(context).show('Already added to cart');
                                      } else {
                                        if (e.product != null) {
                                          provider.addCartItems(productID: e.productId ?? '');
                                          ScaffoldSnackBar.of(context).show('Product added to cart');
                                        } else {
                                          ScaffoldSnackBar.of(context).show('Something went wrong');
                                        }
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: ColorConstants.colorBlueTwentyOne,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'Add to cart',
                                        style: TextHelper.extraSmallTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '"Hurry! Our exclusive offer is valid until stocks are available. Don\'t miss out, ORDER NOW"',
                                    maxLines: 5,
                                    style: TextHelper.extraSmallTextStyle.copyWith(
                                      color: Colors.black.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (provider.reports
                      .where((element) =>
                          element.productId != null &&
                          element.qualified &&
                          !element.rejected &&
                          provider.currentUser != null &&
                          !provider.currentUser!.orders.any((e) => e.products.any((o) => o.id == element.product?.id)))
                      .isEmpty)
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'No approvals showing \nPull Down To Refresh',
                        textAlign: TextAlign.center,
                        style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
