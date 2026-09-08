
import 'package:flutter/cupertino.dart';

class BluCircle extends StatelessWidget {
  final double size;
  final Color color;

  const BluCircle({
    super.key,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.3),
              color.withOpacity(0.0),
            ],
          ),
        ),
      ),
    );
  }
}