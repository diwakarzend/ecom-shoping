import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';

class ProductTabPage extends StatefulWidget {
  const ProductTabPage({super.key});

  @override
  State<ProductTabPage> createState() => _ProductTabPageState();
}

class _ProductTabPageState extends State<ProductTabPage> {
  List<String> items = [
    'Shop Minis',
    'Deals & Combos',
    'Free Sample',
  ];

  List<String> subcate = [
    'All',
    'New',
    'Make Up',
    'Beauty',
  ];

  List<IconData> icons = [
    Icons.home,
    Icons.explore,
    Icons.search,
    Icons.feed,
    Icons.post_add,
    Icons.local_activity,
    Icons.settings,
    Icons.person,
  ];

  int current = 0;
  int currentsubcate = 0;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const TopAppBar(),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: width * .15, vertical: height * .02),
              height: 70,
              width: width,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(microseconds: 300),
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: width * .01),
                            padding: EdgeInsets.symmetric(horizontal: width * .03, vertical: height * .01),
                            width: width * .2,
                            height: height * .09,
                            decoration: BoxDecoration(
                              color: current == index ? const Color(0xff2e3f6c) : const Color(0xfff9e0e6),
                              borderRadius: current == index ? BorderRadius.circular(10) : BorderRadius.circular(10),
                              border: current == index ? Border.all(color: const Color(0xff2e3f6c)) : Border.all(color: const Color(0xfffea348)),
                            ),
                            child: Text(
                              items[index],
                              style: TextStyle(
                                fontSize: 25.0,
                                color: current == index ? Colors.white : Colors.black,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            (current == 0)
                ? Column(
                    children: [
                      Image.asset(
                        'assets/images/image1.png',
                        fit: BoxFit.contain,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: width * .15, vertical: height * .02),
                        height: 70,
                        width: width,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: subcate.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        currentsubcate = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(microseconds: 300),
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(horizontal: width * .04),
                                      padding: EdgeInsets.symmetric(horizontal: width * .01, vertical: height * .01),
                                      width: width * .10,
                                      // height: height * .05,
                                      decoration: BoxDecoration(
                                        color: currentsubcate == index ? const Color(0xff414042) : Colors.white,
                                        borderRadius: currentsubcate == index ? BorderRadius.circular(10) : BorderRadius.circular(10),
                                        // border: currentsubcate==index?Border.all(color: Color(0xff2e3f6c)): Border.all(color: Color(0xfffea348)),
                                      ),
                                      child: Text(
                                        subcate[index],
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: currentsubcate == index ? Colors.white : Colors.black,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * .15, vertical: height * .05),
                        child: GridView.count(
                          crossAxisCount: 5,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          childAspectRatio: 1 / 1.4,
                          children: [
                            for (int i = 1; i <= 25; i++)
                              Container(
                                width: width * .13,
                                padding: EdgeInsets.only(bottom: height * .01, left: width * .001),
                                // margin: EdgeInsets.symmetric(horizontal: width * .007,vertical: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xfff6f0ee),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // height: height * .25,
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
                                            fit: BoxFit.contain,
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
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
                                          Container(
                                            margin: EdgeInsets.only(right: width * .015),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                // Text('Worth Rs.199',style: TextStyle(
                                                //   fontSize: 13.0,color: Color(0xff414042),fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough,
                                                // ),),
                                                RichText(
                                                    text: const TextSpan(
                                                        text: 'Worth',
                                                        style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Color(0xff414042),
                                                          fontWeight: FontWeight.bold,
                                                          decoration: TextDecoration.lineThrough,
                                                        ),
                                                        children: [
                                                      TextSpan(text: 'Rs.199'),
                                                    ])),
                                                const Text(
                                                  'Rs.50',
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Color(0xff414042),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: height * .007),
                                            alignment: Alignment.center,
                                            width: width,
                                            margin: EdgeInsets.only(top: height * .01, bottom: height * .01, right: width * .01),
                                            decoration: BoxDecoration(
                                              color: const Color(0xff4b90f0),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: const Text(
                                              'Add To  Cart',
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/image1.png',
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: height * .03,
                      ),
                    ],
                  )
                : Container(
                    margin: EdgeInsets.symmetric(vertical: height * .02),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * .02,
                        ),
                        Image.asset(
                          'assets/images/image1.png',
                          fit: BoxFit.contain,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: width * .15, vertical: height * .02),
                          height: 70,
                          width: width,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: subcate.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentsubcate = index;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(microseconds: 300),
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.symmetric(horizontal: width * .04),
                                        padding: EdgeInsets.symmetric(horizontal: width * .01, vertical: height * .01),
                                        width: width * .10,
                                        // height: height * .05,
                                        decoration: BoxDecoration(
                                          color: currentsubcate == index ? const Color(0xff414042) : Colors.white,
                                          borderRadius: currentsubcate == index ? BorderRadius.circular(10) : BorderRadius.circular(10),
                                          // border: currentsubcate==index?Border.all(color: Color(0xff2e3f6c)): Border.all(color: Color(0xfffea348)),
                                        ),
                                        child: Text(
                                          subcate[index],
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            color: currentsubcate == index ? Colors.white : Colors.black,
                                            fontFamily: 'Montserrat',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: width * .15, vertical: height * .05),
                          child: GridView.count(
                            crossAxisCount: 5,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            childAspectRatio: 1 / 1.4,
                            children: [
                              for (int i = 1; i <= 25; i++)
                                Container(
                                  width: width * .13,
                                  padding: EdgeInsets.only(bottom: height * .01, left: width * .001),
                                  // margin: EdgeInsets.symmetric(horizontal: width * .007,vertical: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xfff6f0ee),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // height: height * .25,
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
                                              fit: BoxFit.contain,
                                            ),
                                            Container(
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
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
                                            Container(
                                              margin: EdgeInsets.only(right: width * .015),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  // Text('Worth Rs.199',style: TextStyle(
                                                  //   fontSize: 13.0,color: Color(0xff414042),fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough,
                                                  // ),),
                                                  RichText(
                                                      text: const TextSpan(
                                                          text: 'Worth',
                                                          style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: Color(0xff414042),
                                                            fontWeight: FontWeight.bold,
                                                            decoration: TextDecoration.lineThrough,
                                                          ),
                                                          children: [
                                                        TextSpan(text: 'Rs.199'),
                                                      ])),
                                                  const Text(
                                                    'Rs.50',
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Color(0xff414042),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(vertical: height * .007),
                                              alignment: Alignment.center,
                                              width: width,
                                              margin: EdgeInsets.only(top: height * .01, bottom: height * .01, right: width * .01),
                                              decoration: BoxDecoration(
                                                color: const Color(0xff4b90f0),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                'Add To  Cart',
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/image1.png',
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                      ],
                    ),
                  ),
            const BottomAppBarPage(),
          ],
        ),
      ),
    );
  }
}
