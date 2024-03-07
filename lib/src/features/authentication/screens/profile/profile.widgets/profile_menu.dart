import 'package:flutter/material.dart';
import 'package:queue_ease/src/utils/constants/colors.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: QEColors.primary),
        child: Icon(icon),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}