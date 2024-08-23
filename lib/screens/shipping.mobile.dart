import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingPolicyMobile extends StatefulWidget {
  const ShippingPolicyMobile({super.key});

  @override
  State<ShippingPolicyMobile> createState() => _ShippingPolicyMobileState();
}

class _ShippingPolicyMobileState extends State<ShippingPolicyMobile> {
  bool expandedOne = true, expandedTwo = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Shipping Policy',
            ),
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Delivery and Shipping Policy",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "We normally despatch all our orders within 48-72 hours of receiving the order. We deliver the products throughout the world using our logistic partners DHL, Blue Dart, Speed Post, and for domestic delivery using established Local Couriers depending upon the destination. Depending on the geographic location of the customer it may take about 8 to 14 working days to deliver the product to the customer door.",
                ),
                const SizedBox(height: 16),
                const Text(
                  "Domestic Orders:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "The following conditions are applicable for shipping within India.",
                ),
                const SizedBox(height: 8),
                const Text(
                  "• No Free shipping unless otherwise stated during an offering on the website.",
                ),
                const Text(
                  "• Shipping charges as applicable shall either be there on the site or intimated to the customer if required at the time of placement of order.",
                ),
                const Text(
                  "• Delivery Time: 9:00 AM – 7:00 PM (IST) during Business Days i.e., Monday to Friday only.",
                ),
                const Text(
                  "• We appreciate our customers buying during Holidays, and we make all efforts to ship the goods during Holidays, but we do not guarantee shipping or deliveries during public holidays.",
                ),
                const Text(
                  "• Express shipping charges would be additional and free shipping would not be applicable for Express shipping requests.",
                ),
                const Text(
                  "• Request our customers to plan their shopping & delivery in advance to avoid delays.",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}