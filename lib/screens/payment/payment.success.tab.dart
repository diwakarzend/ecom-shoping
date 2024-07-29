import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/text.helper.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:flutter/material.dart';

class PaymentSuccessTab extends StatefulWidget {
  final String paymentId;
  const PaymentSuccessTab({super.key, required this.paymentId});

  @override
  State<PaymentSuccessTab> createState() => _PaymentSuccessTabState();
}

class _PaymentSuccessTabState extends State<PaymentSuccessTab> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.colorOffWhite,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: height * .06),
          Align(
            child: Container(
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    width: width * .15,
                  ),
                  SizedBox(height: height * .03),
                  Text(
                    'Payment Successful',
                    style: TextHelper.subTitleStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.colorBlack,
                    ),
                  ),
                  SizedBox(height: height * .01),
                  Text(
                    'Order ID - ${widget.paymentId}',
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.colorBlueSeventeen,
                    ),
                  ),
                  SizedBox(height: height * .03),
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s',
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextHelper.smallTextStyle.copyWith(
                      color: ColorConstants.colorBlack.withOpacity(0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: height * .04),
                  InkWell(
                    onTap: () => context.router.push(NavigatorRoute()),
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
                        style: TextHelper.normalTextStyle.copyWith(
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
        ],
      ),
    );
  }
}
