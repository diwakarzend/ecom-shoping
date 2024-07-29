/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../style/responsive.dart';
import 'coupon.screen.desktop.dart';
import 'coupon.screen.mobile.dart';
import 'coupon.screen.tab.dart';

@RoutePage(name: 'CouponRoute')
class CouponScreen extends StatelessWidget {
  const CouponScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: CouponScreenMobile(),
      desktop: CouponScreenDesktop(),
      tablet: CouponScreenTab(),
    );
  }
}
