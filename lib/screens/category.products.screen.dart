/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/category.dekstop.tablet.dart';
import 'package:fabpiks_web/screens/category.products.dekstop.dart';
import 'package:fabpiks_web/screens/category.products.mobile.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'CategoryProductRoute')
class CategoryProductsScreen extends StatelessWidget {
  final String categoryId;

  const CategoryProductsScreen({super.key, @PathParam('id') required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: CategoryProductsMobileScreen(categoryId: categoryId),
      desktop: CategoryProductsDesktopScreen(categoryId: categoryId),
      tablet: CategoryProductsTabletScreen(categoryId: categoryId),
    );
  }
}
