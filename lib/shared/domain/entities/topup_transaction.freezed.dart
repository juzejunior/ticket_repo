// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topup_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TopUpTransaction {
  DateTime get date => throw _privateConstructorUsedError;
  int get value => throw _privateConstructorUsedError;
  Beneficiary get beneficiary => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TopUpTransactionCopyWith<TopUpTransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopUpTransactionCopyWith<$Res> {
  factory $TopUpTransactionCopyWith(
          TopUpTransaction value, $Res Function(TopUpTransaction) then) =
      _$TopUpTransactionCopyWithImpl<$Res, TopUpTransaction>;
  @useResult
  $Res call({DateTime date, int value, Beneficiary beneficiary});

  $BeneficiaryCopyWith<$Res> get beneficiary;
}

/// @nodoc
class _$TopUpTransactionCopyWithImpl<$Res, $Val extends TopUpTransaction>
    implements $TopUpTransactionCopyWith<$Res> {
  _$TopUpTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? value = null,
    Object? beneficiary = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      beneficiary: null == beneficiary
          ? _value.beneficiary
          : beneficiary // ignore: cast_nullable_to_non_nullable
              as Beneficiary,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BeneficiaryCopyWith<$Res> get beneficiary {
    return $BeneficiaryCopyWith<$Res>(_value.beneficiary, (value) {
      return _then(_value.copyWith(beneficiary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TopUpTransactionImplCopyWith<$Res>
    implements $TopUpTransactionCopyWith<$Res> {
  factory _$$TopUpTransactionImplCopyWith(_$TopUpTransactionImpl value,
          $Res Function(_$TopUpTransactionImpl) then) =
      __$$TopUpTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime date, int value, Beneficiary beneficiary});

  @override
  $BeneficiaryCopyWith<$Res> get beneficiary;
}

/// @nodoc
class __$$TopUpTransactionImplCopyWithImpl<$Res>
    extends _$TopUpTransactionCopyWithImpl<$Res, _$TopUpTransactionImpl>
    implements _$$TopUpTransactionImplCopyWith<$Res> {
  __$$TopUpTransactionImplCopyWithImpl(_$TopUpTransactionImpl _value,
      $Res Function(_$TopUpTransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? value = null,
    Object? beneficiary = null,
  }) {
    return _then(_$TopUpTransactionImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      beneficiary: null == beneficiary
          ? _value.beneficiary
          : beneficiary // ignore: cast_nullable_to_non_nullable
              as Beneficiary,
    ));
  }
}

/// @nodoc

class _$TopUpTransactionImpl implements _TopUpTransaction {
  const _$TopUpTransactionImpl(
      {required this.date, required this.value, required this.beneficiary});

  @override
  final DateTime date;
  @override
  final int value;
  @override
  final Beneficiary beneficiary;

  @override
  String toString() {
    return 'TopUpTransaction(date: $date, value: $value, beneficiary: $beneficiary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopUpTransactionImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.beneficiary, beneficiary) ||
                other.beneficiary == beneficiary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, value, beneficiary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TopUpTransactionImplCopyWith<_$TopUpTransactionImpl> get copyWith =>
      __$$TopUpTransactionImplCopyWithImpl<_$TopUpTransactionImpl>(
          this, _$identity);
}

abstract class _TopUpTransaction implements TopUpTransaction {
  const factory _TopUpTransaction(
      {required final DateTime date,
      required final int value,
      required final Beneficiary beneficiary}) = _$TopUpTransactionImpl;

  @override
  DateTime get date;
  @override
  int get value;
  @override
  Beneficiary get beneficiary;
  @override
  @JsonKey(ignore: true)
  _$$TopUpTransactionImplCopyWith<_$TopUpTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
