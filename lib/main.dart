import 'package:artichaut_flutter/screens/room_list_screen.dart';

import 'themes/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LuxuryHotelApp());
}

class LuxuryHotelApp extends StatelessWidget {
  const LuxuryHotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luxury Hotel',
      theme: AppTheme.lightTheme,
      home: const RoomListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}