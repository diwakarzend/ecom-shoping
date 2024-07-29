/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:fabpiks_web/screens/appbar/bottom.app.bar.dart';
import 'package:fabpiks_web/screens/appbar/top.app.bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginPageDeskTop extends StatefulWidget {
  final Function(bool success)? onResult;

  const LoginPageDeskTop({super.key, this.onResult});

  @override
  State<LoginPageDeskTop> createState() => _LoginPageDeskTopState();
}

class _LoginPageDeskTopState extends State<LoginPageDeskTop> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  String? _phoneValidation;
  bool? mobileValidated;

  final DioHelper _dioHelper = DioHelper();

  checkMobileExists(String? value, AppProvider provider, bool fromSignup) async {
    if (value != null) {
      final response = await _dioHelper.post(
        'check-mobile',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'mobile_no': int.parse(value),
        },
      );
      if (fromSignup) {
        if (response != null && response.data['status']) {
          mobileValidated = true;
          _phoneValidation = null;
        } else {
          mobileValidated = false;
          _phoneValidation = response?.data['validation']['mobile_no'][0];
        }
      } else {
        if (response != null && response.data['status']) {
          mobileValidated = false;
          _phoneValidation = 'User not found';
        } else {
          mobileValidated = true;
          _phoneValidation = null;
        }
      }
      if (mounted) setState(() {});
    } else {
      mobileValidated = null;
      if (mounted) setState(() {});
    }
  }

  validateMobile(String? value, AppProvider provider, bool fromSignup) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
      setState(() {
        _phoneValidation = 'Please enter valid mobile number';
        mobileValidated = false;
      });
    } else {
      checkMobileExists(value, provider, fromSignup);
      setState(() {
        _phoneValidation = null;
        mobileValidated = null;
      });
    }
  }

  sendOtp(String phone, bool login) async {
    await _dioHelper.post(
      'otp',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'mobile_no': int.parse(phone),
      },
    );
    if (mounted) ScaffoldSnackBar.of(context).show('OTP Sent');
    _start = 30;
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start == 0) {
          _timer?.cancel();
        } else {
          _start--;
        }
        if (mounted) setState(() {});
      },
    );
  }

  Timer? _timer;

  int _start = 30;

  bool otpSent = false;

  Future<void> login(String mobile, String otp, AppProvider provider) async {
    if (!mounted) return;
    ScaffoldLoaderDialog.of(context).show();
    final Response? response = await _dioHelper.post(
      'new-login-with-phone',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'mobile_no': int.parse(mobile),
        'otp': int.parse(otp),
        'device_type': 'web',
        'app_version': '',
        'device_id': '',
      },
    );

    if (response != null && response.data['status']) {
      User temp = User.fromJson(response.data['user']);
      provider.changeLoginStatus(true, temp, response.data['authorisation']['token'], temp.id, temp.role);
      if (!mounted) return;
      ScaffoldLoaderDialog.of(context).hide();
      if (widget.onResult == null) {
        context.router.replace(HomeRoute());
      } else {
        widget.onResult!(true);
      }
    } else {
      if (!mounted) return;
      ScaffoldLoaderDialog.of(context).hide();
      if (!mounted) return;
      ScaffoldSnackBar.of(context).show('Invalid otp');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopAppBar(),
                Container(
                  padding: EdgeInsets.only(top: height * .23, left: width * .13),
                  width: width,
                  height: height * .35,
                  color: ColorConstants.colorBlueTwelve,
                  child: Text(
                    'Sign In ',
                    style: TextHelper.titleStyle.copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(height: height * .04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .13),
                  child: TextFormField(
                    controller: phoneController,
                    onChanged: (_) => validateMobile(_, provider, false),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    cursorColor: ColorConstants.colorBlueTen,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      //To remove first '0'
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                    ],
                    style: TextHelper.smallTextStyle,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      constraints: BoxConstraints(maxWidth: width * .3),
                      hintText: 'Enter Mobile Number',
                      labelText: 'Mobile Number',
                      counterText: '',
                      hintStyle: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorBlack.withOpacity(0.5)),
                      labelStyle: TextHelper.smallTextStyle,
                      suffix: (mobileValidated == null)
                          ? const SizedBox.shrink()
                          : (mobileValidated != null && mobileValidated!)
                              ? const Icon(
                                  Icons.check_circle_outline_rounded,
                                  color: ColorConstants.colorGreenFour,
                                )
                              : const Icon(
                                  Icons.error_outline_rounded,
                                  color: ColorConstants.colorRed,
                                ),
                    ),
                  ),
                ),
                if (_phoneValidation != null && phoneController.text.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 5, left: width * .13),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _phoneValidation ?? '',
                        style: TextHelper.smallTextStyle.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                InkWell(
                  onTap: () {
                    if (mobileValidated != null && mobileValidated!) {
                      sendOtp(phoneController.text, true);
                      if (mounted) {
                        setState(() {
                          otpSent = true;
                        });
                      }
                    } else {
                      ScaffoldSnackBar.of(context).show('Please enter a valid mobile number');
                    }
                  },
                  splashFactory: NoSplash.splashFactory,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    height: height * .045,
                    width: width * .3,
                    margin: EdgeInsets.only(top: height * .03, bottom: height * .02, left: width * .13),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorConstants.colorBlueTwelve,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Send OTP',
                      style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                Visibility(
                  visible: otpSent,
                  child: Container(
                    margin: EdgeInsets.only(left: width * .13, top: height * .01, bottom: height * .01),
                    width: width * .3,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          'For additional security, we’ve sent an OTP to your registered Mobile Number',
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style: TextHelper.smallTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: ColorConstants.colorBlueTwelve,
                          ),
                        ),
                        SizedBox(height: height * .02),
                        Pinput(
                          controller: otpController,
                          length: 6,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          defaultPinTheme: PinTheme(
                            // width: 40,
                            height: height * .08,
                            textStyle: TextHelper.normalTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorConstants.colorBlack),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: height * .02),
                        Text(
                          '00:$_start',
                          style: TextHelper.smallTextStyle,
                        ),
                        CupertinoButton(
                          onPressed: _start < 1
                              ? () {
                                  sendOtp(phoneController.text, true);
                                  if (mounted) {
                                    setState(() {
                                      otpSent = true;
                                    });
                                  }
                                }
                              : null,
                          padding: EdgeInsets.zero,
                          child: RichText(
                            text: const TextSpan(
                              text: 'Didn’t receive the code? ',
                              style: TextStyle(
                                color: ColorConstants.colorBlueTwelve,
                                fontSize: 14.0,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Resend now',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (mobileValidated != null && otpController.text.isNotEmpty) {
                              login(phoneController.text, otpController.text, provider);
                            } else {
                              ScaffoldSnackBar.of(context).show('All fields are required');
                            }
                          },
                          splashFactory: NoSplash.splashFactory,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: height * .045,
                            width: width * .3,
                            margin: EdgeInsets.only(
                              top: height * .02,
                              bottom: height * .05,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: ColorConstants.colorBlueTwelve,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'Submit',
                              style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const BottomAppBarPage(),
              ],
            ),
          ),
        );
      },
    );
  }
}
