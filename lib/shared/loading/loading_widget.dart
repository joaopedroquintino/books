import '../../packages/ds/app_system.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: const CircularProgressIndicator.adaptive(),
    );
  }
}
