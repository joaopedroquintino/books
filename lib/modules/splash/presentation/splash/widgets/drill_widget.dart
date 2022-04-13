import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrillWidget extends StatelessWidget {
  const DrillWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/tools/drill.svg',
    );
  }
}
