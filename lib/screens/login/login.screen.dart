/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/login/login.mobile.dart';
import 'package:fabpiks_web/screens/login/login.tab.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart';

import 'login.desktop.dart';

@RoutePage(name: 'LoginRoute')
class LoginScreen extends StatelessWidget {
  final Function(bool success)? onResult;

  const LoginScreen({
    super.key,
    this.onResult,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: LoginScreenMobile(onResult: onResult),
      desktop: LoginPageDeskTop(onResult: onResult),
      tablet: LoginScreenTab(onResult: onResult),
    );
  }
}
