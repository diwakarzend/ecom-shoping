import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/dio.helper.dart';
import 'package:fabpiks_web/helpers/text.helper.dart';
import 'package:fabpiks_web/models/user.dart';
import 'package:fabpiks_web/providers/app.provider.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class LoginScreenTab extends StatefulWidget {
  final Function(bool success)? onResult;

  const LoginScreenTab({
    super.key,
    this.onResult,
  });

  @override
  State<LoginScreenTab> createState() => _LoginScreenTabState();
}

class _LoginScreenTabState extends State<LoginScreenTab> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  String? _phoneValidation;
  bool? mobileValidated;

  final DioHelper _dioHelper = DioHelper();

  checkMobileExists(String? value, AppProvider provider, bool fromSignup) async {
    if (value != null) {
      log('checking three');
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
      log((widget.onResult == null).toString());
      if (widget.onResult == null) {
        context.router.replace(NavigatorRoute(orderSuccess: false));
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Consumer<AppProvider>(
      builder: (context, provider, _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: ColorConstants.colorBlueSeventeen,
            appBar: AppBar(
              backgroundColor: ColorConstants.colorBlueSeventeen,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.router.maybePop(),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * .02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign In',
                      style: TextHelper.smallTextStyle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  if (!otpSent)
                    Column(
                      children: [
                        SizedBox(height: height * .03),
                        TextFormField(
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
                          style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Enter Mobile Number',
                            labelText: 'Mobile Number',
                            counterText: '',
                            hintStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white.withOpacity(0.6)),
                            labelStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white),
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
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        if (_phoneValidation != null && phoneController.text.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
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
                        SizedBox(height: height * .03),
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
                          child: Container(
                            width: width,
                            height: height * .06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(height * .06),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Send OTP tab',
                              style: TextHelper.subTitleStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.colorBlackTwo,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * .03),
                        Text(
                          'For additional security, we’ve sent an OTP to your registered Mobile Number',
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style: TextHelper.normalTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: height * .03),
                      ],
                    )
                  else
                    Column(
                      children: [
                        SizedBox(height: height * .03),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Pinput(
                            controller: otpController,
                            length: 6,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            defaultPinTheme: PinTheme(
                              width: width * .15,
                              height: width * .12,
                              textStyle: TextHelper.normalTextStyle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * .03),
                        Text(
                          '00:${_start > 9 ? _start : '0$_start'} ',
                          style: TextHelper.subTitleStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: height * .02),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Didn’t receive the code?',
                              style: TextHelper.normalTextStyle.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: _start < 1
                                  ? () {
                                      sendOtp(phoneController.text, true);
                                      if (mounted) {
                                        setState(() {
                                          otpSent = true;
                                        });
                                      }
                                    }
                                  : null,
                              child: Text(
                                'Resend now',
                                style: TextHelper.normalTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: _start < 1 ? ColorConstants.colorLogin : ColorConstants.colorLogin.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * .03),
                        InkWell(
                          onTap: () {
                            if (mobileValidated != null && otpController.text.isNotEmpty) {
                              login(phoneController.text, otpController.text, provider);
                            } else {
                              ScaffoldSnackBar.of(context).show('All fields are required');
                            }
                          },
                          child: Container(
                            width: width,
                            height: height * .06,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(height * .06),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Submit',
                              style: TextHelper.subTitleStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.colorBlackTwo,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: height * .02),
                  Text(
                    'For New User Click on "Sign Up"',
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    style: TextHelper.normalTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * .01),
                  InkWell(
                    onTap: () => context.router.push(SignupRoute(referCode: '')),
                    child: Container(
                      height: height * .055,
                      width: width * .45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(height * .06),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Sign Up',
                        style: TextHelper.subTitleStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorConstants.colorBlueSeventeen,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
