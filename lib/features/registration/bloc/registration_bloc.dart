import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/mobile_storage_service.dart';
import '../../../services/verification_storage_service.dart';
import '../data/auth_repository.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository repo;

  RegistrationBloc(this.repo) : super(const RegistrationState()) {
    on<MobileSubmitted>(_onMobileSubmitted);
    on<OtpSubmitted>(_onOtpSubmitted);
    on<ResendOtp>(_onResendOtp);
    on<ProfileTypeSelected>(_onProfileTypeSelected);
    on<PersonalDetailsUpdated>(_onPersonalDetailsUpdated);
    on<ReligionAnswerUpdated>(_onReligionAnswerUpdated);
    on<SubmitRegistration>(_onSubmitRegistration);
  }

  Future<void> _onMobileSubmitted(
    MobileSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    final cleanedMobile = event.mobile.replaceAll(RegExp(r'\s+'), '');

    emit(
      state.copyWith(
        status: RegistrationStatus.loading,
        mobile: cleanedMobile,
        error: null,
      ),
    );

    try {
      final otp = await repo.sendOtp(cleanedMobile);

      emit(
        state.copyWith(
          status: RegistrationStatus.otpSent,
          otpCode: otp,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: RegistrationStatus.failure, error: e.toString()),
      );
    }
  }

  Future<void> _onResendOtp(
    ResendOtp event,
    Emitter<RegistrationState> emit,
  ) async {
    final cleanedMobile = event.mobile.replaceAll(RegExp(r'\s+'), '');

    emit(state.copyWith(status: RegistrationStatus.loading, error: null));

    try {
      final otp = await repo.sendOtp(cleanedMobile);

      emit(
        state.copyWith(
          status: RegistrationStatus.otpSent,
          otpCode: otp,
          error: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: RegistrationStatus.failure, error: e.toString()),
      );
    }
  }

  Future<void> _onOtpSubmitted(
    OtpSubmitted event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(status: RegistrationStatus.loading, error: null));

    try {
      final mobileToVerify = event.mobile.isNotEmpty
          ? event.mobile
          : state.mobile;

      if (mobileToVerify.isEmpty) {
        throw Exception('Mobile number not found');
      }

      final ok = await repo.verifyOtp(mobileToVerify, event.otp);
      if (ok) {
        // Save verification status and mobile number
        await VerificationStorageService.saveVerificationStatus(true);
        await MobileStorageService.saveVerifiedMobile(mobileToVerify);

        emit(state.copyWith(status: RegistrationStatus.verified, error: null));
      } else {
        emit(
          state.copyWith(
            status: RegistrationStatus.failure,
            error: 'Invalid OTP. Please try again.',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(status: RegistrationStatus.failure, error: e.toString()),
      );
    }
  }

  void _onProfileTypeSelected(
    ProfileTypeSelected event,
    Emitter<RegistrationState> emit,
  ) {
    emit(state.copyWith(profileType: event.type, error: null));
  }

  void _onPersonalDetailsUpdated(
    PersonalDetailsUpdated event,
    Emitter<RegistrationState> emit,
  ) {
    final merged = {...state.personalDetails, ...event.details};
    emit(state.copyWith(personalDetails: merged, error: null));
  }

  void _onReligionAnswerUpdated(
    ReligionAnswerUpdated event,
    Emitter<RegistrationState> emit,
  ) {
    final merged = {...state.religionAnswers, ...event.answers};
    emit(state.copyWith(religionAnswers: merged, error: null));
  }

  Future<void> _onSubmitRegistration(
    SubmitRegistration event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(state.copyWith(status: RegistrationStatus.loading, error: null));

    try {
      final payload = {
        'mobile': state.mobile,
        'profileType': state.profileType,
        'personalDetails': state.personalDetails,
        'religionAnswers': state.religionAnswers,
      };

      await repo.submitProfile(payload);

      emit(state.copyWith(status: RegistrationStatus.success, error: null));
    } catch (e) {
      emit(
        state.copyWith(status: RegistrationStatus.failure, error: e.toString()),
      );
    }
  }
}
