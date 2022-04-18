import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../packages/ds/app_system.dart';
import '../../../shared/loading/loading_page.dart';
import '../../../shared/logo/books_logo.dart';
import '../../../ui/button/app_button.dart';
import '../../../ui/input/text_field_widget.dart';
import '../../home/home_routing.dart';
import 'cubits/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final LoginCubit cubit;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> bottomSheetPosition;
  late Animation<double> logoPosition;

  final _animationDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppDS.color.primary,
        body: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/background.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedAlign(
                    alignment: Alignment(0, logoPosition.value),
                    duration: _animationDuration,
                    curve: Curves.ease,
                    child: BooksLogo.vertical(
                      color: AppDS.color.white,
                    ),
                  ),
                  AnimatedAlign(
                    alignment: Alignment(0, bottomSheetPosition.value),
                    duration: _animationDuration,
                    curve: Curves.ease,
                    child: Container(
                      height: 356.h,
                      decoration: BoxDecoration(
                        color: AppDS.color.background,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(AppDS.borderRadius.normal.h),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDS.spacing.small.w,
                            vertical: AppDS.spacing.small.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              inputs(context),
                              margin,
                              button,
                              margin,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  Widget get margin => SizedBox(
        height: 68.h,
      );

  Widget inputs(BuildContext context) {
    return BlocConsumer(
      bloc: widget.cubit,
      builder: (BuildContext _, LoginState state) {
        return Column(
          children: <Widget>[
            TextFieldWidget(
              placeholder: 'E-mail',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              messageError: emailError(state),
              onChanged: (value) => widget.cubit.email = value,
            ),
            SizedBox(
              height: 30.h,
            ),
            TextFieldWidget(
              placeholder: 'Senha',
              isPassword: true,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.send,
              messageError: passwordError(state),
              onChanged: (value) => widget.cubit.password = value,
              onFieldSubmitted: (_) => widget.cubit.authenticate(),
            ),
          ],
        );
      },
      listenWhen: (LoginState previous, LoginState current) {
        if (previous is LoginLoadingState) {
          AppLoadingPage.instance.stop(context);
        }
        return previous != current;
      },
      listener: (BuildContext _, LoginState state) {
        if (state is LoginLoadingState) {
          AppLoadingPage.instance.start(context);
        }
        if (state is LoginSuccessState) {
          Modular.to.navigate(HomeRouteNamed.home.fullPath);
        }
      },
    );
  }

  Widget get button => AppButton(
        child: const Text('ENTRAR'),
        onPressed: () {
          widget.cubit.authenticate();
        },
      );

  String? emailError(LoginState state) =>
      state is LoginErrorState ? state.emailError : null;

  String? passwordError(LoginState state) =>
      state is LoginErrorState ? state.passwordError : null;

  void setUpAnimation() {
    animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    )..forward();

    bottomSheetPosition = Tween<double>(
      begin: 8,
      end: 1,
    ).animate(
      animationController,
    );

    logoPosition = Tween<double>(
      begin: 0,
      end: -.6,
    ).animate(
      animationController,
    );
  }
}
