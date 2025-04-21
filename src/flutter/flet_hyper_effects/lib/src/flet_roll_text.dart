import 'package:flet/flet.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyper_effects/hyper_effects.dart';

import 'package:flet_hyper_effects/src/flet_translate_text.dart';

class TagLine extends StatefulWidget {
  final double? size;
  final String? value;
  final String? oldValue;
  final String? font;

  const TagLine({
    super.key,
    this.size,
    this.value,
    this.oldValue,
    this.font,
  });

  @override
  State<TagLine> createState() => _TagLineState();
}

class _TagLineState extends State<TagLine> {
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
  void didUpdateWidget(TagLine oldWidget) {
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
    // Определяем шрифт - по умолчанию GloriaHallelujah или выбранный пользователем
    TextStyle textStyle;

    if (widget.font != null && widget.font!.isNotEmpty) {
      // Используем указанный пользователем шрифт
      textStyle = GoogleFonts.getFont(
        widget.font!,
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: widget.size ?? DEFAULT_FONT_SIZE,
        ),
      );
    } else {
      // Используем шрифт по умолчанию
      textStyle = GoogleFonts.gloriaHallelujah().copyWith(
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
          colors: [Color(0xFFBFF098), Color(0xFF6FD6FF)],
        ).createShader(rect),
        child: Text(
          _words[currentIndex],
          style: textStyle,
        )
            .roll(
              symbolDistanceMultiplier: 2,
              tapeSlideDirection: TextTapeSlideDirection.down,
              tapeCurve: Curves.easeInOutCubic,
              widthCurve: Curves.easeOutCubic,
              widthDuration: const Duration(milliseconds: 1000),
              padding: const EdgeInsets.only(left: 16),
            )
            .animate(
              trigger: currentIndex,
              duration: const Duration(milliseconds: 1000),
            ),
      ),
    );
  }
}

class HyperEffectsRollControl extends StatefulWidget {
  final Control? parent;
  final Control control;
  final bool parentDisabled;
  final bool? parentAdaptive;
  final List<Control> children;
  final FletControlBackend backend;

  const HyperEffectsRollControl({
    super.key,
    this.parent,
    required this.control,
    required this.children,
    required this.parentDisabled,
    required this.parentAdaptive,
    required this.backend,
  });
  State<HyperEffectsRollControl> createState() =>
      _HyperEffectsRollControlState();
}

class _HyperEffectsRollControlState extends State<HyperEffectsRollControl> {
  static const double DEFAULT_FONT_SIZE = 56.0;

  String? _currentValue;
  String? _previousValue;
  double? _currentSize;
  String? _currentEffectType;
  String? _currentFont;
  Key _widgetKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final size = widget.control.attrDouble("size");
    final finalSize = size ?? DEFAULT_FONT_SIZE;
    final value = widget.control.attrString("value");
    final effectType = widget.control.attrString("effectType") ?? "roll";
    final font = widget.control.attrString("font");

    // Проверяем изменения параметров
    bool shouldUpdateKey = false;

    if (value != null && value != _currentValue) {
      _previousValue = _currentValue;
      _currentValue = value;
      shouldUpdateKey = true;
    }

    if (_currentSize != finalSize) {
      _currentSize = finalSize;
      shouldUpdateKey = true;
    }

    if (_currentEffectType != effectType) {
      _currentEffectType = effectType;
      shouldUpdateKey = true;
    }

    if (_currentFont != font) {
      _currentFont = font;
      shouldUpdateKey = true;
    }

    if (shouldUpdateKey) {
      _widgetKey = UniqueKey();
    }

    // Выбираем виджет в зависимости от типа эффекта
    Widget myControl;

    if (_currentEffectType == "translate") {
      // Используем виджет Translation для эффекта translate
      myControl = Translation(
        key: _widgetKey,
        size: finalSize,
        value: _currentValue,
        oldValue: _previousValue,
        font: _currentFont,
      );
    } else {
      // По умолчанию используем TagLine для эффекта roll
      myControl = TagLine(
        key: _widgetKey,
        size: finalSize,
        value: _currentValue,
        oldValue: _previousValue,
        font: _currentFont,
      );
    }

    return constrainedControl(
        context, myControl, widget.parent, widget.control);
  }
}
