import 'package:json_annotation/json_annotation.dart';

part 'asset_add.g.dart';

enum AssetResourceType {
  image(
    tips: 'The following suffix will be recognized:'
        '\n`jpg`, `jpeg`, `png`, `gif`, `bmp`'
        '\n ---You have 2 methods to put a image\'s 2x and 3x image'
        '\n ------1. Name the image as `image@2x.suffix` or `image@3x.suffix`'
        '\n ------2. Put the image in the path containing `2.0x` folder or `3.0x` folder',
  ),
  svg(
    tips: 'The following suffix will be recognized:'
        '\n `svg`',
  ),
  json(
    tips: 'The following suffix will be recognized:'
        '\n `json`',
  ),
  lottie(
    tips: 'Lottie is a json file with some images,'
        '\nand we recognize it by following structure:'
        '\n ---`lottie-name`(folder, define by yourself)'
        '\n ------`data.json`(lottie\'s json file, fixed name)'
        '\n ------`images`(lottie\'s cited image file, fixed name)',
  ),
  media(
    tips: 'The following suffix will be recognized:'
        '\n `mp3`, `mp4`',
  );

  final String tips;

  const AssetResourceType({this.tips = ""});
}

@JsonSerializable(checked: true)
class AssetAddParam {
  String projPath;

  String sourceFolder;

  bool needOverwrite;

  bool cleanUndefineAsset;

  bool cleanNoCitedAssetDefine;

  bool needBinding;

  @JsonKey(defaultValue: [])
  List<AssetResourceType> types;

  AssetAddParam({
    required this.projPath,
    required this.sourceFolder,
    required this.types,
    this.needOverwrite = false,
    this.cleanUndefineAsset = false,
    this.cleanNoCitedAssetDefine = false,
    this.needBinding = true,
  });

  factory AssetAddParam.fromJson(Map<String, dynamic> json) =>
      _$AssetAddParamFromJson(json);

  Map<String, dynamic> toJson() => _$AssetAddParamToJson(this);
}

@JsonSerializable(checked: true)
class AssetAddResponse {
  @JsonKey(defaultValue: [])
  List<AssetResourceType> successItem;

  @JsonKey(defaultValue: [])
  List<AssetResourceType> failedItem;

  AssetAddResponse({
    required this.successItem,
    required this.failedItem,
  });

  factory AssetAddResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetAddResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetAddResponseToJson(this);
}
