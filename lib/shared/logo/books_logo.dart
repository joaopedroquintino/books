import '../../packages/ds/app_system.dart';
import 'logo_painter.dart';

enum LogoVariant {
  vertical,
  horizontal,
}

class BooksLogo extends StatelessWidget {
  const BooksLogo.horizontal({
    Key? key,
    this.width,
    this.height,
    this.margin,
    this.color,
  })  : logoVariant = LogoVariant.horizontal,
        super(key: key);

  const BooksLogo.vertical({
    Key? key,
    this.width,
    this.height,
    this.margin,
    this.color,
  })  : logoVariant = LogoVariant.vertical,
        super(key: key);

  final LogoVariant logoVariant;
  final double? width;
  final double? height;
  final EdgeInsets? margin;
  final Color? color;

  double? get _defaultWidth =>
      logoVariant == LogoVariant.vertical ? 155.w : null;
  double? get _defaultHeight =>
      logoVariant == LogoVariant.vertical ? null : 40.h;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width ?? _defaultWidth,
      height: height ?? _defaultHeight,
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (logoVariant) {
      case LogoVariant.vertical:
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgetList,
        );
      case LogoVariant.horizontal:
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: widgetList,
        );
    }
  }

  Size get _logoSize {
    final _width = width ?? _defaultWidth;
    final _height = height ?? _defaultHeight;
    if (_width != null) {
      return Size(_width, (_width * 0.35).toDouble());
    } else if (_height != null) {
      return Size((_height / 0.35).toDouble(), _height);
    }
    return Size.zero;
  }

  List<Widget> get widgetList => [
        CustomPaint(
          size: _logoSize,
          painter: LogoCustomPainter(color: color),
        ),
        SizedBox(width: AppDS.spacing.hsmall.w),
        Text(
          'Books',
          style: logoVariant == LogoVariant.vertical
              ? AppDS.fonts.title1.copyWith(color: color)
              : AppDS.fonts.title3.copyWith(color: color),
        ),
      ];
}
