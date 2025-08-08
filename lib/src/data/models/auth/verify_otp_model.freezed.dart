// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyOtpModel {

@JsonKey(name: 'phoneNumber') String get phoneNumber;@JsonKey(name: 'otpCode') String get otpCode;
/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyOtpModelCopyWith<VerifyOtpModel> get copyWith => _$VerifyOtpModelCopyWithImpl<VerifyOtpModel>(this as VerifyOtpModel, _$identity);

  /// Serializes this VerifyOtpModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyOtpModel&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,otpCode);

@override
String toString() {
  return 'VerifyOtpModel(phoneNumber: $phoneNumber, otpCode: $otpCode)';
}


}

/// @nodoc
abstract mixin class $VerifyOtpModelCopyWith<$Res>  {
  factory $VerifyOtpModelCopyWith(VerifyOtpModel value, $Res Function(VerifyOtpModel) _then) = _$VerifyOtpModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'phoneNumber') String phoneNumber,@JsonKey(name: 'otpCode') String otpCode
});




}
/// @nodoc
class _$VerifyOtpModelCopyWithImpl<$Res>
    implements $VerifyOtpModelCopyWith<$Res> {
  _$VerifyOtpModelCopyWithImpl(this._self, this._then);

  final VerifyOtpModel _self;
  final $Res Function(VerifyOtpModel) _then;

/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phoneNumber = null,Object? otpCode = null,}) {
  return _then(_self.copyWith(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyOtpModel].
extension VerifyOtpModelPatterns on VerifyOtpModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyOtpModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyOtpModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyOtpModel value)  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyOtpModel value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyOtpModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'phoneNumber')  String phoneNumber, @JsonKey(name: 'otpCode')  String otpCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyOtpModel() when $default != null:
return $default(_that.phoneNumber,_that.otpCode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'phoneNumber')  String phoneNumber, @JsonKey(name: 'otpCode')  String otpCode)  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpModel():
return $default(_that.phoneNumber,_that.otpCode);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'phoneNumber')  String phoneNumber, @JsonKey(name: 'otpCode')  String otpCode)?  $default,) {final _that = this;
switch (_that) {
case _VerifyOtpModel() when $default != null:
return $default(_that.phoneNumber,_that.otpCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VerifyOtpModel implements VerifyOtpModel {
  const _VerifyOtpModel({@JsonKey(name: 'phoneNumber') required this.phoneNumber, @JsonKey(name: 'otpCode') required this.otpCode});
  factory _VerifyOtpModel.fromJson(Map<String, dynamic> json) => _$VerifyOtpModelFromJson(json);

@override@JsonKey(name: 'phoneNumber') final  String phoneNumber;
@override@JsonKey(name: 'otpCode') final  String otpCode;

/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyOtpModelCopyWith<_VerifyOtpModel> get copyWith => __$VerifyOtpModelCopyWithImpl<_VerifyOtpModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyOtpModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyOtpModel&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,phoneNumber,otpCode);

@override
String toString() {
  return 'VerifyOtpModel(phoneNumber: $phoneNumber, otpCode: $otpCode)';
}


}

/// @nodoc
abstract mixin class _$VerifyOtpModelCopyWith<$Res> implements $VerifyOtpModelCopyWith<$Res> {
  factory _$VerifyOtpModelCopyWith(_VerifyOtpModel value, $Res Function(_VerifyOtpModel) _then) = __$VerifyOtpModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'phoneNumber') String phoneNumber,@JsonKey(name: 'otpCode') String otpCode
});




}
/// @nodoc
class __$VerifyOtpModelCopyWithImpl<$Res>
    implements _$VerifyOtpModelCopyWith<$Res> {
  __$VerifyOtpModelCopyWithImpl(this._self, this._then);

  final _VerifyOtpModel _self;
  final $Res Function(_VerifyOtpModel) _then;

/// Create a copy of VerifyOtpModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phoneNumber = null,Object? otpCode = null,}) {
  return _then(_VerifyOtpModel(
phoneNumber: null == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
