import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/payment/payment.success.desktop.dart';
import 'package:fabpiks_web/screens/payment/payment.success.mobile.dart';
import 'package:fabpiks_web/screens/payment/payment.success.tab.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'PaymentSuccess')
class PaymentSuccess extends StatelessWidget {
  final String paymentID;

  const PaymentSuccess({
    super.key,
    @PathParam('id') required this.paymentID,
  });

  @override
  Widget build(BuildContext context) {
    return  Responsive(
      mobile: PaymentSuccessMobile(paymentId: paymentID),
      desktop: PaymentSuccessDesktop(paymentId: paymentID),
      tablet: PaymentSuccessTab(paymentId: paymentID),
    );
  }
}
