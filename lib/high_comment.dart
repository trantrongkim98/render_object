import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HighComment extends RenderObjectWidget {
  final Widget avatar;
  final Widget comment;
  final Widget actions;
  final Widget reaction;

  final bool shouldDrawTopLine;
  final bool shouldDrawBottomLine;
  final bool isParentComment;

  HighComment({
    this.avatar = const SizedBox(),
    this.comment = const SizedBox(),
    this.actions = const SizedBox(),
    this.reaction = const SizedBox(),
    this.shouldDrawBottomLine = false,
    this.shouldDrawTopLine = false,
    this.isParentComment = true,
  });

  @override
  RenderObjectElement createElement() {
    return _HighCommentElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    context as _HighCommentElement;
    return HighCommentBox()
      ..isParentComment = isParentComment
      ..shouldDrawBottomLine = shouldDrawBottomLine
      ..shouldDrawTopLine = shouldDrawTopLine;
  }

  @override
  void updateRenderObject(BuildContext context, HighCommentBox renderObject) {
    renderObject
      ..isParentComment = isParentComment
      ..shouldDrawTopLine = shouldDrawTopLine
      ..shouldDrawBottomLine = shouldDrawBottomLine;
  }
}

enum _CommentIdentify {
  avatar,
  comment,
  actions,
  reaction,
}

class _HighCommentElement extends RenderObjectElement {
  Element? _avatar;
  Element? _comment;
  Element? _actions;
  Element? _reaction;
  _HighCommentElement(HighComment widget) : super(widget);

  @override
  HighComment get widget => super.widget as HighComment;

  @override
  HighCommentBox get renderObject => super.renderObject as HighCommentBox;
  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _avatar = inflateWidget(widget.avatar, _CommentIdentify.avatar);
    _comment = inflateWidget(widget.comment, _CommentIdentify.comment);
    _actions = inflateWidget(widget.actions, _CommentIdentify.actions);
    _reaction = inflateWidget(widget.reaction, _CommentIdentify.reaction);
  }

  @override
  void update(covariant HighComment newWidget) {
    super.update(newWidget);

    _avatar = updateChild(_avatar, newWidget.avatar, _CommentIdentify.avatar);
    _comment =
        updateChild(_comment, newWidget.comment, _CommentIdentify.comment);
    _actions =
        updateChild(_actions, newWidget.actions, _CommentIdentify.actions);
    _reaction =
        updateChild(_reaction, newWidget.reaction, _CommentIdentify.reaction);
  }

  @override
  void unmount() {
    super.unmount();
    _avatar = null;
    _comment = null;
    _actions = null;
    _reaction = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_avatar != null) visitor(_avatar!);
    if (_comment != null) visitor(_comment!);
    if (_actions != null) visitor(_actions!);
    if (_reaction != null) visitor(_reaction!);
  }

  @override
  void forgetChild(Element child) {
    super.forgetChild(child);
    if (_avatar == child) _avatar = null;
    if (_comment == child) _comment = null;
    if (_actions == child) _actions = null;
    if (_reaction == child) _reaction = null;
  }

  @override
  void insertRenderObjectChild(RenderBox child, covariant Object? slot) {
    renderObject.insertRenderObjectChild(child, slot as _CommentIdentify);
  }

  @override
  void moveRenderObjectChild(
      RenderBox child, _CommentIdentify? oldSlot, _CommentIdentify? newSlot) {
    renderObject.moveRenderObjectChild(child, oldSlot!, newSlot!);
  }

  @override
  void removeRenderObjectChild(RenderBox child, _CommentIdentify? slot) {
    renderObject.removeRenderObjectChild(child, slot!);
  }
}

class HighCommentBox extends RenderBox {
  RenderBox? _avatar;
  RenderBox? _comment;
  RenderBox? _actions;
  RenderBox? _reaction;

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

  bool _isParentComment = true;

  bool get isParentComment => _isParentComment;

  set isParentComment(bool isParentComment) {
    _isParentComment = isParentComment;
    markNeedsPaint();
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);

