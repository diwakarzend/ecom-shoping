/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/refund.desktop.dart';
import 'package:fabpiks_web/screens/refund.mobile.dart';
import 'package:fabpiks_web/screens/refund.tab.dart';
import 'package:flutter/material.dart';

import '../style/responsive.dart';

@RoutePage(name: 'RefundPolicyRoute')
class RefundPolicy extends StatelessWidget {

  const RefundPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: RefundPolicyMobile(),
      desktop: RefundPolicyDesktop(),
      tablet: RefundPolicyTab(),
    );
  }
}
