/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/about/about.desktop.dart';
import 'package:fabpiks_web/screens/about/about.mobile.dart';
import 'package:fabpiks_web/screens/about/about.tab.dart';
import 'package:flutter/material.dart';

import '../../style/responsive.dart';

@RoutePage(name: 'AboutRoute')
class AboutScreen extends StatelessWidget {
  final Function(bool success)? onResult;

  const AboutScreen({
    super.key,
    this.onResult,
  });

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: AboutScreenMobile(),
      desktop: AboutDesktop(),
      tablet: AboutTab(),
    );
  }
}
