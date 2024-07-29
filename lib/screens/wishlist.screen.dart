import 'package:auto_route/annotations.dart';
import 'package:fabpiks_web/screens/screens.dart';
import 'package:fabpiks_web/screens/wishlist.desktop.dart';
import 'package:fabpiks_web/screens/wishlist.tab.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/cupertino.dart';

@RoutePage(name: 'WishlistRoute')
class WishlistScreenAll extends StatefulWidget {
  const WishlistScreenAll({super.key});

  @override
  State<WishlistScreenAll> createState() => _WishlistScreenAllState();
}

class _WishlistScreenAllState extends State<WishlistScreenAll> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: WishlistScreen(),
      desktop: WishlistScreenDesktop(),
      tablet: WishlistScreenTab(),
    );
  }
}
