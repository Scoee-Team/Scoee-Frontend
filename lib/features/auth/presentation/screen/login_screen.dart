import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/figma_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const _logoAsset = 'assets/images/logo.png';
  static const _kakaoAsset = 'assets/images/login/kakao_login_btn.png';
  static const _googleAsset = 'assets/images/login/google_login_btn.png';
  static const _appleAsset = 'assets/images/login/apple_login_btn.png';

  @override
  Widget build(BuildContext context) {
    return FigmaPage(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
        child: Column(
          children: [
            const Spacer(flex: 3),
            Image.asset(_logoAsset, width: 112, height: 112),
            const SizedBox(height: 28),
            const Text(
              '친구들과 스코어를 예측해보세요',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: FigmaColors.text,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                height: 1.18,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '경기 전 예측하고 결과가 나오면 편차를 확인해요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: FigmaColors.muted,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.35,
              ),
            ),
            const Spacer(flex: 4),
            _OAuthImageButton(
              key: const Key('kakao_login_button'),
              assetName: _kakaoAsset,
              label: '카카오로 로그인',
              onTap: () => context.go('/'),
            ),
            const SizedBox(height: 12),
            _OAuthImageButton(
              key: const Key('google_login_button'),
              assetName: _googleAsset,
              label: '구글로 로그인',
              onTap: () => context.go('/'),
            ),
            const SizedBox(height: 12),
            _OAuthImageButton(
              key: const Key('apple_login_button'),
              assetName: _appleAsset,
              label: 'Apple로 로그인',
              onTap: () => context.go('/'),
            ),
            const SizedBox(height: 22),
            const Text(
              '로그인하면 서비스 이용약관과 개인정보 처리방침에 동의하게 됩니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: FigmaColors.dim,
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OAuthImageButton extends StatelessWidget {
  const _OAuthImageButton({
    required this.assetName,
    required this.label,
    required this.onTap,
    super.key,
  });

  final String assetName;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              assetName,
              height: 52,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
