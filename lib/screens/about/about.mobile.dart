/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/text.helper.dart';

class AboutScreenMobile extends StatefulWidget {
  const AboutScreenMobile({super.key});

  @override
  State<AboutScreenMobile> createState() => _AboutScreenMobileState();
}

class _AboutScreenMobileState extends State<AboutScreenMobile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'About Amanapay',
            ),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * .02),
                if (provider.appSettings != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Text(
                      provider.appSettings!.aboutUs,
                      maxLines: 10000000000,
                      style: TextHelper.normalTextStyle,
                    ),
                  ),
                SizedBox(height: height * .1),
              ],
            ),
          ),
        );
      },
    );
  }
}
