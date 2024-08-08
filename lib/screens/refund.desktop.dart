// Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.

import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefundPolicyDesktop extends StatefulWidget {
  const RefundPolicyDesktop({super.key});

  @override
  State<RefundPolicyDesktop> createState() => _RefundPolicyDesktopState();
}

class _RefundPolicyDesktopState extends State<RefundPolicyDesktop> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        String privacyPolicyText = provider.appSettings?.refund ?? '';
        privacyPolicyText = privacyPolicyText
            .replaceAll('Shipan Tech Private Limited', 'Shubhagmess')
            .replaceAll('shipantechprivatelimited5@gmail.com', 'Privatelimitedshubhpay@gmail.com')
            .replaceAll('Shipan', 'Shubhagmess')
            .replaceAll('shop NO. 2 karim Mansion Behind Pharmacy college', '4th Floor Office No.432 Geras Imperium Star')
            .replaceAll('SHIPAN', 'SHUBHAGMESS');


        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const TopAppBar(),
                Container(
                  padding: EdgeInsets.only(
                      top: height * .10, left: width * .12, right: width * .12),
                  width: width,
                  height: height * .20,
                  color: const Color(0xff030d4e),
                  child: const Text(
                    'Privacy Policy',
                    style: TextStyle(
                        fontSize: 35.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * .12, vertical: height * .08),
                  child: Text(
                    privacyPolicyText,
                    maxLines: 100000000000000000,
                    style: TextHelper.smallTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
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
