/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/widgets/order.card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

@RoutePage(name: 'OrderRoute')
class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh(AppProvider provider) async {
    provider.initWithLogin();
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('My Orders'),
            centerTitle: false,
            iconTheme: IconThemeData(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: () => _onRefresh(provider),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * .03),
                  if (provider.currentUser != null)
                    ...provider.currentUser!.orders.map(
                      (e) => OrderCard(order: e),
                    ),
                  if (provider.currentUser != null && provider.currentUser!.orders.isEmpty)
                    Container(
                      width: double.infinity,
                      height: height * .8,
                      margin: const EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        'No order showing \nPull Down To Refresh',
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
