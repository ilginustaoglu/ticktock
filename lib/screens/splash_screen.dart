import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import 'home_screen.dart';
import 'login_screen.dart';

/// App launch screen using the Tick Tock splash design.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  static const _splashDuration = Duration(milliseconds: 2200);

  @override
  void initState() {
    super.initState();
    _navigateWhenReady();
  }

  Future<void> _navigateWhenReady() async {
    await Future.delayed(_splashDuration);
    while (mounted && ref.read(authProvider).status == AuthStatus.loading) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    _navigateNext();
  }

  void _navigateNext() {
    if (!mounted) return;
    final authState = ref.read(authProvider);
    final destination = authState.status == AuthStatus.authenticated
        ? const HomeScreen()
        : const LoginScreen();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => destination),
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
