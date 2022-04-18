import '../../../packages/ds/app_system.dart';
import 'style.dart';

class PrimaryButtonStyle implements CustomButtonStyle {
  @override
  MaterialStateProperty<Color>? background = MaterialStateProperty.all(
    AppDS.color.primary,
  );

  @override
  MaterialStateProperty<Color>? foregroundColor = MaterialStateProperty.all(
    AppDS.color.onPrimary,
  );
  @override
  MaterialStateProperty<TextStyle>? textStyle = MaterialStateProperty.all(
    AppDS.fonts.buttonMedium,
  );
  @override
  MaterialStateProperty<RoundedRectangleBorder>? shape =
      MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDS.borderRadius.small.w),
    ),
  );

  @override
  MaterialStateProperty<Color>? overlayColor;

  @override
  MaterialStateProperty<Color>? shadowColor;

  @override
  MaterialStateProperty<Color>? inativeBackground = MaterialStateProperty.all(
    AppDS.color.gray,
  );
}
