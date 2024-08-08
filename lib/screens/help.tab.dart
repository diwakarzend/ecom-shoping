import 'package:auto_route/auto_route.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/text.helper.dart';
import 'package:fabpiks_web/helpers/url.helper.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpTab extends StatefulWidget {
  const HelpTab({super.key});

  @override
  State<HelpTab> createState() => _HelpTabState();
}

class _HelpTabState extends State<HelpTab> {
  late UrlHelper _urlHelper;

  @override
  void initState() {
    _urlHelper = UrlHelper.internal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Help Center',
            ),
            centerTitle: false,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * .03),
              Text(
                'Help Categories',
                style: TextHelper.titleStyle,
              ),
              SizedBox(height: height * .03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        context.router.push(const OrderHelpRoute());
                      },
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 7.5),
                                child: Image.asset('assets/images/shipping-cart.png'),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstants.colorBlueEight.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Order Related',
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.router.push(const ShoppingHelpRoute());
                      },
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 7.5),
                                child: Image.asset('assets/images/shopping-bag.png'),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstants.colorBlueEight.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Shopping',
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.router.push(const PaymentHelpRoute());
                      },
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 7.5),
                                child: Image.asset('assets/images/credit_card.png'),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstants.colorBlueEight.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Payments',
                            style: TextHelper.normalTextStyle.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * .03),
              InkWell(
                onTap: () => _urlHelper.launchNonUrl(url: 'mailto:meryanoenterisepvtltd@gmail.com'),
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                child: Container(
                  width: width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: width * .1),
                  decoration: const BoxDecoration(
                    color: ColorConstants.colorBlueEight,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Mail us at : meryanoenterisepvtltd@gmail.com',
                    style: TextHelper.subTitleStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: height * .02),
            ],
          ),
        );
      },
    );
  }
}
