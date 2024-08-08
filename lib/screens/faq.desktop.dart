/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/text.helper.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQHelpDesktop extends StatefulWidget {
  const FAQHelpDesktop({super.key});

  @override
  State<FAQHelpDesktop> createState() => _FAQHelpDesktopState();
}

class _FAQHelpDesktopState extends State<FAQHelpDesktop> {
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
                  padding: EdgeInsets.only(top: height * .10, left: width * .12, right: width * .12),
                  width: width,
                  height: height * .20,
                  color: const Color(0xff030d4e),
                  child: Text(
                    'FAQ’s',
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: height * .03),
                    ...provider.faqs.map(
                          (e) => Theme(
                        data: ThemeData().copyWith(dividerColor: Colors.transparent),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: width * .12),
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
                            initiallyExpanded: e.expanded,
                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                            expandedAlignment: Alignment.centerLeft,
                            onExpansionChanged: (bool value) {
                              setState(() {
                                e.expanded = !e.expanded;
                              });
                            },
                            title: Text(
                              e.question,
                              maxLines: 5,
                              style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                            ),
                            trailing: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(!e.expanded ? Icons.add_circle_outline_rounded : Icons.remove_circle_outline_rounded),
                            ),
                            childrenPadding: const EdgeInsets.only(bottom: 20),
                            children: [
                              Text(
                                e.answer,
                                maxLines: 100000000,
                                style: TextHelper.extraSmallTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .1),
                  ],
                ),

                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: width * .2,vertical: height * .08),
                //   child: const Text('Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation  Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, cons ectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna ali Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, '
                //       'quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, cons ectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna ali Lorem ipsum dolor sit amet, consectetuer adipiscing elit, '
                //       'sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, cons ectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna ali Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation',style: TextStyle(
                //     fontSize: 20.0,color: Colors.black,fontFamily: 'Montserrat'
                //   ),),
                // ),
                const BottomAppBarPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}