import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../packages/ds/app_system.dart';
import '../../../../shared/logo/books_logo.dart';
import '../../../login/login_routing.dart';
import 'cubits/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final SplashCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDS.color.primary,
      body: BlocListener(
        bloc: cubit,
        listener: (context, SplashState state) {
          if (state is SplashReadyState) {
            if (state.loggedIn) {
              Modular.to.navigate(LoginRouteNamed.login.fullPath);
            } else {
              Modular.to.navigate(LoginRouteNamed.login.fullPath);
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BooksLogo.vertical(
            color: AppDS.color.white,
          ),
        ),
      ),
    );
  }
}
