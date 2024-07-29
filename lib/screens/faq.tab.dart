import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/text.helper.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FaqTab extends StatefulWidget {
  const FaqTab({super.key});

  @override
  State<FaqTab> createState() => _FaqTabState();
}

class _FaqTabState extends State<FaqTab> {
  @override
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
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
                ...provider.faqs.map(
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
