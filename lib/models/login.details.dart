/*
 * Copyright (c) 2023 Website Duniya. All rights reserved. The contents of this ide, including all code, text, images, and other materials, are protected by United States and international copyright laws and may not be reproduced, modified, distributed, or used for commercial purposes without express written consent.
 */

import 'package:hive/hive.dart';

part 'login.details.g.dart';

@HiveType(typeId: 1)
class LoginDetails {
  @HiveField(0)
  final bool isLoggedIn;
  @HiveField(1)
  final String role;
  @HiveField(2)
  final String token;
  @HiveField(3)
  final String uId;

  LoginDetails({
    required this.isLoggedIn,
    required this.role,
    required this.token,
    required this.uId,
  });
}
