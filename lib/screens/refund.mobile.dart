import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RefundPolicyMobile extends StatefulWidget {
  const RefundPolicyMobile({super.key});

  @override
  State<RefundPolicyMobile> createState() => _RefundPolicyMobileState();
}

class _RefundPolicyMobileState extends State<RefundPolicyMobile> {
  bool expandedOne = true, expandedTwo = false;

  String privacyPolicyText = """
  Shipan Tech Private Limited
  shipantechprivatelimited5@gmail.com
  Shipan
shop NO. 2,karim Mansion,Behind Pharmacy college Panaji, North Goa, Goa, 403001
 SHIPAN
  """;

  @override
  void initState() {
    super.initState();
    privacyPolicyText = privacyPolicyText
        .replaceAll('Shipan Tech Private Limited', 'PRESTIGEPAY SOLUTIONS PRIVATE LIMITED')
        .replaceAll('shipantechprivatelimited5@gmail.com', 'info.prestigepaypvtltd@gmail.com')
        .replaceAll('Shipan', 'Prestigepay')
        .replaceAll('shop NO. 2,karim Mansion,Behind Pharmacy college Panaji, North Goa, Goa, 403001', '364 3RD FLR AGGARWALPLAZA, COMM CENTER SEC14, Rithala, North West Delhi, Delhi- 110085')
        .replaceAll('SHIPAN', 'PRESTIGEPAY');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Refund Policy'),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(''),
                if (provider.appSettings != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * .05),
                    child: Text(
                      provider.appSettings!.refund,
                      maxLines: 10000000,
                      style: TextHelper.normalTextStyle,
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .05),
                  child: Text(
                    privacyPolicyText,
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