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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage(name: 'EditAddressRoute')
class EditAddress extends StatefulWidget {
  final Shipping shipping;

  const EditAddress({super.key, required this.shipping});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers = [];

  final DioHelper _dioHelper = DioHelper();

  void validateAndSave(AppProvider provider) {
    final FormState? form = _formKey.currentState;
    if (form != null && form.validate()) {
      saveData(provider);
    } else {
      if (kDebugMode) {
        print('Form is invalid');
      }
    }
  }

  Future saveData(AppProvider provider) async {
    ScaffoldLoaderDialog.of(context).show();
    final response = await _dioHelper.post(
      'shipping/${widget.shipping.id}',
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
      if (!mounted) return;
      ScaffoldLoaderDialog.of(context).hide();
      provider.initWithLogin();
      if (!mounted) return;
      ScaffoldLoaderDialog.of(context).hide();
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
    for (int i = 0; i < 9; i++) {
      _controllers.add(TextEditingController());
      if (mounted) setState(() {});
    }
    _controllers[0].text = widget.shipping.shippingName;
    _controllers[1].text = widget.shipping.shippingPincode;
    _controllers[2].text = widget.shipping.shippingAddress;
    _controllers[3].text = widget.shipping.shippingLandmark;
    _controllers[4].text = widget.shipping.shippingCity;
    _controllers[5].text = widget.shipping.shippingState;
    _controllers[6].text = widget.shipping.shippingPhone;
    _controllers[7].text = widget.shipping.shippingAlternatePhone;
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
              elevation: 5,
              centerTitle: false,
              title: const Text('Edit Address'),
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
                onTap: () => validateAndSave(provider),
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
