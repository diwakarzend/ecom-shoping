import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
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
  late UrlHelper _urlHelper;

  @override
  void initState() {
    _urlHelper = UrlHelper.internal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: width * .10, vertical: 40),
          color: Color(0xffF9F9F9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      context.router.navigate(HomeRoute());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/app_logo.png',
                        width: width * .10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      context.router.navigate(const RefundPolicyRoute());
                    },
                    child: Text(
                      'Refund Policy',
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.router.navigate(const PrivacyPolicyRoute());
                    },
                    child: Text(
                      'Privacy Policy',
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
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
                        color: Colors.black,
                      ),
                    ),
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
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.router.navigate(const HelpRoute());
                    },
                    child: Text(
                      'Need help?',
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}
