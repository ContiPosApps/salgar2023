import 'package:flutter/material.dart';
import 'package:salgar2023/theme/app_theme.dart';

class AnimatedHomeScreen extends StatefulWidget {
  const AnimatedHomeScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedHomeScreen> createState() => _AnimatedHomeScreen();
}

class _AnimatedHomeScreen extends State<AnimatedHomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2500))
    ..forward(from: 0);

  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: GestureDetector(
        onTap: () {
          _controller.dispose();
          Navigator.pushNamed(context, 'home');
        },
        child: FadeTransition(
          opacity: _animation,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius((size.width * 0.7)/2), // Image radius
                  child: Image(
                    width: size.width * 0.7,
                    height: size.width * 0.7,
                    image: const AssetImage('assets/salgar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
