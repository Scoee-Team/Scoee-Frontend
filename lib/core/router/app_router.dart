import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screen/home_screen.dart';
import '../../features/matches/presentation/screen/match_detail_screen.dart';
import '../../features/matches/presentation/screen/match_list_screen.dart';
import '../../features/onboarding/presentation/screen/onboarding_screen.dart';
import '../../features/prediction_rooms/presentation/screen/create_room_screen.dart';
import '../../features/prediction_rooms/presentation/screen/result_screen.dart';
import '../../features/prediction_rooms/presentation/screen/room_detail_screen.dart';
import '../../features/prediction_rooms/presentation/screen/room_list_screen.dart';
import '../../features/prediction_rooms/presentation/screen/score_prediction_screen.dart';
import '../../features/profile/presentation/screen/profile_screen.dart';
import '../../features/rankings/presentation/screen/ranking_screen.dart';
import '../constants/app_colors.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(
            path: '/matches',
            builder: (context, state) => const MatchListScreen(),
          ),
          GoRoute(
            path: '/rooms',
            builder: (context, state) => const RoomListScreen(),
          ),
          GoRoute(
            path: '/ranking',
            builder: (context, state) => const RankingScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/matches/:matchId',
        builder: (context, state) {
          final matchId = int.parse(state.pathParameters['matchId']!);
          return MatchDetailScreen(matchId: matchId);
        },
      ),
      GoRoute(
        path: '/rooms/create',
        builder: (context, state) => const CreateRoomScreen(),
      ),
      GoRoute(
        path: '/rooms/:roomId',
        builder: (context, state) {
          final roomId = int.parse(state.pathParameters['roomId']!);
          return RoomDetailScreen(roomId: roomId);
        },
      ),
      GoRoute(
        path: '/rooms/:roomId/predict',
        builder: (context, state) {
          final roomId = int.parse(state.pathParameters['roomId']!);
          return ScorePredictionScreen(roomId: roomId);
        },
      ),
      GoRoute(
        path: '/rooms/:roomId/result',
        builder: (context, state) {
          final roomId = int.parse(state.pathParameters['roomId']!);
          return ResultScreen(roomId: roomId);
        },
      ),
    ],
  );
});

class AppShell extends StatelessWidget {
  const AppShell({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final index = _indexForLocation(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.surfaceAlt,
        onDestinationSelected: (selectedIndex) {
          final route = switch (selectedIndex) {
            0 => '/',
            1 => '/matches',
            2 => '/rooms',
            3 => '/ranking',
            _ => '/profile',
          };
          context.go(route);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_soccer_outlined),
            selectedIcon: Icon(Icons.sports_soccer_rounded),
            label: '경기',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: '방',
          ),
          NavigationDestination(
            icon: Icon(Icons.leaderboard_outlined),
            selectedIcon: Icon(Icons.leaderboard_rounded),
            label: '랭킹',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: '내 정보',
          ),
        ],
      ),
    );
  }

  int _indexForLocation(String location) {
    if (location.startsWith('/matches')) return 1;
    if (location.startsWith('/rooms')) return 2;
    if (location.startsWith('/ranking')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }
}
