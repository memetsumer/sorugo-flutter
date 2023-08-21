import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseError extends StatelessWidget {
  final String message;
  const FirebaseError({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(message);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          size: 60,
          color: Colors.redAccent,
        ),
        Text('Bir hata oluştu', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
