/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/signup.desktop.dart';
import 'package:fabpiks_web/screens/signup.mobile.dart';
import 'package:flutter/material.dart';

import '../style/responsive.dart';

@RoutePage(name: 'SignupRoute')
class SignupScreen extends StatelessWidget {
  final Function(bool success)? onResult;

  const SignupScreen({
    super.key,
    this.onResult,
    required String referCode,
  });

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: SignupScreenMobile(),
      desktop: SignupScreenDesktop(),
    );
  }
}
