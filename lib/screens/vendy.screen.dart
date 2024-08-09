/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/widgets/custom.network.image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendyScreen extends StatelessWidget {
  final Function() vendyFunction;

  const VendyScreen({super.key, required this.vendyFunction});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, AppProvider provider, Widget? _) {
        final height = MediaQuery.of(context).size.height;
        final width = MediaQuery.of(context).size.width;
        return Center(
          child: Stack(
            children: [
              Container(
                width: width,
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: ColorConstants.colorBottomNavigation,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * .02),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      decoration: const BoxDecoration(
                        color: ColorConstants.colorBlueTwenty,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Explore Vendy Machine Products',
                            style: TextHelper.subTitleStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          GridView.count(
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.9,
                            children: [
                              ...provider.vendy!.images.map(
                                (e) => Container(
                                  // width: height * .07,
                                  // height: height * .08,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  alignment: Alignment.center,
                                  child: CustomNetworkImage(
                                    imageUrl: e,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * .02),
                    Text(
                      'Enjoy free samples from our vendy machines!',
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: TextHelper.subTitleStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorConstants.colorBlackTwo,
                      ),
                    ),
                    SizedBox(height: height * .03),
                    if (provider.loginDetails == null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Sign in or Sign up to dispense free samples from our Vendy machines',
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          style: TextHelper.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.colorBlackTwo,
                          ),
                        ),
                      ),
                    if (provider.loginDetails == null) SizedBox(height: height * .03),
                    if (provider.loginDetails == null)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => context.router.push(LoginRoute()),
                            child: Container(
                              width: width * .3,
                              height: height * .04,
                              decoration: BoxDecoration(
                                color: ColorConstants.colorBlueTwenty,
                                borderRadius: BorderRadius.circular(height * .05),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Sign in',
                                style: TextHelper.normalTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Or',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.colorBlackTwo,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.router.push(SignupRoute(referCode: '')),
                            child: Container(
                              width: width * .3,
                              height: height * .04,
                              decoration: BoxDecoration(
                                color: ColorConstants.colorBlueTwenty,
                                borderRadius: BorderRadius.circular(height * .05),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Sign up',
                                style: TextHelper.normalTextStyle.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else
                      GestureDetector(
                        onTap: () => vendyFunction(),
                        child: Container(
                          width: double.infinity,
                          height: height * .045,
                          margin: EdgeInsets.symmetric(horizontal: width * .07),
                          decoration: BoxDecoration(
                            color: ColorConstants.colorBlueTwenty,
                            borderRadius: BorderRadius.circular(height * .04),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'Proceed to Vendy',
                            style: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: height * .03),
                  ],
                ),
              ),
              Positioned(
                right: 5,
                top: 0,
                child: GestureDetector(
                  onTap: () => context.router.maybePopTop(),
                  child: const Material(
                    color: Colors.transparent,
                    elevation: 2,
                    shape: CircleBorder(),
                    child: Icon(
                      Icons.cancel_rounded,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
