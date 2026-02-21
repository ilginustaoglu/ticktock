import 'package:flutter/material.dart';

import 'home_screen.dart';

/// App launch screen using the Tick Tock splash design.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const _splashDuration = Duration(milliseconds: 2200);

  @override
  void initState() {
    super.initState();
    Future.delayed(_splashDuration, _goToHome);
  }

  void _goToHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  static const _backgroundColor = Color(0xFF2C2C2C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: _backgroundColor,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Image.asset(
                  'lib/logo/tick_tock_splash.png',
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  filterQuality: FilterQuality.high,
                ),
              ),
              // Soft edge fade: logo stays clear, gentle blend at edges
              IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.92,
                      colors: [
                        Colors.transparent,
                        _backgroundColor.withValues(alpha: 0.25),
                        _backgroundColor.withValues(alpha: 0.85),
                        _backgroundColor,
                      ],
                      stops: const [0.58, 0.78, 0.92, 1.0],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
