import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CustomButton({required this.title, this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.onSecondary,
          minimumSize: const Size(double.infinity, double.infinity)
        ),
        child: Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
        )
    );
  }
}