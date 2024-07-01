import 'package:json_annotation/json_annotation.dart';
import 'package:top_up_ticket/shared/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? id;
  final String? name;
  final bool? isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User get toEntity => User(
        id: id ?? '',
        name: name ?? '',
        isVerified: isVerified ?? false,
      );
}
