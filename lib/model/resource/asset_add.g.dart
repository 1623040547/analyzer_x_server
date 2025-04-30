// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_add.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetAddParam _$AssetAddParamFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AssetAddParam',
      json,
      ($checkedConvert) {
        final val = AssetAddParam(
          projPath: $checkedConvert('projPath', (v) => v as String),
          sourceFolder: $checkedConvert('sourceFolder', (v) => v as String),
          types: $checkedConvert(
              'types',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => $enumDecode(_$AssetResourceTypeEnumMap, e))
                      .toList() ??
                  []),
          needOverwrite:
              $checkedConvert('needOverwrite', (v) => v as bool? ?? false),
          cleanUndefineAsset:
              $checkedConvert('cleanUndefineAsset', (v) => v as bool? ?? false),
          cleanNoCitedAssetDefine: $checkedConvert(
              'cleanNoCitedAssetDefine', (v) => v as bool? ?? false),
          needBinding:
              $checkedConvert('needBinding', (v) => v as bool? ?? true),
        );
        return val;
      },
    );

Map<String, dynamic> _$AssetAddParamToJson(AssetAddParam instance) =>
    <String, dynamic>{
      'projPath': instance.projPath,
      'sourceFolder': instance.sourceFolder,
      'needOverwrite': instance.needOverwrite,
      'cleanUndefineAsset': instance.cleanUndefineAsset,
      'cleanNoCitedAssetDefine': instance.cleanNoCitedAssetDefine,
      'needBinding': instance.needBinding,
      'types':
          instance.types.map((e) => _$AssetResourceTypeEnumMap[e]!).toList(),
    };

const _$AssetResourceTypeEnumMap = {
  AssetResourceType.image: 'image',
  AssetResourceType.svg: 'svg',
  AssetResourceType.json: 'json',
  AssetResourceType.lottie: 'lottie',
  AssetResourceType.media: 'media',
};

AssetAddResponse _$AssetAddResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'AssetAddResponse',
      json,
      ($checkedConvert) {
        final val = AssetAddResponse(
          successItem: $checkedConvert(
              'successItem',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => $enumDecode(_$AssetResourceTypeEnumMap, e))
                      .toList() ??
                  []),
          failedItem: $checkedConvert(
              'failedItem',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => $enumDecode(_$AssetResourceTypeEnumMap, e))
                      .toList() ??
                  []),
        );
        return val;
      },
    );

Map<String, dynamic> _$AssetAddResponseToJson(AssetAddResponse instance) =>
    <String, dynamic>{
      'successItem': instance.successItem
          .map((e) => _$AssetResourceTypeEnumMap[e]!)
          .toList(),
      'failedItem': instance.failedItem
          .map((e) => _$AssetResourceTypeEnumMap[e]!)
          .toList(),
    };
