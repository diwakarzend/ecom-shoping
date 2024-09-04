import 'package:fabpiks_web/screens/shipping.desktop.dart';
import 'package:fabpiks_web/screens/shipping.mobile.dart';
import 'package:fabpiks_web/screens/shipping.tab.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/cupertino.dart';

// @RoutePage(name: 'WishlistRoute')
class ShippingPolicyAll extends StatefulWidget {
  const ShippingPolicyAll({super.key});

  @override
  State<ShippingPolicyAll> createState() => _ShippingPolicyAllState();
}

class _ShippingPolicyAllState extends State<ShippingPolicyAll> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: ShippingPolicyMobile(),
      desktop: ShippingPolicyDesktop(),
      tablet: ShippingPolicyTab(),
    );
  }
}