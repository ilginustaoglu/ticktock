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

  ImageProvider? _imageProvider(User user) {
    final path = user.profileImagePath;
    if (path != null && File(path).existsSync()) {
      return FileImage(File(path));
    }
    final url = user.profileImageUrl;
    if (url != null && url.isNotEmpty) {
      return NetworkImage(url);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final image = user != null ? _imageProvider(user!) : null;

    return CircleAvatar(
      radius: radius,
      backgroundColor: colorScheme.primaryContainer,
      backgroundImage: image,
      child: image == null
          ? Icon(
              Icons.person,
              size: radius,
              color: colorScheme.onPrimaryContainer,
            )
          : null,
    );
  }
}
