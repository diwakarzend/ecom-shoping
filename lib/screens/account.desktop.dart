import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:fabpiks_web/widgets/order.card.desktop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const TopAppBar(),
              Container(
                padding: EdgeInsets.only(top: height * .13, left: width * .12, right: width * .12),
                width: width,
                height: height * .25,
                color: const Color(0xff030d4e),
                child: const Text(
                  'Account',
                  style: TextStyle(fontSize: 35.0, color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .12, vertical: height * .02),
                child: const Text(
                  'Order history',
                  style: TextStyle(
                    fontFamily: 'MMontserrat',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff030d4e),
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              if (provider.currentUser == null || provider.currentUser != null && provider.currentUser!.orders.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .12, vertical: height * .02),
                  child: const Text(
                    "You haven't placed any orders yet.",
                    style: TextStyle(
                      fontFamily: 'MMontserrat',
                      fontSize: 20.0,
                      color: Color(0xff030d4e),
                    ),
                  ),
                )
              else if (provider.currentUser != null)
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  childAspectRatio: 16 / 10,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  padding: EdgeInsets.symmetric(horizontal: width * .12),
                  children: provider.currentUser!.orders
                      .map(
                        (e) => OrderCardDesktop(order: e),
                      )
                      .toList(),
                ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: width * .12, vertical: height * .07),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: height * .04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Text(
                                'Account details',
                                style: TextStyle(
                                  fontFamily: 'MMontserrat',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff030d4e),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: height * .02),
                                child: Text(
                                  '${provider.currentUser?.firstName ?? ''}  ${provider.currentUser?.lastName ?? ''}',
                                  style: const TextStyle(
                                    fontFamily: 'MMontserrat',
                                    fontSize: 19.0,
                                    color: Color(0xff030d4e),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: height * .01),
                                child: const Text(
                                  'India',
                                  style: TextStyle(
                                    fontFamily: 'MMontserrat',
                                    fontSize: 19.0,
                                    color: Color(0xff030d4e),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: height * .04),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Text(
                                'Addresses',
                                style: TextStyle(
                                  fontFamily: 'MMontserrat',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff030d4e),
                                ),
                              ),
                              if (provider.currentUser != null && provider.currentUser!.shipping.isNotEmpty)
                                ...provider.currentUser!.shipping.take(1).map(
                                      (e) => Container(
                                        width: width * .2,
                                        margin: EdgeInsets.symmetric(
                                          vertical: height * .02,
                                        ),
                                        child: Text(
                                          // '306A & 306 suncity success tower, gurgoan, haryana 122018',
                                          '${e.shippingAddress}, ${e.shippingCity}, ${e.shippingState} ${e.shippingPincode}',
                                          style: const TextStyle(
                                            fontFamily: 'MMontserrat',
                                            fontSize: 18.0,
                                            color: Color(0xff030d4e),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (provider.currentUser != null) {
                              provider.changeLoginStatus(false, null, '', '', '');
                              context.router.popUntilRouteWithName(HomeRoute.name);
                            } else {
                              context.router.navigate(HomeRoute());
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(
                                Icons.person_outline,
                                color: Colors.black,
                              ),
                              Text(
                                'Log Out',
                                style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const BottomAppBarPage(),
            ],
          ),
        ),
      );
    });
  }
}
