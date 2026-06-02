import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const _heroAsset = 'assets/images/onboarding/hero_football.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 390),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.background,
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.15,
                colors: [
                  Color(0x260A84FF),
                  Color(0x080A84FF),
                  AppColors.background,
                ],
                stops: [0, 0.42, 1],
              ),
            ),
            child: const _OnboardingBody(),
          ),
        ),
      ),
    );
  }
}

class _OnboardingBody extends StatelessWidget {
  const _OnboardingBody();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final heightScale = constraints.maxHeight / 897;
        final compactScale = heightScale.clamp(0.88, 1.0);
        final footerHeight = 208.0 * compactScale;
        final topShift = constraints.maxHeight < 860 ? -18.0 : 0.0;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topRight,
                    radius: 1.35,
                    colors: [
                      const Color(0x1A47E266),
                      const Color(0x0505FF05).withValues(alpha: 0),
                      AppColors.background,
                    ],
                    stops: const [0, 0.34, 1],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 224,
              left: 98,
              child: _SoftGlow(color: Color(0x0DAAC7FF), size: 384),
            ),
            const Positioned(
              right: -98,
              bottom: 224,
              child: _SoftGlow(color: Color(0x0D47E266), size: 256),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 64,
              child: const _Header(),
            ),
            Positioned(
              top: 96 + topShift,
              left: 20,
              right: 20,
              height: 374 * compactScale,
              child: _HeroVisual(scale: compactScale),
            ),
            Positioned(
              top: 474 + topShift,
              left: 20,
              right: 20,
              child: const _OnboardingCopy(),
            ),
            Positioned(
              top: 631 + topShift,
              left: 0,
              right: 0,
              child: const _PageIndicator(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: footerHeight,
              child: const _BottomActions(),
            ),
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'The Loser',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: const Color(0xFFE3E2E7),
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
                height: 1.2,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
                  child: Text(
                    'PREMIUM',
                    style: TextStyle(
                      color: Color(0xFF8B91A0),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 16 / 12,
                      letterSpacing: 0.24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroVisual extends StatelessWidget {
  const _HeroVisual({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 374 * scale,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          const Positioned.fill(
            child: Center(
              child: _SoftGlow(color: Color(0x20AAC7FF), size: 300),
            ),
          ),
          Transform.rotate(
            angle: 12 * math.pi / 180,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(48 * scale),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 280 * scale,
                  height: 280 * scale,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(48 * scale),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x55000000),
                        blurRadius: 50,
                        offset: Offset(0, 24),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(47 * scale),
                    child: Image.asset(
                      OnboardingScreen._heroAsset,
                      fit: BoxFit.cover,
                      color: Colors.black.withValues(alpha: 0.18),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: -8,
            child: Transform.scale(scale: scale, child: const _ScoreChip()),
          ),
          Positioned(
            left: -12,
            bottom: 0,
            child: Transform.scale(scale: scale, child: const _LoserChip()),
          ),
        ],
      ),
    );
  }
}

class _ScoreChip extends StatelessWidget {
  const _ScoreChip();

  @override
  Widget build(BuildContext context) {
    return _GlassChip(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.trending_up_rounded, color: Color(0xFF47E266), size: 18),
          SizedBox(width: 8),
          Text(
            '2 : 1',
            style: TextStyle(
              color: Color(0xFFE3E2E7),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoserChip extends StatelessWidget {
  const _LoserChip();

  @override
  Widget build(BuildContext context) {
    return _GlassChip(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_remove_alt_1_outlined,
            color: AppColors.danger,
            size: 18,
          ),
          SizedBox(width: 8),
          Text(
            '꼴찌',
            style: TextStyle(
              color: Color(0xFFFFB4AB),
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 28 / 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingCopy extends StatelessWidget {
  const _OnboardingCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              color: Color(0xFFE3E2E7),
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 32 / 24,
              letterSpacing: 0,
            ),
            children: [
              TextSpan(text: '친구들과 함께 경기 스코어를\n'),
              TextSpan(
                text: '예측해보세요',
                style: TextStyle(color: Color(0xFF3E90FF)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              color: Color(0xFF8B91A0),
              fontSize: 17,
              fontWeight: FontWeight.w500,
              height: 24 / 17,
            ),
            children: [
              TextSpan(text: '가장 멀리 빗나간 친구가\n오늘의 '),
              TextSpan(
                text: '꼴찌',
                style: TextStyle(
                  color: Color(0xFFFFB4AB),
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0x4DFFB4AA),
                ),
              ),
              TextSpan(text: '입니다.'),
            ],
          ),
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _IndicatorDot(width: 32, color: Color(0xFF3E90FF)),
        SizedBox(width: 8),
        _IndicatorDot(width: 6, color: Color(0xFF414754)),
        SizedBox(width: 8),
        _IndicatorDot(width: 6, color: Color(0xFF414754)),
      ],
    );
  }
}

class _IndicatorDot extends StatelessWidget {
  const _IndicatorDot({required this.width, required this.color});

  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: SizedBox(width: width, height: 6),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.7),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              left: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              right: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(21, 24, 21, 49),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: () => context.go('/'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF3E90FF),
                        foregroundColor: const Color(0xFF002957),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 28 / 20,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('시작하기'),
                          SizedBox(width: 8),
                          Icon(Icons.chevron_right_rounded, size: 22),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 64,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => context.go('/'),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF8B91A0),
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 22 / 15,
                              ),
                            ),
                            child: const Text('로그인'),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 16,
                          color: const Color(0xFF414754),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () => context.go('/'),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFF8B91A0),
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                height: 22 / 15,
                              ),
                            ),
                            child: const Text('가입하기'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassChip extends StatelessWidget {
  const _GlassChip({required this.child, required this.padding});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40000000),
                blurRadius: 50,
                offset: Offset(0, 25),
              ),
            ],
          ),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class _SoftGlow extends StatelessWidget {
  const _SoftGlow({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
          child: SizedBox.square(dimension: size),
        ),
      ),
    );
  }
}
