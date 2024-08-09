/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'dart:async';
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../routes/router.gr.dart';

class SignupScreenTab extends StatefulWidget {
  final String? referCode;

  const SignupScreenTab({super.key, this.referCode});

  @override
  State<SignupScreenTab> createState() => _SignupScreenTabState();
}

class _SignupScreenTabState extends State<SignupScreenTab> {
  bool loading = true, otpSent = false;
  bool? married, haveKids;
  final GlobalKey<FormState> _registerForm = GlobalKey<FormState>();
  List<String> selectedInterests = [];
  List<String> selectedInterestsTwo = [];
  String? _phoneValidation, _emailValidation;
  bool? mobileValidated, emailValidated;
  int? numberOfKids;

  final DioHelper _dioHelper = DioHelper();

  PageController controller = PageController();

  int activePage = 0;

  Timer? _timer;

  int _start = 30;

  TextEditingController firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      mobileController = TextEditingController(),
      emailController = TextEditingController(),
      referController = TextEditingController(),
      cityController = TextEditingController(),
      pinController = TextEditingController(),
      stateController = TextEditingController(),
      otpController = TextEditingController(),
      ageController = TextEditingController();

  // String? gender, firstKidGender, secondKidGender, thirdKidGender, age, firstKidAge, secondKidAge, thirdKidAge;
  String? gender, firstKidGender, secondKidGender, thirdKidGender, firstKidAge, secondKidAge, thirdKidAge;

