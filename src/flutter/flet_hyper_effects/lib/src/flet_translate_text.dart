import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyper_effects/hyper_effects.dart';

class Translation extends StatefulWidget {
  final double? size;
  final String? value;
  final String? oldValue;
  final String? font;

  const Translation({
    super.key,
    this.size,
    this.value,
    this.oldValue,
    this.font,
  });

  @override
  State<Translation> createState() => _TranslationState();
}

class _TranslationState extends State<Translation> {
  static const double DEFAULT_FONT_SIZE = 56.0;

  late List<String> _words;
  int currentIndex = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _initWords();
  }

  void _initWords() {
    if (widget.oldValue != null &&
        widget.value != null &&
        widget.oldValue != widget.value) {
      _words = [widget.oldValue!, widget.value!];
      currentIndex = 0;
      _animateToNextValue();
    } else {
      _words = [widget.value ?? ''];
      currentIndex = 0;
    }
  }

  void _animateToNextValue() {
    if (_isAnimating || currentIndex >= _words.length - 1) return;

    _isAnimating = true;

    Future.delayed(Duration.zero, () {
      if (mounted) {
        setState(() {
          currentIndex = 1;
        });

        Future.delayed(const Duration(milliseconds: 1000), () {
          if (mounted) {
            setState(() {
              _isAnimating = false;
            });
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(Translation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value && !_isAnimating) {
      setState(() {
        _words = [_words[currentIndex], widget.value ?? ''];
        currentIndex = 0;
        _animateToNextValue();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle;

    if (widget.font != null && widget.font!.isNotEmpty) {
      textStyle = GoogleFonts.getFont(
        widget.font!,
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: widget.size ?? DEFAULT_FONT_SIZE,
        ),
      );
    } else {
      textStyle = GoogleFonts.sacramento().copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: widget.size ?? DEFAULT_FONT_SIZE,
      );
    }

    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0),
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white,
          Colors.white.withOpacity(0),
        ],
      ).createShader(rect),
      child: ShaderMask(
        shaderCallback: (rect) => const LinearGradient(
          colors: [Color(0xFFD4145A), Color(0xFFFBB03B)],
        ).createShader(rect),
        child: Text(
          _words[currentIndex],
          style: textStyle,
        )
            .roll(
              symbolDistanceMultiplier: 2,
              tapeCurve: Curves.easeInOutBack,
              widthCurve: Curves.easeInOutQuart,
              padding: const EdgeInsets.only(right: 3),
            )
            .animate(
              trigger: currentIndex,
              duration: const Duration(milliseconds: 1000),
            ),
      ),
    );
  }
}
