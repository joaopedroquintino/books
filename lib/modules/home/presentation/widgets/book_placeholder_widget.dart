import '../../../../packages/ds/app_system.dart';

class BookPlaceholder extends StatelessWidget {
  const BookPlaceholder({
    this.width,
    this.height,
    Key? key,
  }) : super(key: key);

  final double? width;
  final double? height;

  double get _defaultWidth => 81.w;
  double get _defaultHeight => 114.w;

  double get _width => width ?? _defaultWidth;
  double get _height => height ?? (_width / _defaultAspect);
  double get _defaultAspect => _defaultWidth / _defaultHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppDS.color.tertiary,
      ),
      padding: EdgeInsets.all(AppDS.spacing.xsmall.w),
      child: AspectRatio(
        aspectRatio: 1 / .65,
        child: CustomPaint(
          size: const Size.fromWidth(double.maxFinite),
          painter: _PlaceHolderCustomPainter(),
        ),
      ),
    );
  }
}

class _PlaceHolderCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path path_0 = Path();
    path_0.moveTo(size.width * 0.2299574, size.height * 0.5181036);
    path_0.cubicTo(
        size.width * 0.2858047,
        size.height * 0.4057714,
        size.width * 0.3959233,
        size.height * 0.4057714,
        size.width * 0.4517698,
        size.height * 0.5181036);
    path_0.lineTo(size.width * 0.6817279, size.height * 0.9806571);
    path_0.lineTo(0, size.height * 0.9806571);
    path_0.lineTo(size.width * 0.2299574, size.height * 0.5181036);
    path_0.close();

    final Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffAB2680).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    final Path path_1 = Path();
    path_1.moveTo(size.width * 0.5667628, size.height * 0.4058536);
    path_1.cubicTo(
        size.width * 0.6082884,
        size.height * 0.3119939,
        size.width * 0.6983605,
        size.height * 0.3119936,
        size.width * 0.7398860,
        size.height * 0.4058536);
    path_1.lineTo(size.width * 0.9941884, size.height * 0.9806571);
    path_1.lineTo(size.width * 0.3124605, size.height * 0.9806571);
    path_1.lineTo(size.width * 0.5667628, size.height * 0.4058536);
    path_1.close();

    final Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffD0608D).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);

    final Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xffD0608D).withOpacity(1.0);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * .5, size.height * .15),
            width: size.width * 0.1136214,
            height: size.height * 0.1696429),
        paint2Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
