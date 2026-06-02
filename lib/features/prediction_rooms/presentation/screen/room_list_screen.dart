import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../home/presentation/screen/home_screen.dart';
import '../widget/room_card.dart';

class RoomListScreen extends ConsumerWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rooms = ref.watch(activeRoomsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('예측방'),
        actions: [
          IconButton(
            onPressed: () => context.go('/rooms/create'),
            icon: const Icon(Icons.add_rounded),
            tooltip: '예측방 만들기',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: rooms
            .map(
              (room) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: RoomCard(
                  room: room,
                  onTap: () => context.go('/rooms/${room.id}'),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
