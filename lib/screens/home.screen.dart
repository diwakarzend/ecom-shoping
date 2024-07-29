/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/screens/home.desktop.dart';
import 'package:fabpiks_web/screens/home.mobile.dart';
import 'package:fabpiks_web/screens/home.tab.dart';
import 'package:flutter/material.dart';

import '../style/responsive.dart';

@RoutePage(name: 'HomeRoute')
class HomeScreen extends StatelessWidget {
  final bool orderSuccess;
  final Order? order;

  const HomeScreen({
    super.key,
    this.orderSuccess = false,
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: const HomeScreenMobile(),
      desktop: HomeScreenDesktop(order: order, orderSuccess: orderSuccess),
      tablet: const HomeScreenTab(),
    );
  }
}
