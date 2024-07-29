/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/helpers/cart.helper.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/widgets.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:provider/provider.dart';

import '../routes/router.gr.dart';

class CategoriesDesktop extends StatefulWidget {
  const CategoriesDesktop({super.key});

  @override
  State<CategoriesDesktop> createState() => _CategoriesDesktopState();
}

class _CategoriesDesktopState extends State<CategoriesDesktop> {
  bool supportExpanded = false;
  final CartHelper _cartHelper = CartHelper();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopAppBar(),
                SizedBox(height: height * .06),
                ...provider.categories.toList().map(
                      (e) => Container(
                        margin: EdgeInsets.symmetric(horizontal: width * .12),
                        alignment: Alignment.center,
                        child: InkWell(
                          key: Key(e.id),
                          onTap: () {
                            context.router.push(CategoryProductRoute(categoryId: e.id));
                          },
                          splashFactory: NoSplash.splashFactory,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CustomNetworkImage(
                                imageUrl: e.banner ?? '',
                                width: width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
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
