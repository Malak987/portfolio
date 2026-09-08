import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final double liftY;
  final Duration duration;

  const HoverCard({
    super.key,
    required this.child,
    this.liftY = 8,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovered ? -widget.liftY : 0, 0),
        child: widget.child,
      ),
    );
  }
}