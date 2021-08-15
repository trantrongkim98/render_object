import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProcessBar extends LeafRenderObjectWidget {
  final Color dotColor;
  final Color thumbColor;
  final double thumbSize;
  final Color barColor;
  final int numDot;
  ProcessBar({
    this.dotColor = Colors.black,
    this.thumbColor = Colors.yellow,
    this.thumbSize = 16,
    this.barColor = Colors.blue,
    this.numDot = 20,
  });
  @override
  RenderObject createRenderObject(BuildContext context) {
    return ProcessBarBox()
      ..dotColor = dotColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize
      ..barColor = barColor
      ..numDot = numDot;
  }

  @override
  void updateRenderObject(BuildContext context, ProcessBarBox renderObject) {
    renderObject
      ..thumbSize = thumbSize
      ..thumbColor = thumbColor
      ..dotColor = dotColor
      ..barColor = barColor
      ..numDot = numDot;
  }
}

class ProcessBarBox extends RenderBox {
  HorizontalDragGestureRecognizer? _drag;

  Offset _offset = Offset.zero;
  int index = 0;
  double space = 0;
  ProcessBarBox() {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = (start) {}
      ..onUpdate = (update) {
        _updateUI(update.localPosition);
        markNeedsSemanticsUpdate();
      };
  }

  _updateUI(Offset offset) {
    space = size.width / numDot;
    _offset = Offset(
      offset.dx.clamp(0, size.width),
      offset.dy.clamp(0, size.height),
    );

    index = _offset.dx ~/ space;
    markNeedsPaint();
    print(index);
  }

  Color _dotColor = Colors.black;

  Color get dotColor => _dotColor;

  set dotColor(Color value) {
    _dotColor = value;
    markNeedsPaint();
  }

  Color _thumbColor = Colors.yellow;
  double _thumbSize = 16;

  Color get thumbColor => _thumbColor;

  set thumbColor(Color value) {
    _thumbColor = value;

    markNeedsPaint();
  }

  double get thumbSize => _thumbSize;

  set thumbSize(double value) {
    _thumbSize = value;
    markNeedsPaint();
  }

  Color _barColor = Colors.blue;
  Color get barColor => _barColor;

  set barColor(Color barColor) {
    _barColor = barColor;
    markNeedsPaint();
  }

  int _numDot = 10;
  int get numDot => _numDot;
  set numDot(int numDot) {
    _numDot = numDot;
    markNeedsPaint();
    // _updateUI(Offset(index*space,_offset.dy));
  }

  // Handle the hit event and send that to our HorizontalDragGestureRecognizer.
  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag?.addPointer(event);
    }
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void performLayout() {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbSize;
    final desiredSize = Size(desiredWidth, desiredHeight);
    size = constraints.constrain(desiredSize);
    space = size.width / numDot;
  }

  @override
  bool get hasSize => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      ..color = dotColor;

    final paint1 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      ..color = thumbColor;
    final paintBar = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4
      ..color = barColor;

    for (int i = 0; i < numDot + 1; i++) {
      if (i <= index) {
        canvas.drawLine(
            Offset(i * space, 0), Offset(i * space, thumbSize), paintBar);
      } else {
        canvas.drawLine(
            Offset(i * space, 0), Offset(i * space, thumbSize), paint);
      }
    }
    canvas.drawLine(
        Offset(0, thumbSize / 2), Offset(_offset.dx, thumbSize / 2), paintBar);
    canvas.drawLine(Offset(_offset.dx, thumbSize / 2),
        Offset(size.width, thumbSize / 2), paint);
    canvas.drawCircle(Offset(_offset.dx, 6), thumbSize, paint1);

    canvas.restore();
  }

  @override
  void detach() {
    _drag?.dispose();
    super.detach();
  }
}
