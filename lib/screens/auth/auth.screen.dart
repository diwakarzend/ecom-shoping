/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/auth/auth.tab.dart';
import 'package:flutter/material.dart';

import '../../style/responsive.dart';
import 'auth.desktop.dart';
import 'auth.mobile.dart';

@RoutePage(name: 'AuthRoute')
class AuthScreen extends StatelessWidget {
  final bool logOut;

  const AuthScreen({
    super.key,
    this.logOut = false,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: AuthScreenMobile(logOut: logOut),
      desktop: AuthDesktop(logOut: logOut),
      tablet: AuthScreenTab(logOut: logOut),
    );
  }
}
