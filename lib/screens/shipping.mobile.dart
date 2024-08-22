import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingPolicyMobile extends StatefulWidget {
  const ShippingPolicyMobile({super.key});

  @override
  State<ShippingPolicyMobile> createState() => _ShippingPolicyMobileState();
}

class _ShippingPolicyMobileState extends State<ShippingPolicyMobile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        final String shippingPolicyText = """
Delivery and Shipping Policy

We normally despatch all our orders within 48-72 hours of receiving the order. We deliver the products throughout the world using our logistic partners DHL, Blue Dart, Speed Post, and for domestic delivery using established Local Couriers depending upon the destination. Depending on the geographic location of the customer it may take about 8 to 14 working days to deliver the product to the customer door.

Domestic Orders:

The following conditions are applicable for shipping within India.

• No Free shipping unless otherwise stated during an offering on the website.
• Shipping charges as applicable shall either be there on the site or intimated to the customer if required at the time of placement of order.
• Delivery Time: 9:00 AM – 7:00 PM (IST) during Business Days i.e., Monday to Friday only.
• We appreciate our customers buying during Holidays, and we make all efforts to ship the goods during Holidays, but we do not guarantee shipping or deliveries during public holidays.
• Express shipping charges would be additional and free shipping would not be applicable for Express shipping requests.
• Request our customers to plan their shopping & delivery in advance to avoid delays.
""";

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
                  child: const Text(
                    'Shipping Policy',
                    style: TextStyle(
                        fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .12, vertical: height * .08),
                  child: Text(
                    shippingPolicyText,
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
