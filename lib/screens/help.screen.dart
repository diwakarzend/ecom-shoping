/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/help.desktop.dart';
import 'package:fabpiks_web/screens/help.mobile.dart';
import 'package:fabpiks_web/screens/help.tab.dart';
import 'package:flutter/material.dart';

import '../style/responsive.dart';

@RoutePage(name: 'HelpRoute')
class HelpScreen extends StatelessWidget {

  const HelpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: HelpScreenMobile(),
      desktop: HelpScreenDesktop(),
      tablet: HelpTab(),
    );
  }
}
