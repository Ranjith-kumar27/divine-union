class MasterDataResponse {
  final List<StateModel> states;
  final List<CityModel> cities;
  final List<String> genders;
  final List<String> maritalStatuses;
  final List<String> motherTongues;
  final List<String> knownLanguages;
  final List<int> heights;
  final List<int> weights;

  MasterDataResponse({
    required this.states,
    required this.cities,
    required this.genders,
    required this.maritalStatuses,
    required this.motherTongues,
    required this.knownLanguages,
    required this.heights,
    required this.weights,
  });

  factory MasterDataResponse.fromJson(Map<String, dynamic> json) {
    return MasterDataResponse(
      states:
          (json['states'] as List?)
              ?.map((e) => StateModel.fromJson(e))
              .toList() ??
          [],
      cities:
          (json['cities'] as List?)
              ?.map((e) => CityModel.fromJson(e))
              .toList() ??
          [],
      genders:
          (json['genders'] as List?)?.map((e) => e as String).toList() ?? [],
      maritalStatuses:
          (json['marital_statuses'] as List?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      motherTongues:
          (json['mother_tongues'] as List?)?.map((e) => e as String).toList() ??
          [],
      knownLanguages:
          (json['known_languages'] as List?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      heights: (json['heights'] as List?)?.map((e) => e as int).toList() ?? [],
      weights: (json['weights'] as List?)?.map((e) => e as int).toList() ?? [],
    );
  }
}

class StateModel {
  final int id;
  final String name;

  StateModel({required this.id, required this.name});

  factory StateModel.fromJson(Map<String, dynamic> json) {
    return StateModel(id: json['id'] as int, name: json['name'] as String);
  }
}

class CityModel {
  final int id;
  final int stateId;
  final String name;

  CityModel({required this.id, required this.stateId, required this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] as int,
      stateId: json['state_id'] as int,
      name: json['name'] as String,
    );
  }
}
