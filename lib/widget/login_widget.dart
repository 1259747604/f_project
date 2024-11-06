import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;

  const LoginButton(this.title,
      {super.key, this.enable = false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: enable ? onPressed : null,
      color: Colors.orange,
      disabledColor: Colors.white60,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      height: 45,
      child: Text(title,
          style: const TextStyle(color: Colors.white, fontSize: 16)),
    );
  }
}
