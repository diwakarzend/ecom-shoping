import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/add.address.desktop.dart';
import 'package:fabpiks_web/screens/add.address.mobile.dart';
import 'package:fabpiks_web/screens/add.address.tab.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'AddAddressRoute')
class AddAddress extends StatefulWidget {
  final bool fromCart;

  const AddAddress({
    super.key,
    required this.fromCart,
  });

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: AddAddressMobile(
        fromCart: widget.fromCart,
      ),
      desktop: AddAddressDesktop(fromCart: widget.fromCart),
      tablet: AddAddressTab(
        fromCart: widget.fromCart,
      ),
    );
  }
}
