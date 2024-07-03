import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_up.freezed.dart';

@freezed
class TopUp with _$TopUp {
  const factory TopUp({
    required int value,
    required String label,
  }) = _TopUp;
}
