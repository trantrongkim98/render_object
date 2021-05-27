import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: SizedBox(
            width: 300,
            child: ProcessBar(
              dotColor: Colors.blue,
              thumbColor: Colors.yellow,
              thumbSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class ProcessBar extends LeafRenderObjectWidget {
  final Color dotColor;
  final Color thumbColor;
  final double thumbSize;

  ProcessBar({
    Key? key,
    this.dotColor = Colors.transparent,
    this.thumbColor = Colors.transparent,
    this.thumbSize = 4,
  }) : super(key: key);
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderProcessBar()
      ..dotColor = dotColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize;
  }

  @override
  void updateRenderObject(BuildContext context, RenderProcessBar renderObject) {
    renderObject
      ..dotColor = dotColor
      ..thumbColor = thumbColor
      ..thumbSize = thumbSize;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('dotColor', dotColor));
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
  }
}

class RenderProcessBar extends RenderBox {
  Color _dotColor;
  Color _thumbColor;
  double _thumbSize;

  void _updateThumbPosition(Offset localPosition) {
    // clamp the position between the full width of the renderobject
    // to avoid if you drag the mouse out of the window.
    var dx = localPosition.dx.clamp(0, size.width);

    // make the size between 0 and 1 with only 1 decimal
    // example 0.4 or 0.7.
    _currentThumbValue = double.parse((dx / size.width).toStringAsFixed(1));

    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  RenderProcessBar({
    Color dotColor = Colors.transparent,
    Color thumbColor = Colors.transparent,
    double thumbSize = 4,
  })  : _dotColor = dotColor,
        _thumbColor = thumbColor,
        _thumbSize = thumbSize {
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = (DragStartDetails details) {
        _updateThumbPosition(details.localPosition);
      }
      ..onUpdate = (DragUpdateDetails details) {
        _updateThumbPosition(details.localPosition);
      };
  }

  Color get dotColor => _dotColor;
  set dotColor(Color color) {
    if (_dotColor == color) {
      return;
    }
    _dotColor = color;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbColor;
  set thumbColor(Color color) {
    if (color == _thumbColor) return;
    _thumbColor = color;
    markNeedsPaint();
  }

  double get thumbSize => _thumbSize;
  set thumbSize(double size) {
    if (size == _thumbSize) return;
    _thumbSize = size;
    markNeedsPaint();
  }

  // define our variable
  HorizontalDragGestureRecognizer? _drag;

  // Render object can be hit
  @override
  bool hitTestSelf(Offset position) => true;

  // Handle the hit event and send that to our HorizontalDragGestureRecognizer.
  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry));
    if (event is PointerDownEvent) {
      _drag?.addPointer(event);
    }
  }

  @override
  void performLayout() {
    final desiredWidth = constraints.maxWidth;
    final desiredHeight = thumbSize;
    final desiredSize = Size(desiredWidth, desiredHeight);
    size = constraints.constrain(desiredSize);
  }

  double _currentThumbValue = 0.5;
  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    // paint dots
    final dotPaint = Paint()
      ..color = dotColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    final barPaint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    final linePaint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    final spacing = size.width / 10;
    for (var i = 0; i < 11; i++) {
      var upperPoint = Offset(spacing * i, size.height * 0.5);
      final lowerPoint = Offset(spacing * i, size.height * 0.75);
      if (i % 5 == 0) {
        upperPoint = Offset(spacing * i, size.height * 0.25);
      }
      if (upperPoint.dx <= _currentThumbValue * size.width) {
        if (i % 5 == 0) {
          canvas.drawLine(upperPoint, lowerPoint, barPaint);
        } else {
          canvas.drawCircle(Offset(spacing * i, upperPoint.dy), 4, barPaint);
        }
        //
      } else {
        if (i % 5 == 0) {
          canvas.drawLine(upperPoint, lowerPoint, dotPaint);
        } else {
          canvas.drawCircle(Offset(spacing * i, upperPoint.dy), 4, dotPaint);
        }
      }
    }

    // setup thumb
    final thumbPaint = Paint()
      ..color = _thumbColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16;
    final thumbDx = _currentThumbValue * size.width;

    // draw the bar from left to thumb position
    final point1 = Offset(0, size.height / 2);
    final point2 = Offset(thumbDx, size.height / 2);
    canvas.drawLine(point1, point2, linePaint);

    // paint thumb
    final center = Offset(thumbDx, size.height / 2);
    canvas.drawCircle(center, thumbSize / 2, thumbPaint);

    canvas.restore();
  }

  @override
  void detach() {
    _drag?.dispose();
    super.detach();
  }
}
