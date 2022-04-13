import 'dart:math';

import '../../packages/ds/app_system.dart';
import '../logo/books_logo.dart';

class AppLoadingWidget extends StatefulWidget {
  const AppLoadingWidget({Key? key}) : super(key: key);

  @override
  _AppLoadingWidgetState createState() => _AppLoadingWidgetState();
}

class _AppLoadingWidgetState extends State<AppLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scalingAnimation;

  final icons = <Widget>[
    const Icon(Icons.abc),
  ];

  int direction = 1;

  void changeIcon() {
    setState(() {
      direction = direction * -1;
    });
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        changeIcon();
        _animationController.forward();
      } else if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });

    scalingAnimation = Tween(begin: 0.1, end: 2.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Transform.rotate(
            angle: Tween(begin: 0.0, end: direction * 2 * pi)
                .animate(
                  CurvedAnimation(
                      parent: _animationController, curve: Curves.easeIn),
                )
                .value,
            child: Transform.scale(
              scale: scalingAnimation.value,
              child: const CircularProgressIndicator.adaptive(),
            ),
          );
        },
      ),
    );
  }
}
