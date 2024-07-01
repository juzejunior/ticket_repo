import 'package:top_up_ticket/shared/data/models/user_model.dart';

abstract class UserLocalDatasource {
  Future<UserModel?> getUser();
  Future<void> cacheUser(UserModel user);
}
