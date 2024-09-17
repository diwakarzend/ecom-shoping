import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyMobile extends StatefulWidget {
  const PrivacyPolicyMobile({super.key});

  @override
  State<PrivacyPolicyMobile> createState() => _PrivacyPolicyMobileState();
}

class _PrivacyPolicyMobileState extends State<PrivacyPolicyMobile> {
  bool expandedOne = true, expandedTwo = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        String privacyPolicyText = provider.appSettings?.privacy ?? '';
        privacyPolicyText = privacyPolicyText
            .replaceAll('AGILE PAYMENT SERVICES PRIVATE LIMITED', 'ANAMPRO TECHNOLOGY PRIVATE LIMITED')
            .replaceAll('agilepaymentservicesprivatelim@gmail.com', 'anamprotechnologypvtltd@gmail.com@gmail.com')
            .replaceAll('Agile', 'Anampro')
            .replaceAll('AGILE', 'ANAMPRO')
            .replaceAll('Unit No. 364, 3rd Floor, Aggarwal Plaza, Sec-14, Prashant Vihar, North West Delhi, Delhi- 110085 ',
            'SHOP NO. 2, UPPER GROUND FLOOR, BLOCK-N, KIRTI NAGAR NEW DELHI-110015.');

        return Scaffold(
          appBar: AppBar(
            title: const Text('Privacy Policy'),
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
                      privacyPolicyText,
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