import 'package:equatable/equatable.dart';

enum RegistrationStatus { initial, loading, otpSent, verified, success, failure }

class RegistrationState extends Equatable {
  final RegistrationStatus status;
  final String mobile;
  final String? otpCode;
  final String? profileType;
  final Map<String, dynamic> personalDetails;
  final Map<String, dynamic> religionAnswers;
  final String? error;

  const RegistrationState({
    this.status = RegistrationStatus.initial,
    this.mobile = '',
    this.otpCode,
    this.profileType,
    this.personalDetails = const {},
    this.religionAnswers = const {},
    this.error,
  });

  RegistrationState copyWith({
    RegistrationStatus? status,
    String? mobile,
    String? otpCode,
    String? profileType,
    Map<String, dynamic>? personalDetails,
    Map<String, dynamic>? religionAnswers,
    String? error,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      mobile: mobile ?? this.mobile,
      otpCode: otpCode ?? this.otpCode,
      profileType: profileType ?? this.profileType,
      personalDetails: personalDetails ?? this.personalDetails,
      religionAnswers: religionAnswers ?? this.religionAnswers,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, mobile, otpCode, profileType, personalDetails, religionAnswers, error];
}
