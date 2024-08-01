import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/text.helper.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'About Shipan',
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
