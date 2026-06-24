import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screen/login_screen.dart';
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
import '../../features/profile/presentation/screen/profile_settings_screens.dart';
import '../../features/rankings/presentation/screen/ranking_screen.dart';
import '../widgets/figma_widgets.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/matches',
                builder: (context, state) => const MatchListScreen(),
                routes: [
                  GoRoute(
                    path: ':matchId',
                    builder: (context, state) {
                      final matchId = int.parse(
                        state.pathParameters['matchId']!,
                      );
                      return MatchDetailScreen(matchId: matchId);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/rooms',
                builder: (context, state) => const RoomListScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) => const CreateRoomScreen(),
                  ),
                  GoRoute(
                    path: ':roomId',
                    builder: (context, state) {
                      final roomId = int.parse(state.pathParameters['roomId']!);
                      return RoomDetailScreen(roomId: roomId);
                    },
                    routes: [
                      GoRoute(
                        path: 'predict',
                        builder: (context, state) {
                          final roomId = int.parse(
                            state.pathParameters['roomId']!,
                          );
                          return ScorePredictionScreen(roomId: roomId);
                        },
                      ),
                      GoRoute(
                        path: 'result',
                        builder: (context, state) {
                          final roomId = int.parse(
                            state.pathParameters['roomId']!,
                          );
                          return ResultScreen(roomId: roomId);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ranking',
                builder: (context, state) => const RankingScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) => const ProfileEditScreen(),
                  ),
                  GoRoute(
                    path: 'favorites',
                    builder: (context, state) => const FavoriteSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'notifications',
                    builder: (context, state) =>
                        const NotificationSettingsScreen(),
                  ),
                  GoRoute(
                    path: 'help',
                    builder: (context, state) => const HelpScreen(),
                  ),
                  GoRoute(
                    path: 'policies',
                    builder: (context, state) => const PoliciesScreen(),
                  ),
                  GoRoute(
                    path: 'about',
                    builder: (context, state) => const AboutAppScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return FigmaShellScaffold(
      activeIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) {
        navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        );
      },
      child: navigationShell,
    );
  }
}
