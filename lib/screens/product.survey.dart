/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/product.survey.desktop.dart';
import 'package:fabpiks_web/screens/product.survey.mobile.dart';
import 'package:fabpiks_web/screens/product.survey.tab.dart';
import 'package:flutter/material.dart';

import '../style/responsive.dart';

@RoutePage(name: 'ProductSurveyRoute')
class ProductSurvey extends StatelessWidget {
  final String productId;

  // final Survey survey;
  // final Function(bool value, int totaEarning) submit;

  const ProductSurvey({
    super.key,
    // required this.submit,
    @PathParam('id') required this.productId,
    // required this.survey,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: ProductSurveyMobile(productId: productId),
      desktop: ProductSurveyDesktop(productId: productId),
      tablet: ProductSurveyTab(productId: productId),
    );
  }
}