    _avatar?.attach(owner);
    _comment?.attach(owner);
    _actions?.attach(owner);
    _reaction?.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    _avatar?.detach();
    _comment?.detach();
    _actions?.detach();
    _reaction?.detach();
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    super.visitChildren(visitor);
    if (_avatar != null) visitor(_avatar!);
    if (_comment != null) visitor(_comment!);
    if (_actions != null) visitor(_actions!);
    if (_reaction != null) visitor(_reaction!);
  }

  @override
  void redepthChildren() {
    super.redepthChildren();
    _avatar?.redepthChildren();
    _comment?.redepthChildren();
    _actions?.redepthChildren();
    _reaction?.redepthChildren();
  }

  void _updateChild(RenderBox? child, _CommentIdentify slot) {
    switch (slot) {
      case _CommentIdentify.avatar:
        _avatar = child;
        break;
      case _CommentIdentify.comment:
        _comment = child;
        break;
      case _CommentIdentify.actions:
        _actions = child;
        break;
      case _CommentIdentify.reaction:
        _reaction = child;
        break;
    }
  }

  void insertRenderObjectChild(RenderBox child, _CommentIdentify slot) {
    _updateChild(child, slot);

    adoptChild(child);
  }

  void moveRenderObjectChild(
      RenderBox child, _CommentIdentify oldSlot, _CommentIdentify newSlot) {
    _updateChild(null, oldSlot);
    _updateChild(child, newSlot);
  }

  void removeRenderObjectChild(RenderBox child, _CommentIdentify slot) {
    _updateChild(null, slot);

    dropChild(child);
  }

  @override
  void performLayout() {
    double heightActionAndReaction = 0;
    double height = 0;
    if (_avatar != null) {
      _avatar!.layout(
          BoxConstraints(
            maxWidth: 32,
          ),
          parentUsesSize: true);
    }

    if (_comment != null) {
      _comment!.layout(
          BoxConstraints(
              maxWidth: constraints.maxWidth - 76 - (isParentComment ? 0 : 44)),
          parentUsesSize: true);
      height = _comment!.size.height;
    }

    if (_actions != null) {
      _actions!.layout(BoxConstraints(), parentUsesSize: true);
      heightActionAndReaction = _actions!.size.height;
    }
    if (_reaction != null) {
      _reaction!.layout(BoxConstraints(), parentUsesSize: true);
      if (_reaction!.size.height > heightActionAndReaction) {
        heightActionAndReaction = _reaction!.size.height;
      }
    }

    size = Size(constraints.maxWidth, height + heightActionAndReaction);
  }

  @override
  bool get hasSize => true;

  void _paintChild(PaintingContext context, Offset offset) {
    double translate = isParentComment ? 0 : 44;
    Offset actionOffset = offset;
    if (_avatar != null) {
      context.paintChild(_avatar!, offset.translate(16 + translate, 18));
    }

    if (_comment != null) {
      context.paintChild(_comment!, offset.translate(60 + translate, 0));
      actionOffset = offset.translate(60 + translate, _comment!.size.height);
    }
    if (_actions != null) {
      context.paintChild(_actions!, actionOffset);
    }
  }

  void _paintLine(Canvas canvas, Offset offset) {
    final paint = Paint()
      ..color = Color(0xFFE2E7ED)
      ..strokeWidth = 1
      ..isAntiAlias = true;
    canvas.save();
    if (isParentComment) {
      if (_avatar == null && _shouldDrawTopLine && _shouldDrawBottomLine) {
        final o = offset.translate(30, 0);
        canvas.drawLine(o, o.translate(0, size.height), paint);
      } else {
        if (_shouldDrawTopLine && _avatar != null) {
          final s = _avatar!.size;
          canvas.drawLine(offset.translate(s.width / 2 + 16, 0),
              offset.translate(s.width / 2 + 16, 13), paint);
        }
        if (_shouldDrawBottomLine && _avatar != null && _comment != null) {
          final s = _avatar!.size;

          canvas.drawLine(offset.translate(s.width / 2 + 16, s.height + 26),
              offset.translate(s.width / 2 + 16, size.height), paint);
        }
      }
    } else {
      if (_shouldDrawTopLine || _shouldDrawBottomLine && !isParentComment) {
        final o = offset.translate(32, 0);
        canvas.drawLine(o, o.translate(0, size.height), paint);
      }
    }
    double translate = isParentComment ? 0 : 44;
    if (_avatar == null && _shouldDrawTopLine && _shouldDrawBottomLine) {
      final o = offset.translate(30 + translate, 0);
      canvas.drawLine(o, o.translate(0, size.height), paint);
    } else {
      if (_shouldDrawTopLine && _avatar != null) {
        final s = _avatar!.size;
        canvas.drawLine(offset.translate(s.width / 2 + 16 + translate, 0),
            offset.translate(s.width / 2 + 16 + translate, 13), paint);
      }
      if (_shouldDrawBottomLine && _avatar != null && _comment != null) {
        final s = _avatar!.size;

        canvas.drawLine(
            offset.translate(s.width / 2 + 16 + translate, s.height + 26),
            offset.translate(s.width / 2 + 16 + translate, size.height),
            paint);
      }
    }
    canvas.restore();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    _paintChild(context, offset);
    _paintLine(canvas, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    if (_avatar?.hitTest(result, position: position) == true) {
      return true;
    }
    if (_comment?.hitTest(result, position: position) == true) {
      return true;
    }
    return false;
  }
}
