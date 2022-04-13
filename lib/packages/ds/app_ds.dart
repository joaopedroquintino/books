import 'app_border_radius.dart';
import 'app_color.dart';
import 'app_font.dart';
import 'app_spacing.dart';

abstract class DS {
  late AppColor color;
  late AppFont fonts;
  late AppSpacing spacing;
  late AppBorderRadius borderRadius;
}

class _AppDS implements DS {
  _AppDS._() {
    _instance = this;
  }

  @override
  AppColor color = AppColor();
  @override
  AppFont fonts = AppFont();
  @override
  AppBorderRadius borderRadius = AppBorderRadius();
  @override
  AppSpacing spacing = AppSpacing();

  static _AppDS? _instance;
  static _AppDS get instance => _instance ??= _AppDS._();
}

// ignore: non_constant_identifier_names
DS get AppDS => _AppDS.instance;
