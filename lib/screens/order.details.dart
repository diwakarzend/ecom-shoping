// ignore_for_file: depend_on_referenced_packages

/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/order.details.desktop.dart';
import 'package:fabpiks_web/screens/order.details.mobile.dart';
import 'package:fabpiks_web/screens/order.details.tablet.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'OrderDetailsRoute')
class OrderDetails extends StatelessWidget {
  final String orderId;

  const OrderDetails({super.key, @PathParam('id') required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: OrderDetailsMobile(orderID: orderId),
      desktop: OrderDetailsDesktop(orderID: orderId),
      tablet: OrderDetailsTablet(orderID: orderId),
    );
  }
}
