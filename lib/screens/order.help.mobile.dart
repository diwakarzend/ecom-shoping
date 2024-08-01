/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// @RoutePage(name: 'OrderHelpRoute')
class OrderHelpMobile extends StatefulWidget {
  const OrderHelpMobile({super.key});

  @override
  State<OrderHelpMobile> createState() => OrderHelpMobileState();
}

class OrderHelpMobileState extends State<OrderHelpMobile> {
  bool expandedOne = true, expandedTwo = false;

  late UrlHelper _urlHelper;

  @override
  void initState() {
    _urlHelper = UrlHelper.internal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Help Center',
          ),
          centerTitle: false,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * .03),
            Text(
              'Orders',
              style: TextHelper.titleStyle,
            ),
            SizedBox(height: height * .03),
            Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: width * .05),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConstants.colorGreyTwo.withOpacity(0.6),
                      width: 0.5,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  controlAffinity: ListTileControlAffinity.platform,
                  iconColor: ColorConstants.colorGreyTwo,
                  collapsedIconColor: ColorConstants.colorGreyTwo,
                  tilePadding: EdgeInsets.zero,
                  collapsedBackgroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  maintainState: true,
                  initiallyExpanded: true,
                  onExpansionChanged: (bool value) {
                    setState(() {
                      expandedOne = !expandedOne;
                    });
                  },
                  title: Text(
                    'What is Shipan?',
                    style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorGreyTwentyTwo),
                  ),
                  trailing: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(!expandedOne ? Icons.add_circle_outline_rounded : Icons.remove_circle_outline_rounded),
                  ),
                  childrenPadding: const EdgeInsets.only(bottom: 20),
                  children: [
                    Text(
                      'We are an online product sampling community that provides you with products from leading brands to sample/try for free. We have products ranging from body care, to exotic teas to cosmetics. We also specialize in brands that are ayurvedic, herbal, chemical free and halal certified as we want to help you with your overall wellness. We are here to build up a community where brands and consumers can meet, wherein consumers get to experience and choose the perfect brand for them and this very experience shared helps the brand improve and make their products more efficient.',
                      maxLines: 1000000,
                      style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorGreyTwentyThree),
                    ),
                  ],
                ),
              ),
            ),
            Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: width * .05),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: ColorConstants.colorGreyTwo.withOpacity(0.6),
                      width: 0.5,
                    ),
                  ),
                ),
                child: ExpansionTile(
                  controlAffinity: ListTileControlAffinity.platform,
                  iconColor: ColorConstants.colorGreyTwo,
                  collapsedIconColor: ColorConstants.colorGreyTwo,
                  tilePadding: EdgeInsets.zero,
                  collapsedBackgroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  maintainState: true,
                  onExpansionChanged: (bool value) {
                    setState(() {
                      expandedTwo = !expandedTwo;
                    });
                  },
                  title: Text(
                    'I just joined what to do next?',
                    style: TextHelper.subTitleStyle.copyWith(color: ColorConstants.colorGreyTwentyTwo),
                  ),
                  trailing: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(!expandedTwo ? Icons.add_circle_outline_rounded : Icons.remove_circle_outline_rounded),
                  ),
                  childrenPadding: const EdgeInsets.only(bottom: 20),
                  children: [
                    Text(
                      'We are an online product sampling community that provides you with products from leading brands to sample/try for free. We have products ranging from body care, to exotic teas to cosmetics. We also specialize in brands that are ayurvedic, herbal, chemical free and halal certified as we want to help you with your overall wellness. We are here to build up a community where brands and consumers can meet, wherein consumers get to experience and choose the perfect brand for them and this very experience shared helps the brand improve and make their products more efficient.',
                      maxLines: 100000,
                      style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorGreyTwentyThree),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * .03),
            InkWell(
              onTap: () => _urlHelper.launchNonUrl(url: 'mailto:${provider.appSettings?.generalSettings.companyEmail}'),
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: width * .1),
                decoration: const BoxDecoration(
                  color: ColorConstants.colorBlueEight,
                ),
                alignment: Alignment.center,
                child: Text(
                  'Mail us at : ${provider.appSettings?.generalSettings.companyEmail}',
                  style: TextHelper.subTitleStyle.copyWith(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: height * .02),
          ],
        ),
      );
    });
  }
}
