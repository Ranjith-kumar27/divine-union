import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

class MobileSubmitted extends RegistrationEvent {
  final String mobile;

  const MobileSubmitted(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

class OtpSubmitted extends RegistrationEvent {
  final String mobile;
  final String otp;

  const OtpSubmitted(this.mobile, this.otp);

  @override
  List<Object?> get props => [mobile, otp];
}

class ResendOtp extends RegistrationEvent {
  final String mobile;

  const ResendOtp(this.mobile);

  @override
  List<Object?> get props => [mobile];
}

class ProfileTypeSelected extends RegistrationEvent {
  final String type;

  const ProfileTypeSelected(this.type);

  @override
  List<Object?> get props => [type];
}

class PersonalDetailsUpdated extends RegistrationEvent {
  final Map<String, dynamic> details;

  const PersonalDetailsUpdated(this.details);

  @override
  List<Object?> get props => [details];
}

class ReligionAnswerUpdated extends RegistrationEvent {
  final Map<String, dynamic> answers;

  const ReligionAnswerUpdated(this.answers);

  @override
  List<Object?> get props => [answers];
}

class SubmitRegistration extends RegistrationEvent {}

class LoadMasterData extends RegistrationEvent {}
