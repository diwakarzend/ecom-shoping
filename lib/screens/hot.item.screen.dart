/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/hot.item.desktop.dart';
import 'package:fabpiks_web/screens/hot.item.mobile.dart';
import 'package:fabpiks_web/screens/hot.item.tablet.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart' hide Badge;

@RoutePage(name: 'HotItemRoute')
class HotItemScreen extends StatelessWidget {
  final String productId;

  const HotItemScreen({super.key, @PathParam('id') required this.productId});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: HotItemMobile(productId: productId),
      desktop: HotItemDesktop(productId: productId),
      tablet: HotItemTablet(productId: productId),
    );
  }
}
