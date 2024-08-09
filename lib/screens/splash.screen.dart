/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage(name: 'SplashRoute')
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppProvider _appProvider;

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    if (kIsWeb) {
      if (Device.width >= 1024) {
        context.router.replace(HomeRoute());
      } else {
        context.router.replace(
          NavigatorRoute(orderSuccess: false),
        );
      }
    } else {
      Future.delayed(const Duration(seconds: 5)).then(
        (_) {
          if (_appProvider.loginDetails != null || _appProvider.guestLogin) {
            if (kIsWeb) {
              if (!mounted) return;
              context.router.replace(HomeRoute());
            } else {
              if (!mounted) return;
              context.router.replace(
                NavigatorRoute(orderSuccess: false),
              );
            }
          } else {
            if (mounted) {
              context.router.replace(
                AuthRoute(logOut: false),
              );
            }
          }
          // remove login function
          // context.router.replace(NavigatorRoute(fromSignup: false, orderSuccess: false));
        },
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? const SizedBox.shrink()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Image.asset(
                'assets/animations/logo.gif',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
