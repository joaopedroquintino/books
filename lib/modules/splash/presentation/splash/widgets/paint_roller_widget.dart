import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaintRollerWidget extends StatelessWidget {
  const PaintRollerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/tools/paint_roller.svg',
    );
  }
}
