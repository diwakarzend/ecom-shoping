import 'package:dio/dio.dart';
import 'package:fabpiks_web/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/models.dart';

class DioHelper {
  static final DioHelper _instance = DioHelper._internal();
  late final Dio _dio;
  late final Dio dio;
  Box loginBox = Hive.box<LoginDetails>(StringConstants.loginBoxKey);
  LoginDetails? loginDetails;

  DioHelper._internal() {
    initialize();
  }

  factory DioHelper() {
    return _instance;
  }

  initialize() async {
    loginDetails = loginBox.get('login');
    _dio = Dio();
    dio = Dio();
    if (loginDetails != null) {
      addToken();
    }
    _dio.options.responseType = ResponseType.json;
    _dio.options.baseUrl = StringConstants.apiUrl;
  }

  Future<dynamic> addToken() async {
    _dio.options.headers.addEntries({'Authorization': 'Bearer ${loginDetails?.token}'}.entries);
    _dio.options.headers.addEntries({'Accept': 'application/json'}.entries);
  }

  void updateToken(LoginDetails details) async {
    _dio.options.headers.addEntries({'Authorization': 'Bearer ${details.token}'}.entries);
  }

  Future<Response?> get(String url, {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.get(url, queryParameters: queryParameters);
    } catch (e) {
      final error = e as DioException;
      debugPrint('name: url${error.message}');
    }
    return null;
  }

  Future<Response?> post(String url, {dynamic data, Options? options}) async {
    try {
      return await _dio.post(url, data: data, options: options);
    } catch (e) {
      final error = e as DioException;
      debugPrint('name: url${error.message}');
    }
    return null;
  }

  Future<Response?> put(String url, {Map<String, dynamic>? data, Options? options}) async {
    try {
      return await _dio.put(url, data: data, options: options);
    } catch (e) {
      final error = e as DioException;
      debugPrint('name: url${error.message}');
    }
    return null;
  }

  Future<Response?> delete(String url, {Map<String, dynamic>? data, Options? options}) async {
    try {
      return await _dio.delete(url, data: data, options: options);
    } catch (e) {
      final error = e as DioException;
      debugPrint('name: url${error.message}');
    }
    return null;
  }
}
