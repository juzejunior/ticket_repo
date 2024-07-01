import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:top_up_ticket/shared/data/datasources/remote/user_remote_datasource.dart';
import 'package:top_up_ticket/shared/data/models/user_model.dart';

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  @override
  Future<UserModel> getUser() async {
    String data = await rootBundle.loadString("assets/data/user.json");
    final jsonResult = json.decode(data);
    return UserModel.fromJson(jsonResult);
  }
}