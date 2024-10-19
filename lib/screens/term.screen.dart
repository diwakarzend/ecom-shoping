import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/term.desktop.dart';
import 'package:fabpiks_web/screens/term.mobile.dart';
import 'package:fabpiks_web/screens/term.tab.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/cupertino.dart';

@RoutePage(name: 'TermRoute')
class TermConditionAll extends StatefulWidget {
  const TermConditionAll({super.key});

  @override
  State<TermConditionAll> createState() => _TermConditionAllState();
}

class _TermConditionAllState extends State<TermConditionAll> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: TermConditionMobile(),
      desktop: TermConditionDesktop(),
      tablet: TermConditionTab(),
    );
  }
}