import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_otp_model.freezed.dart';
part 'verify_otp_model.g.dart';

@freezed
abstract class VerifyOtpModel with _$VerifyOtpModel {
  const factory VerifyOtpModel({
    @JsonKey(name: 'phoneNumber') required String phoneNumber,
    @JsonKey(name: 'otpCode') required String otpCode,
  }) = _VerifyOtpModel;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpModelFromJson(json);
}
