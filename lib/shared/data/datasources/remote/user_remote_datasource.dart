import 'package:top_up_ticket/shared/data/models/user_model.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> getUser();
  Future<void> startTopUpTransaction(int value, int fee);
}
