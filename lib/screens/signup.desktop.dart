import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/material.dart';

class SignupScreenDesktop extends StatefulWidget {
  const SignupScreenDesktop({super.key});

  @override
  State<SignupScreenDesktop> createState() => _SignupScreenDesktopState();
}

class _SignupScreenDesktopState extends State<SignupScreenDesktop> {
  int selectgender = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const TopAppBar(),
            Container(
              padding: EdgeInsets.only(top: height * .10, left: width * .11),
              width: width,
              height: height * .20,
              color: const Color(0xff030d4e),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: width * .09, top: height * .1, bottom: height * .08),
                child: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        text: 'First Name ',
                                        style: TextStyle(
                                          color: Color(0xff030d4e),
                                        ),
                                        children: [
                                          TextSpan(text: '*', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: height * .01),
                                      decoration: const BoxDecoration(
                                          // border: Border.all(width: width * .0005),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.black,
                                              width: 0.2,
                                            ),
                                            left: BorderSide(
                                              color: Colors.black,
                                              width: 0.6,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 0.6,
                                            ),
                                            top: BorderSide(
                                              color: Colors.black,
                                              width: 0.6,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          )),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(left: width * .01),
                                            border: InputBorder.none,
                                            hintStyle: const TextStyle(
                                              fontSize: 17.0,
                                            )),
                                      ),
                                    ),
                                  ],
                                )),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    RichText(
                                      text: const TextSpan(
                                        text: 'Last Name ',
                                        style: TextStyle(
                                          color: Color(0xff030d4e),
                                        ),
                                        children: [
                                          TextSpan(text: '*', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: height * .01),
                                      decoration: const BoxDecoration(
                                          // border: Border.all(),
                                          // border: Border.all(width: width * .0005),
                                          border: Border(
                                            right: BorderSide(
                                              color: Colors.black,
                                              width: 0.6,
                                            ),
                                            left: BorderSide(
                                              color: Colors.black,
                                              width: 0.2,
                                            ),
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 0.6,
                                            ),
                                            top: BorderSide(
                                              color: Colors.black,
                                              width: 0.6,
                                            ),
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          )),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(left: width * .01),
                                            border: InputBorder.none,
                                            hintStyle: const TextStyle(
                                              fontSize: 17.0,
                                            )),
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          text: 'Gender ',
                                          style: TextStyle(
                                            color: Color(0xff030d4e),
                                          ),
                                          children: [
                                            TextSpan(text: '*', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectgender = 1;
                                                });
                                              },
                                              child: Container(
                                                height: height * .07,
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.symmetric(vertical: height * .01),
                                                decoration: BoxDecoration(
                                                  color: selectgender == 1 ? const Color(0xff030d4e) : Colors.white,
                                                  // border: Border.fromBorderSide(),
                                                  // border: Border.all(width: width * .0005),
                                                  border: const Border(
                                                    right: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.2,
                                                    ),
                                                    left: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.6,
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.6,
                                                    ),
                                                    top: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.6,
                                                    ),
                                                  ),
                                                  borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    bottomLeft: Radius.circular(10),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Male',
                                                  style: TextStyle(
                                                    color: selectgender == 1 ? Colors.white : Colors.black,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  selectgender = 2;
                                                });
                                              },
                                              child: Container(
                                                height: height * .07,
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.symmetric(vertical: height * .01),
                                                decoration: BoxDecoration(
                                                  color: selectgender == 2 ? const Color(0xff030d4e) : Colors.white,
                                                  // border: Border.fromBorderSide(),
                                                  // border: Border.all(width: width * .0005),
                                                  border: const Border(
                                                    right: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.6,
                                                    ),
                                                    left: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.2,
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.6,
                                                    ),
                                                    top: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.6,
                                                    ),
                                                  ),
                                                  borderRadius: const BorderRadius.only(
                                                    topRight: Radius.circular(10),
                                                    bottomRight: Radius.circular(10),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Female',
                                                  style: TextStyle(
                                                    color: selectgender == 2 ? Colors.white : Colors.black,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: 'Age',
                                    style: TextStyle(
                                      color: Color(0xff030d4e),
                                    ),
                                    children: [
                                      TextSpan(text: '*', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(vertical: height * .01),
                                  decoration: BoxDecoration(
                                    // border: Border.fromBorderSide(),
                                    border: Border.all(width: width * .0005),
                                    // borderRadius: BorderRadius.only(
                                    //   topRight: Radius.circular(10),
                                    // ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: width * .01),
                                        border: InputBorder.none,
                                        hintText: '',
                                        hintStyle: const TextStyle(
                                          fontSize: 17.0,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: 'Phone Number',
                                    style: TextStyle(
                                      color: Color(0xff030d4e),
                                    ),
                                    children: [
                                      TextSpan(text: '*', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(vertical: height * .01),
                                  decoration: BoxDecoration(
                                    // border: Border.fromBorderSide(),
                                    border: Border.all(width: width * .0005),
                                    // borderRadius: BorderRadius.only(
                                    //   topRight: Radius.circular(10),
                                    // ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: width * .01),
                                        border: InputBorder.none,
                                        hintText: '',
                                        hintStyle: const TextStyle(
                                          fontSize: 17.0,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: 'Email',
                                    style: TextStyle(
                                      color: Color(0xff030d4e),
                                    ),
                                    children: [
                                      TextSpan(text: '*', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(vertical: height * .01),
                                  decoration: BoxDecoration(
                                    // border: Border.fromBorderSide(),
                                    border: Border.all(width: width * .0005),
                                    // borderRadius: BorderRadius.only(
                                    //   topRight: Radius.circular(10),
                                    // ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: width * .01),
                                        border: InputBorder.none,
                                        hintText: '',
                                        hintStyle: const TextStyle(
                                          fontSize: 17.0,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: 'Pincode',
                                    style: TextStyle(
                                      color: Color(0xff030d4e),
                                    ),
                                    children: [
                                      TextSpan(text: '*', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(vertical: height * .01),
                                  decoration: BoxDecoration(
                                    // border: Border.fromBorderSide(),
                                    border: Border.all(width: width * .0005),
                                    // borderRadius: BorderRadius.only(
                                    //   topRight: Radius.circular(10),
                                    // ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: width * .01),
                                        border: InputBorder.none,
                                        hintText: '',
                                        hintStyle: const TextStyle(
                                          fontSize: 17.0,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * .02,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: 'City',
                                    style: TextStyle(
                                      color: Color(0xff030d4e),
                                    ),
                                    children: [
                                      TextSpan(text: '*', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.symmetric(vertical: height * .01),
                                  decoration: BoxDecoration(
                                    // border: Border.fromBorderSide(),
                                    border: Border.all(width: width * .0005),
                                    // borderRadius: BorderRadius.only(
                                    //   topRight: Radius.circular(10),
                                    // ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: width * .01),
                                        border: InputBorder.none,
                                        hintText: '',
                                        hintStyle: const TextStyle(
                                          fontSize: 17.0,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * .04,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: width * .25,
                              height: height * .08,
                              decoration: BoxDecoration(
                                color: const Color(0xff030d4e),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )),
                    const Expanded(flex: 4, child: Text('')),
                  ],
                )),
            const BottomAppBarPage(),
          ],
        ),
      ),
    );
  }
}
