import 'package:artichaut_flutter/screens/room_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:artichaut_flutter/models/room.dart';
import 'package:artichaut_flutter/widgets/cards/room_card.dart';

import '../themes/app_theme.dart';


class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = Room.getSampleRooms();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Nos Chambres'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return RoomCard(
            room: room,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomDetailScreen(room: room),
                ),
              );
            },
          );
        },
      ),
    );
  }
}