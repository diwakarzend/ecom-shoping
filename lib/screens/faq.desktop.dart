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
        final modifiedFaqs = provider.faqs.map((faq) {
          final modifiedQuestion = faq.question
              .replaceAll('What is Agile?', 'What is Anampro?');

          final modifiedAnswer = faq.answer
              .replaceAll('game.agilecloth.com/', 'shop.anamprocloth.com')
              .replaceAll('Agile', 'Anampro')
              .replaceAll('shipantechprivatelimited5@gmail.com', 'anamprotechnologypvtltd@gmail.com');

          return faq.copyWith(question: modifiedQuestion, answer: modifiedAnswer);
        }).toList();

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
                    ...modifiedFaqs.map(
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
                const BottomAppBarPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}