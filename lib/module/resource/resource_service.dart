import 'package:analyzer_x/analyzer_x.dart';

import 'package:analyzer_x_server/model/xxmodel.dart';

class ResourceService {
  AssetAddResponse addAsset(AssetAddParam param) {
    AssetAddResponse response = AssetAddResponse.fromJson({});
    param.types.forEach(
      (type) {
        try {
          switch (type) {
            case AssetResourceType.image:
              ImageResource.build(
                param.sourceFolder,
                param.projPath,
                customConfig: (config) => config
                  ..needOverwrite = param.needOverwrite
                  ..cleanUndefineAsset = param.cleanUndefineAsset
                  ..cleanNoCitedAssetDefine = param.cleanNoCitedAssetDefine
                  ..needBinding = param.needBinding,
              );
              break;
            case AssetResourceType.svg:
              SvgResource.build(
                param.sourceFolder,
                param.projPath,
                customConfig: (config) => config
                  ..needOverwrite = param.needOverwrite
                  ..cleanUndefineAsset = param.cleanUndefineAsset
                  ..cleanNoCitedAssetDefine = param.cleanNoCitedAssetDefine
                  ..needBinding = param.needBinding,
              );
              break;
            case AssetResourceType.json:
              JsonResource.build(
                param.sourceFolder,
                param.projPath,
                customConfig: (config) => config
                  ..needOverwrite = param.needOverwrite
                  ..cleanUndefineAsset = param.cleanUndefineAsset
                  ..cleanNoCitedAssetDefine = param.cleanNoCitedAssetDefine
                  ..needBinding = param.needBinding,
              );
              break;
            case AssetResourceType.lottie:
              LottieResource.build(
                param.sourceFolder,
                param.projPath,
                customConfig: (config) => config
                  ..needOverwrite = param.needOverwrite
                  ..cleanUndefineAsset = param.cleanUndefineAsset
                  ..cleanNoCitedAssetDefine = param.cleanNoCitedAssetDefine
                  ..needBinding = param.needBinding,
              );
              break;
            case AssetResourceType.media:
              MediaResource.build(
                param.sourceFolder,
                param.projPath,
                customConfig: (config) => config
                  ..needOverwrite = param.needOverwrite
                  ..cleanUndefineAsset = param.cleanUndefineAsset
                  ..cleanNoCitedAssetDefine = param.cleanNoCitedAssetDefine
                  ..needBinding = param.needBinding,
              );
              break;
          }
          response.successItem.add(type);
        } catch (e) {
          response.failedItem.add(type);
        }
      },
    );
    return response;
  }
}
