/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:fabpiks_web/helpers/helpers.dart';
import 'package:fabpiks_web/models/models.dart';
import 'package:fabpiks_web/providers/providers.dart';
import 'package:fabpiks_web/routes/router.gr.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// @RoutePage(name: 'AddAddressRoute')
class AddAddressMobile extends StatefulWidget {
  final bool fromCart;

  const AddAddressMobile({
    super.key,
    required this.fromCart,
  });

  @override
  State<AddAddressMobile> createState() => _AddAddressMobileState();
}

class _AddAddressMobileState extends State<AddAddressMobile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool? married, haveKids;
  List<String> selectedInterests = [];
  List<String> selectedInterestsTwo = [];

  late AppProvider _appProvider;

  final DioHelper _dioHelper = DioHelper();

  final List<TextEditingController> _controllers = [];

  void validateAndSave(AppProvider provider, bool updateProfile) {
    final FormState? form = _formKey.currentState;
    if (form != null && form.validate()) {
      saveData(provider, updateProfile);
    } else {
      if (kDebugMode) {
        print('Form is invalid');
      }
    }
  }

  Future saveData(AppProvider provider, bool updateProfile) async {
    ScaffoldLoaderDialog.of(context).show();
    final response = await _dioHelper.post(
      'shipping',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'shipping_name': _controllers[0].text,
        'shipping_pincode': _controllers[1].text,
        'shipping_address': _controllers[2].text,
        'shipping_landmark': _controllers[3].text,
        'shipping_city': _controllers[4].text,
        'shipping_state': _controllers[5].text,
        'shipping_phone': _controllers[6].text,
        'shipping_alternate_phone': _controllers[7].text,
        'same_billing': 1,
      },
    );
    if (response != null && response.data['status']) {
      if (updateProfile) {
        saveDetails(provider);
      } else {
        provider.initWithLogin();
        if (widget.fromCart) {
          if (!mounted) return;
          context.router.popUntilRouteWithName(CartRoute.name);
        } else {
          if (!mounted) return;
          context.router.popUntilRouteWithName(ProfileRoute.name);
        }
      }
    }
  }

  Future saveDetails(AppProvider provider) async {
    ScaffoldLoaderDialog.of(context).show();
    final response = await _dioHelper.post(
      'user/${provider.loginDetails?.uId}',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: {
        'first_name': provider.currentUser?.firstName,
        'last_name': provider.currentUser?.lastName,
        'email': provider.currentUser?.email,
        'mobile_no': provider.currentUser?.mobileNo,
        'gender': provider.currentUser?.gender,
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
        'age': provider.currentUser?.age,
        'interests': selectedInterests,
      },
    );
    if (response != null && response.data['status']) {
      provider.initWithLogin();
      if (widget.fromCart) {
        if (!mounted) return;
        context.router.popUntilRouteWithName(CartRoute.name);
      } else {
        if (!mounted) return;
        context.router.popUntilRouteWithName(ProfileRoute.name);
      }
    } else {
      if (!mounted) return;
      ScaffoldSnackBar.of(context).show('something went wrong');
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
        _controllers[4].text = temp.division;
        _controllers[5].text = temp.state;
        if (mounted) setState(() {});
      } else {
        if (!mounted) return;
        ScaffoldSnackBar.of(context).show('Invalid pincode');
      }
    } on DioException catch (_, e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    _appProvider = Provider.of<AppProvider>(context, listen: false);
    for (int i = 0; i < 9; i++) {
      _controllers.add(TextEditingController());
      if (mounted) setState(() {});
    }
    if (_appProvider.currentUser != null) {
      _controllers[0].text = '${_appProvider.currentUser!.firstName} ${_appProvider.currentUser!.lastName}';
      _controllers[6].text = _appProvider.currentUser!.mobileNo;
      _controllers[1].text = _appProvider.currentUser!.pincode;
      _controllers[4].text = _appProvider.currentUser!.city;
      _controllers[5].text = _appProvider.currentUser!.state;
    }
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
            extendBody: true,
            appBar: AppBar(
              centerTitle: false,
              title: const Text('Add new Address'),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * .03),
                    Text(
                      'Delivery to',
                      style: TextHelper.titleStyle,
                    ),
                    SizedBox(height: height * .02),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _controllers[0],
                        style: TextHelper.normalTextStyle,
                        validator: (v) {
                          if (v != null) return v.isEmpty ? 'Name cannot be blank' : null;
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Name*',
                          labelStyle: TextHelper.normalTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _controllers[6],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) {
                          String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          RegExp regExp = RegExp(pattern);
                          if (v != null && v.isNotEmpty && v.length == 10) {
                            if (!regExp.hasMatch(v)) {
                              return 'Please enter valid mobile number';
                            } else {
                              return null;
                            }
                          } else {
                            return 'Please enter valid mobile number';
                          }
                        },
                        style: TextHelper.normalTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Mobile No*',
                          labelStyle: TextHelper.normalTextStyle,
                          errorStyle: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorRed),
                        ),
                      ),
                    ),
                    if (provider.currentUser?.married == null)
                      Column(
                        children: [
                          Container(
                            width: width,
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorConstants.colorBlackThree, width: 0.5),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Married',
                                  style: TextHelper.normalTextStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.colorBlackTwo,
                                  ),
                                ),
                                DropdownButton<bool>(
                                  value: married,
                                  underline: const SizedBox.shrink(),
                                  items: const [
                                    DropdownMenuItem(
                                      value: false,
                                      child: Text('No'),
                                    ),
                                    DropdownMenuItem(
                                      value: true,
                                      child: Text('Yes'),
                                    ),
                                  ],
                                  onChanged: (bool? v) {
                                    setState(() {
                                      if (v != null) {
                                        married = v;
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          if (married != null && married!)
                            Container(
                              width: width,
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorConstants.colorBlackThree, width: 0.5),
                                borderRadius: BorderRadius.circular(70),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Do you have kids',
                                    style: TextHelper.normalTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstants.colorBlackTwo,
                                    ),
                                  ),
                                  DropdownButton<bool>(
                                    value: haveKids,
                                    underline: const SizedBox.shrink(),
                                    items: const [
                                      DropdownMenuItem(
                                        value: false,
                                        child: Text('No'),
                                      ),
                                      DropdownMenuItem(
                                        value: true,
                                        child: Text('Yes'),
                                      ),
                                    ],
                                    onChanged: (bool? v) {
                                      setState(() {
                                        if (v != null) {
                                          haveKids = v;
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Trial Offer You are Interested In?',
                              style: TextHelper.normalTextStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.colorBlackTwo,
                              ),
                            ),
                          ),
                          SizedBox(height: height * .02),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: selectedInterests.length == provider.categories.length,
                                checkColor: Colors.white,
                                activeColor: ColorConstants.colorGreenFour,
                                onChanged: (v) {
                                  if (selectedInterests.length == provider.categories.length) {
                                    selectedInterests.clear();
                                  } else {
                                    for (var c in provider.categories) {
                                      selectedInterests.add(c.id);
                                    }
                                  }
                                  setState(() {});
                                },
                              ),
                              Text(
                                'Select All',
                                style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorGreyThree),
                              ),
                            ],
                          ),
                          ...provider.categories.map(
                            (e) => Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: selectedInterests.any((element) => element == e.id),
                                  checkColor: Colors.white,
                                  activeColor: ColorConstants.colorGreenFour,
                                  onChanged: (v) {
                                    if (selectedInterests.any((element) => element == e.id)) {
                                      selectedInterests.remove(e.id);
                                    } else {
                                      selectedInterests.add(e.id);
                                    }
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  e.name,
                                  style: TextHelper.smallTextStyle.copyWith(color: ColorConstants.colorGreyThree),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * .02),
                        ],
                      ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _controllers[2],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) {
                          if (v != null) return v.isEmpty ? 'Address cannot be blank' : null;
                          return null;
                        },
                        style: TextHelper.normalTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Address*',
                          labelStyle: TextHelper.normalTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _controllers[3],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (v) {
                          if (v != null) return v.isEmpty ? 'Landmark cannot be blank' : null;
                          return null;
                        },
                        style: TextHelper.normalTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Landmark*',
                          labelStyle: TextHelper.normalTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        controller: _controllers[1],
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
                        style: TextHelper.normalTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Pincode*',
                          labelStyle: TextHelper.normalTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        readOnly: true,
                        controller: _controllers[4],
                        style: TextHelper.normalTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'City',
                          labelStyle: TextHelper.normalTextStyle,
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(
                            color: ColorConstants.colorGreyTwo.withOpacity(0.4),
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        readOnly: true,
                        controller: _controllers[5],
                        style: TextHelper.normalTextStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'State',
                          labelStyle: TextHelper.normalTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(height: height * .03),
                    SizedBox(height: height * .15),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              width: width,
              height: height * .07 + MediaQuery.of(context).padding.bottom,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => validateAndSave(provider, provider.currentUser?.married == null),
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                child: Container(
                  width: width,
                  height: height * .05,
                  margin: EdgeInsets.symmetric(horizontal: width * .15),
                  decoration: BoxDecoration(
                    color: ColorConstants.colorPrimaryTwo,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Save & Continue',
                    style: TextHelper.titleStyle.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
