import '../../packages/ds/app_system.dart';
import 'loading_widget.dart';

class AppLoadingPage {
  AppLoadingPage._();

  bool _isLoading = false;

  static final AppLoadingPage instance = AppLoadingPage._();

  void start(BuildContext context) {
    if (!_isLoading) {
      _isLoading = true;
      Navigator.of(context).push<void>(
        PageRouteBuilder(
          opaque: false,
          barrierColor: AppDS.color.black.withOpacity(0.5),
          barrierDismissible: false,
          pageBuilder: (_, __, ___) {
            return WillPopScope(
              onWillPop: () async => false,
              child: const Center(
                child: AppLoadingWidget(),
              ),
            );
          },
        ),
      );
    }
  }

  void stop(BuildContext context) {
    if (_isLoading) {
      _isLoading = false;
      Navigator.of(context).pop();
    }
  }
}
