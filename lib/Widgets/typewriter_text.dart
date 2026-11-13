import 'dart:async';
import 'package:flutter/material.dart';
import '../Utils/colors.dart';

/// Ultra-light typewriter effect (replaces the animated_text_kit dependency).
/// Types each phrase, pauses, deletes it, then moves to the next — forever.
class TypewriterText extends StatefulWidget {
  final List<String> phrases;
  final TextStyle style;
  final Duration typeSpeed;
  final Duration deleteSpeed;
  final Duration holdDuration;

  const TypewriterText({
    super.key,
    required this.phrases,
    required this.style,
    this.typeSpeed = const Duration(milliseconds: 70),
    this.deleteSpeed = const Duration(milliseconds: 35),
    this.holdDuration = const Duration(milliseconds: 1600),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  int _phraseIndex = 0;
  int _charCount = 0;
  bool _deleting = false;
  Timer? _timer;

  String get _currentPhrase => widget.phrases[_phraseIndex % widget.phrases.length];

  @override
  void initState() {
    super.initState();
    _tick();
  }

  void _tick() {
    final phrase = _currentPhrase;
    Duration delay;

    if (!_deleting) {
      _charCount++;
      delay = widget.typeSpeed;
      if (_charCount == phrase.length) {
        _deleting = true;
        delay = widget.holdDuration;
      }
    } else {
      _charCount--;
      delay = widget.deleteSpeed;
      if (_charCount == 0) {
        _deleting = false;
        _phraseIndex = (_phraseIndex + 1) % widget.phrases.length;
        delay = const Duration(milliseconds: 350);
      }
    }

    _timer = Timer(delay, () {
      if (!mounted) return;
      setState(() {});
      _tick();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shown = _currentPhrase.substring(0, _charCount.clamp(0, _currentPhrase.length));
    return Text.rich(
      TextSpan(
        text: shown,
        style: widget.style,
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: _Cursor(color: widget.style.color ?? AppColors.gold),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.clip,
    );
  }
}

class _Cursor extends StatefulWidget {
  final Color color;
  const _Cursor({required this.color});

  @override
  State<_Cursor> createState() => _CursorState();
}

class _CursorState extends State<_Cursor> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(milliseconds: 500), (t) {
      if (mounted) setState(() => _visible = !_visible);
      else t.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _visible ? 1 : 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Text('|', style: TextStyle(color: widget.color, fontWeight: FontWeight.w400)),
      ),
    );
  }
}
