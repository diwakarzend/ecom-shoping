/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQHelpMobile extends StatefulWidget {
  const FAQHelpMobile({super.key});

  @override
  State<FAQHelpMobile> createState() => _FAQHelpMobileState();
}

class _FAQHelpMobileState extends State<FAQHelpMobile> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        final modifiedFaqs = provider.faqs.map((faq) {
          final modifiedQuestion = faq.question.replaceAll(
            'What is Agile?',
            'What is Anampro?',
          );
          final modifiedAnswer = faq.answer
              .replaceAll('game.ship9x.com/', 'shop.anamprocloth.com/')
              .replaceAll('shipantechprivatelimited5@gmail.com', 'anamprotechnologypvtltd@gmail.com');

          return faq.copyWith(question: modifiedQuestion, answer: modifiedAnswer);
        }).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'FAQ\'s',
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
                SizedBox(height: height * .03),
                ...modifiedFaqs.map(
                      (e) => Theme(
                    data: ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: width * .1),
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
                          style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
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
                            style: TextHelper.smallTextStyle,
                          ),
                        ],
                      ),
                    ),
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