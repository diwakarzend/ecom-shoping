// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:dio/dio.dart';
import 'package:fabpiks_web/helpers/dio.helper.dart';
import 'package:flutter/material.dart';

class TestPayment extends StatefulWidget {
  const TestPayment({super.key});

  @override
  State<TestPayment> createState() => _TestPaymentState();
}

class _TestPaymentState extends State<TestPayment> {
  String apiUrl = 'https://fabpicks4u.com/api/v2/easeBuzz';
  final DioHelper _dioHelper = DioHelper();
  String? url;

  // String key = '2PBP7IABZ2';
  // String salt = 'DAH88E3UWQ';
  // String? transactionId;

  payNow({
    required String description,
    required String firstName,
    required String email,
    required num mobile,
  }) async {
    var data = {
      'info': description,
      'name': firstName,
      'phone': mobile,
      'email': email,
      'f_url': 'https://fabpiks.com/test/payment-failed',
      's_url': 'https://fabpiks.com/test/payment-success',
    };
    var response = await _dioHelper.post(
      apiUrl,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
      data: data,
    );

    if (response != null && response.data['status']) {
      log(jsonEncode(response.data), name: 'response_log');
      window.location.href = response.data['int_url'];
      // launchUrl(response.data['int_url']);
    } else {
      log(response?.data.toString() ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Test Payment Page Easebuzz'),
          SizedBox(height: MediaQuery.of(context).size.height * .06),
          Align(
            child: ElevatedButton(
              onPressed: () {
                payNow(description: 'Test', firstName: 'Test', email: 'email@email.com', mobile: 9876543210);
              },
              child: const Text('Pay Now'),
            ),
          ),
        ],
      ),
    );
  }
}
