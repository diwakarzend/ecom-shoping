import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';

class ProductInfoPage extends StatefulWidget {
  const ProductInfoPage({super.key});

  @override
  State<ProductInfoPage> createState() => _ProductInfoPageState();
}

class _ProductInfoPageState extends State<ProductInfoPage> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const TopAppBar(),
            // Container(
            //     alignment: Alignment.centerRight,
            //     width: width,
            //     height: height * .13,
            //     color: const Color(0xfffda949),
            //     child: Row(
            //       children: [
            //         const Expanded(flex: 6, child: Text('')),
            //         Expanded(
            //           flex: 1,
            //           child: Image.asset(
            //             'assets/images/app-store.png',
            //             scale: 1,
            //           ),
            //         ),
            //         SizedBox(
            //           width: width * .01,
            //         ),
            //         Expanded(
            //           flex: 1,
            //           child: Image.asset(
            //             'assets/images/playstore.png',
            //             width: width * .03,
            //           ),
            //         ),
            //         SizedBox(
            //           width: width * .03,
            //         ),
            //       ],
            //     )),
            // Container(
            //   height: height * .15,
            //   color: const Color(0xffe5e6e6),
            //   child: Row(
            //     children: [
            //       Expanded(
            //           flex: 2,
            //           child: Image.asset(
            //             'assets/images/logo.png',
            //             scale: 1,
            //           )),
            //       const Expanded(flex: 4, child: Text('')),
            //       Expanded(
            //           flex: 3,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceAround,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisSize: MainAxisSize.max,
            //             children: [
            //               const Expanded(
            //                   child: Text(
            //                 'Sign up',
            //                 style: TextStyle(
            //                   fontSize: 18.0,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               )),
            //               const Expanded(
            //                   child: Text(
            //                 'Sign in',
            //                 style: TextStyle(
            //                   fontSize: 18.0,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               )),
            //               Expanded(child: Image.asset('assets/images/bell.png')),
            //               Expanded(child: Image.asset('assets/images/shopping.png')),
            //               const Expanded(child: Text('')),
            //             ],
            //           )),
            //     ],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * .14, vertical: height * .03),
              width: width,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: TabBar(
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.white,
                          controller: tabController,
                          labelStyle: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black),
                          indicator: BoxDecoration(
                            color: const Color(0xff2e3f6c),
                            border: Border.all(color: const Color(0xffdcaf87)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          tabs: const [
                            Tab(
                              text: 'Shop Minis',
                            ),
                            Tab(
                              text: 'Deals & Combos',
                            ),
                            Tab(
                              text: 'Free Samples',
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: height * .02),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: width * .14, vertical: height * .03),
              width: width,
              child: const Text(
                'Beauty',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * .14, vertical: height * .03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height * .6,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset('assets/images/veg.png'),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: height * .02),
                        child: Row(
                          children: [
                            for (int i = 1; i <= 3; i++)
                              Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(4),
                                height: height * .13,
                                width: width * .06,
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Image.asset('assets/images/veg.png'),
                              ),
                          ],
                        ),
                      )
                    ],
                  )),
                  SizedBox(
                    width: width * .02,
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: height * .03,
                            ),
                            child: const Text(
                              'Product Name And Brand Name Product Name And Brand Name',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: height * .02),
                            child: const Text(
                              'MRP Rs 600',
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: height * .04),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: height * .02, horizontal: width * .01),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xffec881d),
                                            size: 35,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xffec881d),
                                            size: 35,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xffec881d),
                                            size: 35,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xffec881d),
                                            size: 35,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xffec881d),
                                            size: 35,
                                          ),
                                          SizedBox(
                                            width: width * .03,
                                          ),
                                          const Text(
                                            '4.4',
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                const Expanded(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.thumb_up_alt_outlined,
                                          color: Colors.black,
                                          size: 50,
                                        ),
                                        Text(
                                          '500',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: height * .03),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Secure Payments',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * .07,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/upi.png',
                                            width: width * .03,
                                          ),
                                          Image.asset(
                                            'assets/images/master.png',
                                            width: width * .014,
                                          ),
                                          Image.asset(
                                            'assets/images/visa.png',
                                            width: width * .03,
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                                  VerticalDivider(
                                    color: Colors.grey[400],
                                    thickness: 2,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Trusted Delivery \n(3-5 Days)',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/shiprocket.png',
                                            width: width * .07,
                                          ),
                                          Image.asset(
                                            'assets/images/pickrr.png',
                                            width: width * .06,
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                                  const Expanded(child: Text('')),
                                ],
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(horizontal: width * .15, vertical: height * .05),
              color: const Color(0xfff6f0ee),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: width * .2),
                    width: width,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: TabBar(
                              unselectedLabelColor: Colors.black,
                              labelColor: Colors.black,
                              controller: tabController,
                              labelStyle: const TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              indicator: const BoxDecoration(
                                  // border: Border.all(color: const Color(0xffdcaf87)),
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              )),
                              tabs: const [
                                Tab(
                                  text: 'Description',
                                ),
                                Tab(
                                  text: 'How to use',
                                ),
                                Tab(
                                  text: 'Ingredients',
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: width * .15, top: height * .05, bottom: height * .03, right: width * .15),
              child: const Row(
                children: [
                  Expanded(
                      flex: 10,
                      child: Text(
                        'More from this brand',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Text(
                            'View All ',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * .14, vertical: height * .06),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 1; i <= 7; i++)
                      Container(
                        width: width * .13,
                        padding: EdgeInsets.only(bottom: height * .01, left: width * .001),
                        margin: EdgeInsets.symmetric(horizontal: width * .007),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xffdae789),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: height * .25,
                              margin: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/product.png',
                                  ),
                                  Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(left: 1, right: 1),
                                      margin: EdgeInsets.only(right: width * .01, bottom: height * .01, left: width * .07),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: const Text(
                                        '150ml',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: width * .01),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Nivea',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const Text(
                                    'Acne Men Face Wash',
                                    style: TextStyle(
                                      color: Color(0xff8b916d),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const Text(
                                    'Worth Rs.199',
                                    style: TextStyle(
                                      color: Color(0xff414042),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: width * .003, vertical: height * .02),
                                        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(30)),
                                        child: const Text(
                                          'Rating 4.4',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Container(
                                          padding: EdgeInsets.symmetric(horizontal: width * .015, vertical: height * .01),
                                          margin: EdgeInsets.only(right: width * .01),
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: const Text(
                                            'Try +',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),

            //footer here start
            Container(
              padding: const EdgeInsets.all(30),
              color: const Color(0xff30456b),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/footer_logo.png',
                        width: width * .1,
                      ),
                      SizedBox(
                        height: height * .02,
                      ),
                      const Text(
                        'FabPiks is an online sampling community of everyday people who try products & experiences from leading brands for free! In return for the offers you receive from brands, we ask that you share your opinion with our community and, if you liked the product, invite your friends, fans & followers to try it',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          letterSpacing: 1.0,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ],
                  )),
                  SizedBox(
                    width: width * .05,
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'FAQ’s',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          const Text(
                            'Refund Policy',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          const Text(
                            'Privacy Policy',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          const Text(
                            'Need help with any issue',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * .04,
                          ),
                          const Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                          const Text(
                            'Connect with us',
                            style: TextStyle(color: Colors.white, fontSize: 18.0, letterSpacing: 1),
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/face.png'),
                              SizedBox(
                                width: width * .02,
                              ),
                              Image.asset('assets/images/insta.png'),
                              SizedBox(
                                width: width * .02,
                              ),
                              Image.asset('assets/images/tweet.png'),
                              SizedBox(
                                width: width * .01,
                              ),
                              Image.asset('assets/images/youtube.png'),
                            ],
                          ),
                          SizedBox(
                            height: height * .23,
                          ),
                        ],
                      )),
                  SizedBox(
                    width: width * .1,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'For Brands & Agencies',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        const Text(
                          'FabPiks is an online sampling community of everyday people who try products & experiences from leading brands for free! In return for the offers you receive from',
                          style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: width * .02, vertical: height * .01),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Click here',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                            )),
                        SizedBox(
                          height: height * .12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
