/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/helpers/text.helper.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// @RoutePage(name: 'AboutRoute')
class AboutDesktop extends StatefulWidget {
  const AboutDesktop({super.key});

  @override
  State<AboutDesktop> createState() => _AboutDesktopState();
}

class _AboutDesktopState extends State<AboutDesktop> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const TopAppBar(),
                Container(
                  padding: EdgeInsets.only(top: height * .23, left: width * .13),
                  width: width,
                  height: height * .35,
                  color: const Color(0xff030d4e),
                  child: const Text(
                    'About us',
                    style: TextStyle(fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .2, vertical: height * .08),
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
                            provider.appSettings!.aboutUs
                                .replaceAll('agile', 'execute'),
                            maxLines: 10000000000,
                            style: TextHelper.smallTextStyle,
                          ),
                        ),
                      SizedBox(height: height * .1),
                    ],
                  ),
                ),
                const BottomAppBarPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
