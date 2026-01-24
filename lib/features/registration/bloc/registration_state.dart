import 'package:equatable/equatable.dart';
import '../data/master_data_model.dart';

enum RegistrationStatus {
  initial,
  loading,
  otpSent,
  verified,
  success,
  failure,
}

class RegistrationState extends Equatable {
  final RegistrationStatus status;
  final String mobile;
  final String? otpCode;
  final String? profileType;
  final Map<String, dynamic> personalDetails;
  final Map<String, dynamic> religionAnswers;
  final String? error;

  // Master Data Fields
  final bool isLoadingMasterData;
  final String? masterDataError;
  final List<StateModel> states;
  final List<CityModel> cities;
  final List<String> genders;
  final List<String> maritalStatuses;
  final List<String> motherTongues;
  final List<String> knownLanguages;
  final List<int> heights;
  final List<int> weights;

  const RegistrationState({
    this.status = RegistrationStatus.initial,
    this.mobile = '',
    this.otpCode,
    this.profileType,
    this.personalDetails = const {},
    this.religionAnswers = const {},
    this.error,
    this.isLoadingMasterData = false,
    this.masterDataError,
    this.states = const [],
    this.cities = const [],
    this.genders = const [],
    this.maritalStatuses = const [],
    this.motherTongues = const [],
    this.knownLanguages = const [],
    this.heights = const [],
    this.weights = const [],
  });

  RegistrationState copyWith({
    RegistrationStatus? status,
    String? mobile,
    String? otpCode,
    String? profileType,
    Map<String, dynamic>? personalDetails,
    Map<String, dynamic>? religionAnswers,
    String? error,
    bool? isLoadingMasterData,
    String? masterDataError,
    List<StateModel>? states,
    List<CityModel>? cities,
    List<String>? genders,
    List<String>? maritalStatuses,
    List<String>? motherTongues,
    List<String>? knownLanguages,
    List<int>? heights,
    List<int>? weights,
  }) {
    return RegistrationState(
      status: status ?? this.status,
      mobile: mobile ?? this.mobile,
      otpCode: otpCode ?? this.otpCode,
      profileType: profileType ?? this.profileType,
      personalDetails: personalDetails ?? this.personalDetails,
      religionAnswers: religionAnswers ?? this.religionAnswers,
      error: error,
      isLoadingMasterData: isLoadingMasterData ?? this.isLoadingMasterData,
      masterDataError:
          masterDataError, // Allow clearing error by passing null, but here we usually just set new error
      states: states ?? this.states,
      cities: cities ?? this.cities,
      genders: genders ?? this.genders,
      maritalStatuses: maritalStatuses ?? this.maritalStatuses,
      motherTongues: motherTongues ?? this.motherTongues,
      knownLanguages: knownLanguages ?? this.knownLanguages,
      heights: heights ?? this.heights,
      weights: weights ?? this.weights,
    );
  }

  @override
  List<Object?> get props => [
    status,
    mobile,
    otpCode,
    profileType,
    personalDetails,
    religionAnswers,
    error,
    isLoadingMasterData,
    masterDataError,
    states,
    cities,
    genders,
    maritalStatuses,
    motherTongues,
    knownLanguages,
    heights,
    weights,
  ];
}
