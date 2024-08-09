import 'dart:async';
import 'dart:developer';

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

class SignupScreenDesktop extends StatefulWidget {
  const SignupScreenDesktop({super.key});

  @override
  State<SignupScreenDesktop> createState() => _SignupScreenDesktopState();
}

class _SignupScreenDesktopState extends State<SignupScreenDesktop> {
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

  // Future<void> initDynamicLinks() async {
  //   if (widget.referCode != null) {
  //     referController.text = widget.referCode!;
  //   }
  // }

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

  // fetchPincode(AppProvider provider, String pincode) async {
  //   try {
  //     final response = await _dioHelper.dio.get(
  //       '${StringConstants.pincodeApi}$pincode',
  //       options: Options(
  //         headers: {
  //           'Accept': 'application/json',
  //         },
  //       ),
  //     );
  //     final data = response.data[0] as Map<String, dynamic>;
  //     if (data['Status'] == 'Success' && data['PostOffice'].isNotEmpty) {
  //       PostOffice temp = PostOffice.fromJson(data['PostOffice'][0]);
  //       cityController.text = temp.division;
  //       stateController.text = temp.state;
  //       if (mounted) setState(() {});
  //     } else {
  //       if (!mounted) return;
  //       ScaffoldSnackBar.of(context).show('Invalid pincode');
  //     }
  //   } on DioException catch (_, e) {
  //     log(e.toString());
  //   }
  // }

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
      context.router.replace(HomeRoute(orderSuccess: false));
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

