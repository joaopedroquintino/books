import '../../packages/ds/app_system.dart';
import 'styles/primary.dart';
import 'styles/style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;

  CustomButtonStyle get buttonStyle => PrimaryButtonStyle();

  ButtonStyle get style {
    return ButtonStyle(
      backgroundColor: onPressed != null
          ? buttonStyle.background
          : buttonStyle.inativeBackground,
      textStyle: buttonStyle.textStyle,
      shape: buttonStyle.shape,
      foregroundColor: buttonStyle.foregroundColor,
      overlayColor: buttonStyle.overlayColor,
      shadowColor: ButtonStyleButton.allOrNull(Colors.transparent),
    );
  }

  @override
  Widget build(BuildContext context) {
    // FontWeight.w
    return SizedBox(
      width: width,
      height: height ?? 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: style,
      ),
    );
  }
}
