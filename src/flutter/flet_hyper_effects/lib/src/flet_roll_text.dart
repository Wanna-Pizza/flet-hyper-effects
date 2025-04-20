import 'package:flet/flet.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyper_effects/hyper_effects.dart';

class TagLine extends StatefulWidget {
  final List<String>? tagLines;
  final double? size;
  final bool loopAnimation;
  final String? value;

  const TagLine({
    super.key,
    this.tagLines,
    this.size,
    this.loopAnimation = true,
    this.value,
  });

  @override
  State<TagLine> createState() => _TagLineState();
}

class _TagLineState extends State<TagLine> {
  static const double DEFAULT_FONT_SIZE = 56.0;

  late List<String> _tagLines;
  int tagLine = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();
    _initTagLines();
    _setupTimer();
  }

  void _setupTimer() {
    // Cancel existing timer if any
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }

    // Only start the timer if loopAnimation is true
    if (widget.loopAnimation) {
      timer = Timer.periodic(
          Duration(milliseconds: (1800 * timeDilation).toInt()), (timer) {
        setState(() {
          tagLine = (tagLine + 1) % _tagLines.length;
        });
      });
    }
  }

  void _initTagLines() {
    _tagLines = widget.tagLines ??
        [
          'Kick',
          'Ban',
          'Punch',
          'Fuck',
        ];
  }

  @override
  void didUpdateWidget(TagLine oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Проверяем, изменился ли список слов
    if (widget.tagLines != oldWidget.tagLines) {
      setState(() {
        _initTagLines();
        // Сбрасываем индекс на начало, чтобы изменения были видны сразу
        tagLine = 0;
      });
    }

    // Check if loopAnimation has changed
    if (widget.loopAnimation != oldWidget.loopAnimation) {
      _setupTimer();
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          _tagLines[tagLine],
          style: GoogleFonts.gloriaHallelujah().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: widget.size ?? DEFAULT_FONT_SIZE,
          ),
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
              trigger: tagLine,
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
  // Используем ту же константу, что и в _TagLineState
  static const double DEFAULT_FONT_SIZE = 56.0;

  // Кэшируем текущие параметры для сравнения при обновлении
  List<String>? _currentWords;
  double? _currentSize;
  bool? _currentLoopAnimation;
  Key _tagLineKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    List<String> words = ['Kick', 'Ban', 'Punch', 'Fuck'];

    final wordsJson = widget.control.attrList("words");
    if (wordsJson != null) {
      words = wordsJson.map((word) => word.toString()).toList();
    }

    final size = widget.control.attrDouble("size");
    final finalSize = size ?? DEFAULT_FONT_SIZE;

    final loopAnimation = widget.control.attrBool("loopAnimation") ?? true;

    // Проверяем, изменились ли параметры
    if (!_areListsEqual(_currentWords, words) ||
        _currentSize != finalSize ||
        _currentLoopAnimation != loopAnimation) {
      _currentWords = List.from(words);
      _currentSize = finalSize;
      _currentLoopAnimation = loopAnimation;
      // Создаем новый ключ для принудительного пересоздания виджета
      _tagLineKey = UniqueKey();
    }

    Widget myControl = TagLine(
      key: _tagLineKey,
      tagLines: words,
      size: finalSize,
      loopAnimation: loopAnimation,
    );

    return constrainedControl(
        context, myControl, widget.parent, widget.control);
  }

  // Вспомогательный метод для сравнения списков
  bool _areListsEqual(List<String>? list1, List<String>? list2) {
    if (list1 == null && list2 == null) return true;
    if (list1 == null || list2 == null) return false;
    if (list1.length != list2.length) return false;

    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }

    return true;
  }
}
