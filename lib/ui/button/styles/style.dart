import '../../../packages/ds/app_system.dart';

abstract class CustomButtonStyle {
  MaterialStateProperty<Color>? background;
  MaterialStateProperty<Color>? foregroundColor;
  MaterialStateProperty<TextStyle>? textStyle;
  MaterialStateProperty<RoundedRectangleBorder>? shape;
  MaterialStateProperty<Color>? overlayColor;
  MaterialStateProperty<Color>? shadowColor;
  MaterialStateProperty<Color>? inativeBackground;
}
