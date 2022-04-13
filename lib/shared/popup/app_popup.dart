import '../../packages/ds/app_system.dart';
import '../../ui/button/app_button.dart';

class AppPopUp {
  AppPopUp._();

  bool _isShowing = false;

  static final AppPopUp instance = AppPopUp._();

  void show(
    BuildContext context, {
    VoidCallback? onPressed,
    String? title,
    String? message,
    String? buttonText,
  }) {
    if (!_isShowing) {
      Navigator.of(context).push<void>(
        PageRouteBuilder(
          opaque: false,
          barrierColor: AppDS.color.black.withOpacity(0.5),
          barrierDismissible: false,
          pageBuilder: (_, __, ___) {
            return Stack(
              children: [
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTapUp: (_) {
                      _stop(context);
                    }),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppDS.spacing.medium.w,
                    ),
                    child: Material(
                      type: MaterialType.card,
                      borderRadius:
                          BorderRadius.circular(AppDS.borderRadius.small),
                      child: Container(
                        height: 217.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDS.spacing.small,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              title ?? '',
                              textAlign: TextAlign.center,
                              style: AppDS.fonts.bodySmallBold,
                            ),
                            SizedBox(
                              height: AppDS.spacing.xsmall,
                            ),
                            Text(
                              message ??
                                  'Ocorreu um erro ao salvar seus dados, tente novamente!',
                              textAlign: TextAlign.center,
                              style: AppDS.fonts.bodySmall,
                            ),
                            SizedBox(height: AppDS.spacing.small),
                            AppButton(
                              child: Text(
                                buttonText ?? 'FECHAR',
                                style: AppDS.fonts.buttonMedium,
                              ),
                              onPressed: () {
                                _stop(context);

                                onPressed?.call();
                              },
                            ),
                            SizedBox(height: AppDS.spacing.xsmall),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
      _isShowing = true;
    }
  }

  void _stop(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}
