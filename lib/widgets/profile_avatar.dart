import 'dart:io';

import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.user,
    this.radius = 18,
  });

  final User? user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final imagePath = user?.profileImagePath;
    final hasImage =
        imagePath != null && File(imagePath).existsSync();

    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primaryContainer,
      backgroundImage: hasImage ? FileImage(File(imagePath)) : null,
      child: hasImage
          ? null
          : Icon(
              Icons.person,
              size: radius,
              color: colorScheme.onPrimaryContainer,
            ),
    );
  }
}