  Future<void> register(AppProvider provider) async {
    ScaffoldLoaderDialog.of(context).show();
    final Response? response = await _dioHelper.post(
      'new-register',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'mobile_no': int.parse(mobileController.text),
        'gender': gender,
        'married': married != null && married!
            ? 'yes'
            : married != null && !married!
                ? 'no'
                : null,
        'have_kids': haveKids != null && haveKids!
            ? 'yes'
            : haveKids != null && !haveKids!
                ? 'no'
                : null,
        'number_of_kids': numberOfKids,
        'first_kid_age': firstKidAge,
        'first_kid_gender': firstKidGender,
        'second_kid_age': firstKidAge,
        'second_kid_gender': firstKidGender,
        'third_kid_age': firstKidAge,
        'third_kid_gender': firstKidGender,
        'age': ageController.text,
        'city': cityController.text,
        'state': stateController.text,
        'pincode': pinController.text,
        'interests': selectedInterests,
        'interests_one': selectedInterests,
        'refer_code': referController.text.isNotEmpty ? referController.text : null,
        'player_id': '',
        'source': 'web',
      },
    );
    if (response != null && response.data != null && response.data['status']) {
      if (!mounted) return;
      ScaffoldLoaderDialog.of(context).hide();
      otpSent = true;
      if (mounted) setState(() {});
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
    } else {
      if (!mounted) return;
      ScaffoldLoaderDialog.of(context).hide();
      if (response != null && response.data['code'] == 400) {
        final data = response.data['validation'] as Map<String, dynamic>;
        if (data.containsKey('email')) {
          if (!mounted) return;
          ScaffoldSnackBar.of(context).show(data['email'][0]);
        } else if (data.containsKey('mobile_no')) {
          if (!mounted) return;
          ScaffoldSnackBar.of(context).show(data['mobile_no'][0]);
        }
      }
    }
  }

  Future<void> initDynamicLinks() async {
    if (widget.referCode != null) {
      referController.text = widget.referCode!;
    }
  }

  validateMobile(String? value, AppProvider provider) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
      setState(() {
        _phoneValidation = 'Please enter valid mobile number';
        mobileValidated = false;
      });
    } else {
      checkMobileExists(value, provider);
      setState(() {
        _phoneValidation = null;
        mobileValidated = null;
      });
    }
  }

  validateEmail(String? value, AppProvider provider) {
    String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r'{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]'
        r'{0,253}[a-zA-Z0-9])?)*$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      setState(() {
        _emailValidation = 'Enter a valid email address';
      });
    } else {
      checkEmailExists(value, provider);
      setState(() {
        _emailValidation = null;
      });
    }
  }

  checkMobileExists(String? value, AppProvider provider) async {
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
      if (response != null && response.data['status']) {
        mobileValidated = true;
        _phoneValidation = null;
      } else {
        mobileValidated = false;
        _phoneValidation = response?.data['validation']['mobile_no'][0];
      }
      if (mounted) setState(() {});
    } else {
      mobileValidated = null;
      if (mounted) setState(() {});
    }
  }

  checkEmailExists(String? value, AppProvider provider) async {
    if (value != null) {
      final response = await _dioHelper.post(
        'check-email',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'email': value,
        },
      );
      if (response != null && response.data['status']) {
        emailValidated = true;
        _emailValidation = null;
      } else {
        emailValidated = false;
        _emailValidation = response?.data['validation']['email'][0];
      }
      if (mounted) setState(() {});
    } else {
      emailValidated = null;
      if (mounted) setState(() {});
    }
  }

  fetchPincode(AppProvider provider, String pincode) async {
    try {
      final response = await _dioHelper.dio.get(
        '${StringConstants.pincodeApi}$pincode',
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );
      final data = response.data[0] as Map<String, dynamic>;
      if (data['Status'] == 'Success' && data['PostOffice'].isNotEmpty) {
        PostOffice temp = PostOffice.fromJson(data['PostOffice'][0]);
        cityController.text = temp.division;
        stateController.text = temp.state;
        if (mounted) setState(() {});
      } else {
        if (!mounted) return;
        ScaffoldSnackBar.of(context).show('Invalid pincode');
      }
    } on DioException catch (_, e) {
      log(e.toString());
    }
  }

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
      context.router.replace(NavigatorRoute(orderSuccess: false));
    } else {
      if (!mounted) return;
      ScaffoldLoaderDialog.of(context).hide();
      if (!mounted) return;
      ScaffoldSnackBar.of(context).show('Invalid otp');
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

  @override
  void initState() {
    initDynamicLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
            body: Form(
              key: _registerForm,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: otpSent
                    ? Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height * .2),
                          Align(
                            child: Text(
                              'OTP',
                              style: TextHelper.subTitleStyle.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: height * .03),
                          Align(
                            child: Pinput(
                              controller: otpController,
                              length: 6,
                              defaultPinTheme: PinTheme(
                                constraints: BoxConstraints(
                                  minHeight: height * .05,
                                  minWidth: height * .05,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * .03),
                          Align(
                            child: InkWell(
                              onTap: () {
                                if (mobileValidated != null &&
                                    emailValidated != null &&
                                    otpController.text.isNotEmpty) {
                                  login(mobileController.text, otpController.text, provider);
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
                          ),
                          SizedBox(height: height * .02),
                          Align(
                            child: InkWell(
                              onTap: () {
                                if (_start < 1) {
                                  sendOtp(mobileController.text, false);
                                }
                              },
                              child: Text.rich(
                                TextSpan(
                                  text: 'Didn\'t receive OTP? ',
                                  children: [
                                    TextSpan(
                                      text: '00:${_start > 9 ? _start : '0$_start'} ',
                                      style: TextHelper.smallTextStyle
                                          .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: 'Resend OTP',
                                      style: TextHelper.smallTextStyle.copyWith(
                                        color: _start < 1 ? ColorConstants.colorLogin : Colors.white.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                style: TextHelper.smallTextStyle
                                    .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: height * .02),
                          Text(
                            'We would like to get to know you!',
                            maxLines: 10,
                            style: TextHelper.largeFontStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: height * .03),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                                  controller: firstNameController,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) return 'Please enter valid first name';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'First Name',
                                    labelText: 'First Name',
                                    hintStyle:
                                        TextHelper.normalTextStyle.copyWith(color: Colors.white.withOpacity(0.6)),
                                    labelStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                                  controller: lastNameController,
                                  validator: (v) {
                                    if (v == null || v.isEmpty) return 'Please enter valid last name';
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    labelText: 'Last Name',
                                    hintStyle:
                                        TextHelper.normalTextStyle.copyWith(color: Colors.white.withOpacity(0.6)),
                                    labelStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * .02),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gender',
                              style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                            ),
                          ),
                          SizedBox(height: height * .01),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white.withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        gender = 'F';
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: height * .05,
                                      decoration: BoxDecoration(
                                        color: gender == 'F' ? Colors.white : Colors.transparent,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Female',
                                        style: TextHelper.normalTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: gender == 'F' ? ColorConstants.colorBlueSeventeen : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 2,
                                  height: height * .05,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        gender = 'M';
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: height * .05,
                                      decoration: BoxDecoration(
                                        color: gender == 'M' ? Colors.white : Colors.transparent,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Male',
                                        style: TextHelper.normalTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: gender == 'M' ? ColorConstants.colorBlueSeventeen : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * .02),
                          TextFormField(
                            style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                            controller: ageController,
                            validator: (v) {
                              if (v == null || v.isEmpty) return 'Please enter valid age';
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Age',
                              labelText: 'Age',
                              hintStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white.withOpacity(0.6)),
                              labelStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            ),
                          ),
                          SizedBox(height: height * .02),
                          TextFormField(
                            style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                            controller: mobileController,
                            onChanged: (v) => validateMobile(v, provider),
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                              //To remove first '0'
                              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Phone Number',
                              labelText: 'Phone Number',
                              counterText: '',
                              hintStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white.withOpacity(0.6)),
                              labelStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                          if (_phoneValidation != null && mobileController.text.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                _phoneValidation ?? '',
                                style: TextHelper.smallTextStyle.copyWith(color: Colors.red),
                              ),
                            ),
                          SizedBox(height: height * .02),
                          TextFormField(
                            style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                            controller: emailController,
                            onChanged: (v) => validateEmail(
                              v,
                              provider,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              labelText: 'Email',
                              hintStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white.withOpacity(0.6)),
                              labelStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                              suffix: (_emailValidation == null)
                                  ? const SizedBox.shrink()
                                  : (emailValidated != null && emailValidated!)
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
                          if (_emailValidation != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _emailValidation ?? '',
                                  style: TextHelper.smallTextStyle.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: height * .02),
                          TextFormField(
                            style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                            controller: pinController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (v) {
                              if (v != null) {
                                if (v.isEmpty) {
                                  return 'Pincode cannot be blank';
                                } else if (v.isNotEmpty && v.length < 6) {
                                  return 'Enter a valid pincode';
                                } else if (v.isNotEmpty && v.length > 6) {
                                  return 'Enter a valid pincode';
                                } else {
                                  return null;
                                }
                              }
                              return null;
                            },
                            onChanged: (v) {
                              if (v.length >= 6) {
                                FocusScope.of(context).unfocus();
                                fetchPincode(provider, v);
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Pin Code',
                              labelText: 'Pin Code',
                              hintStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white.withOpacity(0.6)),
                              labelStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            ),
                          ),
                          SizedBox(height: height * .02),
                          TextFormField(
                            style: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                            controller: cityController,
                            readOnly: true,
                            validator: (v) {
                              if (v == null || v.length < 3) return 'Please enter valid city';
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'City',
                              labelText: 'City',
                              hintStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white.withOpacity(0.6)),
                              labelStyle: TextHelper.normalTextStyle.copyWith(color: Colors.white),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            ),
                          ),
                          SizedBox(height: height * .03),
                          InkWell(
                            onTap: () {
                              final bool? validated = _registerForm.currentState?.validate();
                              if (validated != null &&
                                  validated &&
                                  mobileValidated != null &&
                                  mobileValidated! &&
                                  emailValidated != null &&
                                  emailValidated! &&
                                  gender != null) {
                                register(provider);
                              } else {
                                ScaffoldSnackBar.of(context).show('PLease enter correct details');
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
                                'Sign Up',
                                style: TextHelper.subTitleStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstants.colorBlackTwo,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: height * .02),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                builder: (c) => _Dialog(
                                  height: height,
                                  width: width,
                                ),
                              );
                            },
                            child: Text.rich(
                              maxLines: 5,
                              TextSpan(
                                style: TextHelper.smallTextStyle
                                    .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                                text:
                                    'By Signing Up, You Consent to Receive SMS, WhatsApp Messages, Email and Telephone Calls! ',
                                children: [
                                  TextSpan(
                                    text: 'Read Terms',
                                    style: TextHelper.smallTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.colorLogin,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: height * .02),
                        ],
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Dialog extends StatelessWidget {
  final double height;
  final double width;

  const _Dialog({required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '"Consent to Receive SMS, WhatsApp Messages, Email and Telephone Calls"',
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  style: TextHelper.smallTextStyle.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: height * .02),
                Text(
                  'You consent to receive SMS messages (text messages), WhatsApp messages, and telephone calls (including pre-recorded and artificial voice and AutoDialed) from Fabpiks; our agents or delivery partners may communicate on our behalf of Fabpiks at the specific number(s) you have provided to us, for delivery,  service-related information or promotions or any questions about your use of the Services, and Even Account issues and marketing information.   You certify, warrant, and represent that the telephone number and email you provided are your contact details and not someone else’s. You represent that you are permitted to receive calls, SMS, WhatsApp, or email at the details you provided.   You agree to alert us whenever you stop using a telephone number promptly. We may modify or terminate our SMS/WhatsApp messaging services, for any reason, and without notice, without liability to you.',
                  maxLines: 1000,
                  style: TextHelper.smallTextStyle,
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 25,
            child: InkWell(
              onTap: () => context.router.maybePop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xffEDEBEB),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.close_rounded,
                  color: Color(0xff606060),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
