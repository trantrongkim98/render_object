import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Comment extends MultiChildRenderObjectWidget {
  final Widget avatar;
  final Widget child;
  final bool shouldDrawTopLine;
  final bool shouldDrawBottomLine;
  Comment({
    Key? key,
    required this.avatar,
    this.child = const SizedBox(),
    this.shouldDrawBottomLine = false,
    this.shouldDrawTopLine = false,
  }) : super(key: key, children: [avatar, child]);
  @override
  RenderObject createRenderObject(BuildContext context) {
    return _CommentRenderBox()
      ..shouldDrawTopLine = shouldDrawTopLine
      ..shouldDrawBottomLine = shouldDrawBottomLine;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _CommentRenderBox renderObject) {
    renderObject
      ..shouldDrawTopLine = shouldDrawTopLine
      ..shouldDrawBottomLine = shouldDrawBottomLine;
  }
}

class _CommentData extends ContainerBoxParentData<RenderBox> {}

class _CommentRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _CommentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _CommentData> {
  _CommentRenderBox({List<RenderBox>? children}) {
    addAll(children);
  }

  bool _shouldDrawTopLine = false;

  bool get shouldDrawTopLine => _shouldDrawTopLine;

  set shouldDrawTopLine(bool shouldDrawTopLine) {
    _shouldDrawTopLine = shouldDrawTopLine;
    markNeedsPaint();
  }

  bool _shouldDrawBottomLine = false;

  bool get shouldDrawBottomLine => _shouldDrawBottomLine;

  set shouldDrawBottomLine(bool shouldDrawBottomLine) {
    _shouldDrawBottomLine = shouldDrawBottomLine;
    markNeedsPaint();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! _CommentData) {
      child.parentData = _CommentData();
    }
  }

  @override
  void performLayout() {
    var childConstraints = constraints;

    final avatar = firstChild;
    if (avatar != null) {
      avatar.layout(
          BoxConstraints(
              // maxWidth: avatar.size.width,
              ),
          parentUsesSize: true);
    }

    final comment = lastChild;
    if (comment != null) {
      comment.layout(childConstraints, parentUsesSize: true);
    }

    if (avatar == null && comment == null) {
      size = constraints.smallest;
    } else if (avatar == null && comment != null) {
      size = comment.size;
    } else if (comment == null) {
      size = avatar!.size;
    } else if (avatar!.size.height > comment.size.height) {
      size = avatar.size;
    } else {
      size = comment.size;
    }
  }

  void _paintChild(PaintingContext context, Offset offset) {
    context.paintChild(firstChild!, offset.translate(16, 18));
    context.paintChild(lastChild!, offset.translate(60, 0));
  }

  @override
  bool get hasSize => true;
  @override
  void paint(PaintingContext context, Offset offset) {
    _paintChild(context, offset);
    final canvas = context.canvas;
    final paint = Paint()
      ..color = Color(0xFFE2E7ED)
      // ..color = Colors.red
      ..strokeWidth = 1
      ..isAntiAlias = true;

    canvas.save();
    if (firstChild == null && _shouldDrawTopLine && _shouldDrawBottomLine) {
      final o = offset.translate(30, 0);
      canvas.drawLine(o, o.translate(0, size.height), paint);
    } else {
      if (_shouldDrawTopLine && firstChild != null) {
        final s = firstChild!.size;
        canvas.drawLine(offset.translate(s.width / 2 + 16, 0),
            offset.translate(s.width / 2 + 16, 13), paint);
      }
      if (_shouldDrawBottomLine && firstChild != null) {
        final s = firstChild!.size;

        canvas.drawLine(offset.translate(s.width / 2 + 16, s.height + 26),
            offset.translate(s.width / 2 + 16, size.height), paint);
      }
    }

    canvas.restore();
  }
}
