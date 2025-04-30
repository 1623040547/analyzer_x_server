import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable(checked: true)
class NoneParam {
  NoneParam();

  factory NoneParam.fromJson(Map<String, dynamic> json) =>
      _$NoneParamFromJson(json);

  Map<String, dynamic> toJson() => _$NoneParamToJson(this);
}

@JsonSerializable(checked: true)
class NoneResponse {
  NoneResponse();

  factory NoneResponse.fromJson(Map<String, dynamic> json) =>
      _$NoneResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NoneResponseToJson(this);
}
