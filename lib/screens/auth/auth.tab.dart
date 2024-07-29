/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// @RoutePage(name: 'AuthRoute')
class AuthScreenTab extends StatefulWidget {
  final bool logOut;

  const AuthScreenTab({super.key, this.logOut = false});

  @override
  State<AuthScreenTab> createState() => _AuthScreenTabState();
}

class _AuthScreenTabState extends State<AuthScreenTab> {
  // late AppProvider _appProvider;
  //
  // FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  //
  // Future<void> initDynamicLinks(AppProvider provider) async {
  //   dynamicLinks.onLink.listen(
  //         (dynamicLinkData) {
  //       final query = dynamicLinkData.link.query;
  //       if (query.startsWith('referCode=')) {
  //         String referCode = query.replaceAll('referCode=', '');
  //         Future.delayed(const Duration(seconds: 0)).then(
  //               (_) => context.router.push(SignupRoute(referCode: referCode)),
  //         );
  //       }
  //     },
  //   ).onError(
  //         (error) {
  //       log(error.message.toString());
  //     },
  //   );
  // }
  //
  // @override
  // void initState() {
  //   _appProvider = Provider.of<AppProvider>(context, listen: false);
  //   initDynamicLinks(_appProvider);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: Stack(
            children: [
              Image.asset(
                'assets/images/auth_bg.png',
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .1),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top + height * .1),
                    Image.asset(
                      'assets/images/fab_logo.png',
                      height: height * .05,
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      'Discover exciting brands & products',
                      maxLines: 5,
                      style: TextHelper.largeFontStyle.copyWith(
                        fontSize: 26.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        height: 1,
                        color: ColorConstants.colorBlackTwo,
                      ),
                    ),
                    SizedBox(height: height * .01),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Mini’s',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: ColorConstants.colorLogin,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              color: ColorConstants.colorLogin,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            'Deals & Combo’s',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: ColorConstants.colorLogin,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            width: 5,
                            height: 5,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: const BoxDecoration(
                              color: ColorConstants.colorLogin,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            'Free Samples',
                            style: TextHelper.normalTextStyle.copyWith(
                              color: ColorConstants.colorLogin,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Existing User',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.colorBlackTwo,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () => context.router.push(LoginRoute()),
                              child: Container(
                                // height: height * .05,
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                                decoration: BoxDecoration(
                                  color: ColorConstants.colorBlueSeventeen,
                                  borderRadius: BorderRadius.circular(height * .06),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign in',
                                  style: TextHelper.normalTextStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'New User',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.colorBlackTwo,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () => context.router.push(SignupRoute(referCode: '')),
                              child: Container(
                                // height: height * .05,
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                                decoration: BoxDecoration(
                                  color: ColorConstants.colorBlueSeventeen,
                                  borderRadius: BorderRadius.circular(height * .06),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign up',
                                  style: TextHelper.smallTextStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Or',
                            style: TextHelper.smallTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.colorBlackTwo,
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              provider.loginAsGuest(true);
                              context.router.replace(NavigatorRoute(orderSuccess: false));
                            },
                            child: Container(
                              // height: height * .05,
                              width: width * .6,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                              decoration: BoxDecoration(
                                color: ColorConstants.colorBlueSeventeen,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Explore as Guest',
                                style: TextHelper.smallTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
