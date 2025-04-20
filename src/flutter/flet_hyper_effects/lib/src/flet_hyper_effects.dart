import 'package:flet/flet.dart';
import 'package:flutter/material.dart';

class FletHyperEffectsControl extends StatefulWidget {
  final Control? parent;
  final Control control;
  final bool parentDisabled;
  final bool? parentAdaptive;
  final List<Control> children;
  final FletControlBackend backend;

  const FletHyperEffectsControl({
    super.key,
    this.parent,
    required this.control,
    required this.children,
    required this.parentDisabled,
    required this.parentAdaptive,
    required this.backend,
  });
  State<FletHyperEffectsControl> createState() =>
      _FletHyperEffectsControlState();
}

class _FletHyperEffectsControlState extends State<FletHyperEffectsControl> {
  @override
  Widget build(BuildContext context) {
    bool disabled = widget.control.isDisabled || widget.parentDisabled;

    var contentCtrls =
        widget.children.where((c) => c.name == "content" && c.isVisible);

    Widget? child = contentCtrls.isNotEmpty
        ? createControl(widget.control, contentCtrls.first.id, disabled,
            parentAdaptive: false)
        : null;

    Widget myControl = Container(
      child: child,
    );

    return constrainedControl(
        context, myControl, widget.parent, widget.control);
  }
}
