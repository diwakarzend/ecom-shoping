import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ContactUsMobile extends StatefulWidget {
  const ContactUsMobile({super.key});

  @override
  State<ContactUsMobile> createState() => _ContactUsMobileState();
}

class _ContactUsMobileState extends State<ContactUsMobile> {
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
              'Contact Us',
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
                  'CONTACT US',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Phone:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '+91-8859362732',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Email:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'excueetsimmediapvtltd@gmail.com',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Address:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  '355, PLOT NO 4, 3RD FLOOR, COMMUNITY CENTER, SEC-14, Rithala, North West Delhi, Delhi- 110085',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}