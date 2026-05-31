import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../l10n/app_localizations.dart';
import '../models/user.dart';
import '../providers/auth_provider.dart';
import '../widgets/profile_app_bar_leading.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/theme_mode_button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  Future<void> _pickProfileImage(User user) async {
    final l10n = AppLocalizations.of(context)!;
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );
    if (image == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final profileDir = Directory('${appDir.path}/profile_images');
    if (!profileDir.existsSync()) {
      await profileDir.create(recursive: true);
    }

    final ext = image.path.split('.').last;
    final destPath = '${profileDir.path}/${user.id}.$ext';
    await File(image.path).copy(destPath);

    await ref.read(authProvider.notifier).updateProfile(profileImagePath: destPath);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.profilePictureUpdated)),
      );
    }
  }

  Future<void> _removeProfileImage(User user) async {
    if (user.profileImagePath != null) {
      final file = File(user.profileImagePath!);
      if (file.existsSync()) {
        await file.delete();
      }
    }
    await ref.read(authProvider.notifier).updateProfile(clearProfileImage: true);
  }

  Future<void> _showPhotoOptions(User user) async {
    final l10n = AppLocalizations.of(context)!;

    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(l10n.changeProfilePicture),
              onTap: () {
                Navigator.pop(ctx);
                _pickProfileImage(user);
              },
            ),
            if (user.profileImagePath != null)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: Text(l10n.removeProfilePicture),
                onTap: () {
                  Navigator.pop(ctx);
                  _removeProfileImage(user);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showEditNameDialog(User user) async {
    final l10n = AppLocalizations.of(context)!;
    final firstNameController = TextEditingController(text: user.firstName);
    final lastNameController = TextEditingController(text: user.lastName);

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.editProfile),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: firstNameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: l10n.firstName),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: lastNameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: l10n.lastName),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              final firstName = firstNameController.text.trim();
              final lastName = lastNameController.text.trim();
              if (firstName.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.nameRequired)),
                );
                return;
              }
              await ref.read(authProvider.notifier).updateProfile(
                    firstName: firstName,
                    lastName: lastName,
                  );
              if (!ctx.mounted) return;
              Navigator.pop(ctx);
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.profileUpdated)),
              );
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );

    firstNameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(authProvider).user;

    return Scaffold(
      appBar: AppBar(
        leading: const ProfileAppBarLeading(),
        title: Text(l10n.profileTitle),
        actions: const [
          ThemeModeButton(),
        ],
      ),
      body: user == null
          ? Center(
              child: Text(
                l10n.noUserLoggedIn,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => _showPhotoOptions(user),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ProfileAvatar(user: user, radius: 56),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.surface,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => _showPhotoOptions(user),
                    child: Text(l10n.changeProfilePicture),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          user.fullName,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          tooltip: l10n.editProfile,
                          onPressed: () => _showEditNameDialog(user),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
