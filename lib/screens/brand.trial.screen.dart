/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/screens/brand.trial.desktop.dart';
import 'package:fabpiks_web/screens/brand.trial.mobile.dart';
import 'package:fabpiks_web/screens/brand.trial.tablet.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart' hide Badge;

@RoutePage(name: 'BrandTrialRoute')
class BrandTrialScreen extends StatelessWidget {
  final Brand brand;

  const BrandTrialScreen({
    super.key,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: BrandTrialMobileScreen(brand: brand),
      desktop: BrandTrialDesktopScreen(brand: brand),
      tablet: BrandTrialTabletScreen(brand: brand),
    );
  }
}