  // @override
  // void initState() {
  //   initDynamicLinks();
  //   super.initState();
  // }

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
                Form(
                  key: _registerForm,
                  child: Container(
                    padding: EdgeInsets.only(left: width * .09, top: height * .1, bottom: height * .08),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: otpSent
                              ? Container(
                                  margin: EdgeInsets.only(
                                    top: height * .01,
                                    bottom: height * .01,
                                    right: width * .13,
                                  ),
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
                                                sendOtp(mobileController.text, true);
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
                                            login(mobileController.text, otpController.text, provider);
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
                                            style: TextHelper.smallTextStyle
                                                .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Column(
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
                                                    TextSpan(
                                                        text: '*',
                                                        style:
                                                            TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: height * .01),
                                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                                decoration: const BoxDecoration(
                                                  // border: Border.all(width: width * .0005),
                                                  // border: Border(
                                                  //   right: BorderSide(
                                                  //     color: Colors.black,
                                                  //     width: 0.2,
                                                  //   ),
                                                  //   left: BorderSide(
                                                  //     color: Colors.black,
                                                  //     width: 0.6,
                                                  //   ),
                                                  //   bottom: BorderSide(
                                                  //     color: Colors.black,
                                                  //     width: 0.6,
                                                  //   ),
                                                  //   top: BorderSide(
                                                  //     color: Colors.black,
                                                  //     width: 0.6,
                                                  //   ),
                                                  // ),
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    bottomLeft: Radius.circular(10),
                                                  ),
                                                ),
                                                child: TextFormField(
                                                  validator: (v) {
                                                    if (v == null || v.isEmpty) return 'Please enter valid first name';
                                                    return null;
                                                  },
                                                  controller: firstNameController,
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.only(left: width * .01),
                                                    border: const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 0.2,
                                                      ),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(10),
                                                        bottomLeft: Radius.circular(10),
                                                      ),
                                                    ),
                                                    hintStyle: const TextStyle(
                                                      fontSize: 17.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                                  TextSpan(
                                                      text: '*',
                                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(vertical: height * .01),
                                              decoration: const BoxDecoration(
                                                // border: Border.all(),
                                                // border: Border.all(width: width * .0005),
                                                // border: Border(
                                                //   right: BorderSide(
                                                //     color: Colors.black,
                                                //     width: 0.6,
                                                //   ),
                                                //   left: BorderSide(
                                                //     color: Colors.black,
                                                //     width: 0.2,
                                                //   ),
                                                //   bottom: BorderSide(
                                                //     color: Colors.black,
                                                //     width: 0.6,
                                                //   ),
                                                //   top: BorderSide(
                                                //     color: Colors.black,
                                                //     width: 0.6,
                                                //   ),
                                                // ),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: TextFormField(
                                                controller: lastNameController,
                                                validator: (v) {
                                                  if (v == null || v.isEmpty) return 'Please enter valid last name';
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(left: width * .01),
                                                  border: const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 0.2,
                                                    ),
                                                    borderRadius: BorderRadius.only(
                                                      topRight: Radius.circular(10),
                                                      bottomRight: Radius.circular(10),
                                                    ),
                                                  ),
                                                  hintStyle: const TextStyle(
                                                    fontSize: 17.0,
                                                  ),
                                                ),
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
                                                    TextSpan(
                                                        text: '*',
                                                        style:
                                                            TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          gender = 'M';
                                                        });
                                                      },
                                                      child: Container(
                                                        height: height * .07,
                                                        alignment: Alignment.center,
                                                        margin: EdgeInsets.symmetric(vertical: height * .01),
                                                        decoration: BoxDecoration(
                                                          color: gender == 'M' ? const Color(0xff030d4e) : Colors.white,
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
                                                            color: gender == 'M' ? Colors.white : Colors.black,
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
                                                          gender = 'F';
                                                        });
                                                      },
                                                      child: Container(
                                                        height: height * .07,
                                                        alignment: Alignment.center,
                                                        margin: EdgeInsets.symmetric(vertical: height * .01),
                                                        decoration: BoxDecoration(
                                                          color: gender == 'F' ? const Color(0xff030d4e) : Colors.white,
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
                                                            color: gender == 'F' ? Colors.white : Colors.black,
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
                                              TextSpan(
                                                  text: '*',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(vertical: height * .01),
                                          // decoration: BoxDecoration(
                                          //   // border: Border.fromBorderSide(),
                                          //   // border: Border.all(width: width * .0005),
                                          //   // borderRadius: BorderRadius.only(
                                          //   //   topRight: Radius.circular(10),
                                          //   // ),
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                          child: TextFormField(
                                            controller: ageController,
                                            validator: (v) {
                                              if (v == null || v.isEmpty) return 'Please enter valid age';
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: width * .01),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 0.2,
                                                ),
                                              ),
                                              hintText: '',
                                              hintStyle: const TextStyle(
                                                fontSize: 17.0,
                                              ),
                                            ),
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
                                              TextSpan(
                                                  text: '*',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(vertical: height * .01),
                                          // decoration: BoxDecoration(
                                          //   // border: Border.fromBorderSide(),
                                          //   border: Border.all(width: width * .0005),
                                          //   // borderRadius: BorderRadius.only(
                                          //   //   topRight: Radius.circular(10),
                                          //   // ),
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                          child: TextFormField(
                                            onChanged: (String v) => validateMobile(v, provider),
                                            maxLength: 10,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                              //To remove first '0'
                                              FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                                            ],
                                            controller: mobileController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: width * .01),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 0.2,
                                                ),
                                              ),
                                              hintText: '',
                                              hintStyle: const TextStyle(
                                                fontSize: 17.0,
                                              ),
                                              counterText: '',
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
                                        if (_phoneValidation != null && mobileController.text.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Text(
                                              _phoneValidation ?? '',
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12.0,
                                              ),
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
                                              TextSpan(
                                                  text: '*',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(vertical: height * .01),
                                          // decoration: BoxDecoration(
                                          //   // border: Border.fromBorderSide(),
                                          //   border: Border.all(width: width * .0005),
                                          //   // borderRadius: BorderRadius.only(
                                          //   //   topRight: Radius.circular(10),
                                          //   // ),
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                          child: TextFormField(
                                            controller: emailController,
                                            onChanged: (v) => validateEmail(
                                              v,
                                              provider,
                                            ),
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: width * .01),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 0.2,
                                                ),
                                              ),
                                              hintText: '',
                                              hintStyle: const TextStyle(
                                                fontSize: 17.0,
                                              ),
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
                                        ),
                                        if (_emailValidation != null)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                _emailValidation ?? '',
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
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
                                              TextSpan(
                                                  text: '*',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(vertical: height * .01),
                                          // decoration: BoxDecoration(
                                          //   // border: Border.fromBorderSide(),
                                          //   border: Border.all(width: width * .0005),
                                          //   // borderRadius: BorderRadius.only(
                                          //   //   topRight: Radius.circular(10),
                                          //   // ),
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                          child: TextFormField(
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
                                            // onChanged: (v) {
                                            //   if (v.length >= 6) {
                                            //     FocusScope.of(context).unfocus();
                                            //     fetchPincode(provider, v);
                                            //   }
                                            // },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: width * .01),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 0.2,
                                                ),
                                              ),
                                              hintText: '',
                                              hintStyle: const TextStyle(
                                                fontSize: 17.0,
                                              ),
                                            ),
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
                                              TextSpan(
                                                  text: '*',
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.symmetric(vertical: height * .01),
                                          // decoration: BoxDecoration(
                                          //   // border: Border.fromBorderSide(),
                                          //   border: Border.all(width: width * .0005),
                                          //   // borderRadius: BorderRadius.only(
                                          //   //   topRight: Radius.circular(10),
                                          //   // ),
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                          child: TextFormField(
                                            controller: cityController,
                                            readOnly: false,
                                            validator: (v) {
                                              if (v == null || v.length < 3) return 'Please enter valid city';
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(left: width * .01),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 0.2,
                                                ),
                                              ),
                                              hintText: '',
                                              hintStyle: const TextStyle(
                                                fontSize: 17.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .04,
                                    ),
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
                                      ),
                                    )
                                  ],
                                ),
                        ),
                        const Expanded(
                          flex: 4,
                          child: SizedBox.shrink(),
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
