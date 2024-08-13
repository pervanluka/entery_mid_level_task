import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingOverlay {
  static final LoadingOverlay instance = LoadingOverlay._();

  LoadingOverlay._();

  OverlayEntry? _overlay;

  void show(BuildContext context, {String? text}) {
    if (!context.mounted) {
      return;
    }
    if (_overlay == null) {
      _overlay = OverlayEntry(
        builder: (context) => Animate(
          effects: const [FadeEffect()],
          child: ColoredBox(
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CupertinoActivityIndicator(),
                  if (text != null) Text(text),
                ],
              ),
            ),
          ),
        ),
      );

      Overlay.of(context).insert(_overlay!);
    }
  }

  void hide(BuildContext context) {
    if (!context.mounted) {
      return;
    }
    _overlay?.remove();
    _overlay?.dispose();
    _overlay = null;
  }
}
