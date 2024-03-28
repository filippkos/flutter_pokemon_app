/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesAppIconGen get appIcon => const $AssetsImagesAppIconGen();
  $AssetsImagesDashboardGen get dashboard => const $AssetsImagesDashboardGen();
  $AssetsImagesIconButtonsGen get iconButtons =>
      const $AssetsImagesIconButtonsGen();
  $AssetsImagesPokemonTypeIconsGen get pokemonTypeIcons =>
      const $AssetsImagesPokemonTypeIconsGen();
  $AssetsImagesSpinnerGen get spinner => const $AssetsImagesSpinnerGen();
}

class $AssetsImagesAppIconGen {
  const $AssetsImagesAppIconGen();

  /// File path: assets/images/app_icon/android.png
  AssetGenImage get android =>
      const AssetGenImage('assets/images/app_icon/android.png');

  /// File path: assets/images/app_icon/ios.png
  AssetGenImage get ios =>
      const AssetGenImage('assets/images/app_icon/ios.png');

  /// List of all assets
  List<AssetGenImage> get values => [android, ios];
}

class $AssetsImagesDashboardGen {
  const $AssetsImagesDashboardGen();

  /// File path: assets/images/dashboard/dashboard_all.png
  AssetGenImage get dashboardAll =>
      const AssetGenImage('assets/images/dashboard/dashboard_all.png');

  /// File path: assets/images/dashboard/dashboard_bg.png
  AssetGenImage get dashboardBg =>
      const AssetGenImage('assets/images/dashboard/dashboard_bg.png');

  /// File path: assets/images/dashboard/dashboard_purple.png
  AssetGenImage get dashboardPurple =>
      const AssetGenImage('assets/images/dashboard/dashboard_purple.png');

  /// File path: assets/images/dashboard/dashboard_shadow.png
  AssetGenImage get dashboardShadow =>
      const AssetGenImage('assets/images/dashboard/dashboard_shadow.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [dashboardAll, dashboardBg, dashboardPurple, dashboardShadow];
}

class $AssetsImagesIconButtonsGen {
  const $AssetsImagesIconButtonsGen();

  /// File path: assets/images/icon_buttons/back_arrow.png
  AssetGenImage get backArrow =>
      const AssetGenImage('assets/images/icon_buttons/back_arrow.png');

  /// List of all assets
  List<AssetGenImage> get values => [backArrow];
}

class $AssetsImagesPokemonTypeIconsGen {
  const $AssetsImagesPokemonTypeIconsGen();

  /// File path: assets/images/pokemon_type_icons/bug.png
  AssetGenImage get bug =>
      const AssetGenImage('assets/images/pokemon_type_icons/bug.png');

  /// File path: assets/images/pokemon_type_icons/dark.png
  AssetGenImage get dark =>
      const AssetGenImage('assets/images/pokemon_type_icons/dark.png');

  /// File path: assets/images/pokemon_type_icons/dragon.png
  AssetGenImage get dragon =>
      const AssetGenImage('assets/images/pokemon_type_icons/dragon.png');

  /// File path: assets/images/pokemon_type_icons/electric.png
  AssetGenImage get electric =>
      const AssetGenImage('assets/images/pokemon_type_icons/electric.png');

  /// File path: assets/images/pokemon_type_icons/fairy.png
  AssetGenImage get fairy =>
      const AssetGenImage('assets/images/pokemon_type_icons/fairy.png');

  /// File path: assets/images/pokemon_type_icons/fighting.png
  AssetGenImage get fighting =>
      const AssetGenImage('assets/images/pokemon_type_icons/fighting.png');

  /// File path: assets/images/pokemon_type_icons/fire.png
  AssetGenImage get fire =>
      const AssetGenImage('assets/images/pokemon_type_icons/fire.png');

  /// File path: assets/images/pokemon_type_icons/flying.png
  AssetGenImage get flying =>
      const AssetGenImage('assets/images/pokemon_type_icons/flying.png');

  /// File path: assets/images/pokemon_type_icons/ghost.png
  AssetGenImage get ghost =>
      const AssetGenImage('assets/images/pokemon_type_icons/ghost.png');

  /// File path: assets/images/pokemon_type_icons/grass.png
  AssetGenImage get grass =>
      const AssetGenImage('assets/images/pokemon_type_icons/grass.png');

  /// File path: assets/images/pokemon_type_icons/ground.png
  AssetGenImage get ground =>
      const AssetGenImage('assets/images/pokemon_type_icons/ground.png');

  /// File path: assets/images/pokemon_type_icons/icy.png
  AssetGenImage get icy =>
      const AssetGenImage('assets/images/pokemon_type_icons/icy.png');

  /// File path: assets/images/pokemon_type_icons/normal.png
  AssetGenImage get normal =>
      const AssetGenImage('assets/images/pokemon_type_icons/normal.png');

  /// File path: assets/images/pokemon_type_icons/poison.png
  AssetGenImage get poison =>
      const AssetGenImage('assets/images/pokemon_type_icons/poison.png');

  /// File path: assets/images/pokemon_type_icons/psychic.png
  AssetGenImage get psychic =>
      const AssetGenImage('assets/images/pokemon_type_icons/psychic.png');

  /// File path: assets/images/pokemon_type_icons/rock.png
  AssetGenImage get rock =>
      const AssetGenImage('assets/images/pokemon_type_icons/rock.png');

  /// File path: assets/images/pokemon_type_icons/steel.png
  AssetGenImage get steel =>
      const AssetGenImage('assets/images/pokemon_type_icons/steel.png');

  /// File path: assets/images/pokemon_type_icons/water.png
  AssetGenImage get water =>
      const AssetGenImage('assets/images/pokemon_type_icons/water.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        bug,
        dark,
        dragon,
        electric,
        fairy,
        fighting,
        fire,
        flying,
        ghost,
        grass,
        ground,
        icy,
        normal,
        poison,
        psychic,
        rock,
        steel,
        water
      ];
}

class $AssetsImagesSpinnerGen {
  const $AssetsImagesSpinnerGen();

  /// File path: assets/images/spinner/spinner.png
  AssetGenImage get spinner =>
      const AssetGenImage('assets/images/spinner/spinner.png');

  /// List of all assets
  List<AssetGenImage> get values => [spinner];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
