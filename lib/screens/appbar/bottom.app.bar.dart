import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/screens/contact.screen.dart';
import 'package:fabpiks_web/screens/shipping.screen.dart';
import 'package:fabpiks_web/screens/term.screen.dart';
import 'package:flutter/material.dart';

import '../../routes/router.gr.dart';

class BottomAppBarPage extends StatefulWidget {
  const BottomAppBarPage({super.key});

  @override
  State<BottomAppBarPage> createState() => _BottomAppBarPageState();
}

class _BottomAppBarPageState extends State<BottomAppBarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: width * .10, top: 40, right: width * .10, bottom: 40),
          color: const Color(0xff000357),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/app_logo1.png',
                      width: width * .12,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Agile is an online sampling community of everyday people who try products & experiences from leading brands for free! In return for the offers you receive from',
                      maxLines: 100,
                      textAlign: TextAlign.justify,
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * .1,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                      child: Text(
                        'FAQ’s',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                      onTap: () {
                        context.router.navigate(const FAQHelpRoute());
                      },
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const RefundPolicyRoute());
                      },
                      child: Text(
                        'Refund Policy',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const PrivacyPolicyRoute());
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const HelpRoute());
                      },
                      child: Text(
                        'Need help?',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.navigate(const ProfileRoute());
                      },
                      child: Text(
                        'Profile',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShippingPolicyAll()),
                        );
                      },
                      child: Text(
                        'Shipping Policy',
                        style: TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermConditionAll()),
                        );
                      },
                      child: Text(
                        'Terms & Conditions',
                        style: TextHelper.smallTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .03,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactUsAll()),
                        );
                      },
                      child: Text(
                        'Contact Us',
                        style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
