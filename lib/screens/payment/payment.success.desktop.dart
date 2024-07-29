import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';

class PaymentSuccessDesktop extends StatefulWidget {
  final String paymentId;

  const PaymentSuccessDesktop({super.key, required this.paymentId});

  @override
  State<PaymentSuccessDesktop> createState() => _PaymentSuccessDesktopState();
}

class _PaymentSuccessDesktopState extends State<PaymentSuccessDesktop> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.colorOffWhite,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopAppBar(),
            SizedBox(height: height * .06),
            Align(
              child: Container(
                width: width * .3,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/tick.png',
                      width: width * .05,
                    ),
                    SizedBox(height: height * .03),
                    Text(
                      'Payment Successful',
                      style: TextHelper.smallTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.colorBlack,
                      ),
                    ),
                    SizedBox(height: height * .01),
                    Text(
                      'Order ID - ${widget.paymentId}',
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.colorBlueSeventeen,
                      ),
                    ),
                    SizedBox(height: height * .03),
                    Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
                      maxLines: 5,
                      textAlign: TextAlign.center,
                      style: TextHelper.extraSmallTextStyle.copyWith(
                        color: ColorConstants.colorBlack.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: height * .04),
                    InkWell(
                      onTap: () => context.router.push(HomeRoute()),
                      child: Container(
                        width: double.infinity,
                        height: height * .045,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                          color: ColorConstants.colorBlueSeventeen,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Back To Home',
                          style: TextHelper.extraSmallTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * .03),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * .06),
            const BottomAppBarPage(),
          ],
        ),
      ),
    );
  }
}
