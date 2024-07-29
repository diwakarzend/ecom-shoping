/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

// import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/account.desktop.dart';
import 'package:fabpiks_web/screens/profile.modile.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'ProfileRoute')
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: ProfileScreenMobile(),
      desktop: AccountPage(),
    );
  }
}
