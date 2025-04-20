import 'package:flet/flet.dart';
import 'package:flet_hyper_effects/src/flet_roll_text.dart';

CreateControlFactory createControl = (CreateControlArgs args) {
  switch (args.control.type) {
    case "flet_hyper_effects_roll":
      return HyperEffectsRollControl(
        parent: args.parent,
        control: args.control,
        children: args.children,
        parentDisabled: args.parentDisabled,
        parentAdaptive: args.parentAdaptive,
        backend: args.backend,
      );
    default:
      return null;
  }
};

void ensureInitialized() {
  // nothing to initialize
}
