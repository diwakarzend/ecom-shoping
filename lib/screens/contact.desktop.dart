import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactUsDesktop extends StatefulWidget {
  const ContactUsDesktop({super.key});

  @override
  State<ContactUsDesktop> createState() => _ContactUsDesktopState();
}

class _ContactUsDesktopState extends State<ContactUsDesktop> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        final String contactUsText = """
CONTACT US
Phone: +91- 7838717985
Email: agilepaymentservicesprivatelim@gmail.com

Address:
Unit No. 364, 3rd Floor, Aggarwal Plaza, Sec-14, Prashant
Vihar, North West Delhi, Delhi- 110085

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
                    'Contact Us',
                    style: TextStyle(
                        fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * .1, vertical: height * .08),
                  child: Text(
                    contactUsText,
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