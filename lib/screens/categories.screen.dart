/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/categories.desktop.dart';
import 'package:fabpiks_web/screens/categories.mobile.dart';
import 'package:fabpiks_web/screens/categories.tablet.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart' hide Badge;

@RoutePage(name: 'CategoryRoute')
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: CategoriesMobile(),
      desktop: CategoriesDesktop(),
      tablet: CategoriesTablet(),
    );
  }
}
