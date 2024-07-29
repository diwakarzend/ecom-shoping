import 'package:auto_route/annotations.dart';
import 'package:fabpiks_web/screens/order.help.desktop.dart';
import 'package:fabpiks_web/screens/order.help.mobile.dart';
import 'package:fabpiks_web/screens/order.help.tab.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'OrderHelpRoute')
class OrderHelp extends StatefulWidget {
  const OrderHelp({super.key});

  @override
  State<OrderHelp> createState() => _OrderHelpState();
}

class _OrderHelpState extends State<OrderHelp> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: OrderHelpMobile(),
      desktop: OrderHelpDesktop(),
      tablet: OrderHelpTab(),
    );
  }
}
