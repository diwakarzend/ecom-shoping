import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/payment/payment.faield.desktop.dart';
import 'package:fabpiks_web/screens/payment/payment.faield.mobile.dart';
import 'package:fabpiks_web/screens/payment/payment.faield.tab.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'PaymentFailed')
class PaymentFailed extends StatelessWidget {
  final String paymentID;

  const PaymentFailed({
    super.key,
    @PathParam('id') required this.paymentID,
  });

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: PaymentFailedMobile(paymentId: paymentID),
      desktop: PaymentFailedDesktop(paymentId: paymentID),
      tablet: PaymentFailedTab(paymentId: paymentID),
    );
  }
}
