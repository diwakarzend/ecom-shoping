
import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/screens/contact.desktop.dart';
import 'package:fabpiks_web/screens/contact.mobile.dart';
import 'package:fabpiks_web/screens/contact.tab.dart';
import 'package:fabpiks_web/style/responsive.dart';
import 'package:flutter/cupertino.dart';

  @RoutePage(name: 'ContactRoute')
class ContactUsAll extends StatefulWidget {
  const ContactUsAll({super.key});

  @override
  State<ContactUsAll> createState() => _ContactUsAllState();
}

class _ContactUsAllState extends State<ContactUsAll> {
  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: ContactUsMobile(),
      desktop:ContactUsDesktop (),
      tablet: ContactUsTab(),
    );
  }
}