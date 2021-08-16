import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HighComment extends RenderObjectWidget {
  final Widget avatar;
  final Widget comment;

  HighComment({
    this.avatar = const SizedBox(),
    this.comment = const SizedBox(),
  });

  @override
  RenderObjectElement createElement() {
    return _HighCommentElement(this);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return HighCommentBox();
  }
}

class _HighCommentElement extends RenderObjectElement {
  Element? _avatar;
  Element? _comment;
  _HighCommentElement(HighComment widget) : super(widget);

  @override
  HighComment get widget => super.widget as HighComment;

  @override
  HighCommentBox get renderObject => super.renderObject as HighCommentBox;
  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _avatar = inflateWidget(widget.avatar, true);
    _comment = inflateWidget(widget.comment, true);
  }

  @override
  void update(covariant HighComment newWidget) {
    super.update(newWidget);

    _avatar = updateChild(_avatar, newWidget.avatar, true);
    _comment = updateChild(_comment, newWidget.comment, true);
  }

  @override
  void unmount() {
    super.unmount();
    _avatar = null;
    _comment = null;
  }

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_avatar != null) visitor(_avatar!);
    if (_comment != null) visitor(_comment!);
  }

  @override
  void forgetChild(Element child) {
    super.forgetChild(child);
    if (_avatar == child) _avatar = null;
    if (_comment == child) _comment = null;
  }

  @override
  void insertRenderObjectChild(RenderBox child, bool slot) {
    renderObject.inseartRenderObjectChild(child, slot);
  }

  @override
  void moveRenderObjectChild(RenderBox child, bool oldSlot, bool newSlot) {
    renderObject.moveRenderObjectChild(child, oldSlot, newSlot);
  }

  @override
  void removeRenderObjectChild(RenderBox child, bool slot) {
    renderObject.removeRenderObjectChild(child, slot);
  }
}

class HighCommentBox extends RenderBox {
  RenderBox? _avatar;
  RenderBox? _comment;

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);

    _avatar?.attach(owner);
    _comment?.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    _avatar?.detach();
    _comment?.detach();
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    super.visitChildren(visitor);
    if (_avatar != null) visitor(_avatar!);
    if (_comment != null) visitor(_comment!);
  }

  @override
  void redepthChildren() {
    super.redepthChildren();
    _avatar?.redepthChildren();
    _comment?.redepthChildren();
  }

  void inseartRenderObjectChild(RenderBox child, bool slot) {
    if (slot) {
      _avatar = child;
    } else {
      _comment = child;
    }

    adoptChild(child);
  }

  void moveRenderObjectChild(RenderBox child, bool oldSlot, bool newSlot) {
    if (oldSlot) {
      _avatar = null;
    } else {
      _comment = null;
    }
    if (newSlot) {
      _avatar = child;
    } else {
      _comment = child;
    }
  }

  void removeRenderObjectChild(RenderBox child, bool slot) {
    if (slot) {
      _avatar = null;
    } else {
      _comment = null;
    }

    dropChild(child);
  }

  @override
  void performLayout() {
    // var childConstraints = constraints;

    // if (_avatar != null) {
    //   _avatar!.layout(
    //       BoxConstraints(
    //           // maxWidth: avatar.size.width,
    //           ),
    //       parentUsesSize: true);
    // }

    // if (_comment != null) {
    //   _comment!.layout(childConstraints, parentUsesSize: true);
    // }

    // if (_avatar == null && _comment == null) {
    //   size = constraints.smallest;
    // } else if (_avatar == null && _comment != null) {
    //   size = _comment!.size;
    // } else if (_comment == null) {
    //   size = _avatar!.size;
    // } else if (_avatar!.size.height > _comment!.size.height) {
    //   size = _avatar!.size;
    // } else {
    //   size = _comment!.size;
    // }

    var followerConstraints = constraints;

    final child = _avatar;
    if (child != null) {
      child.layout(constraints, parentUsesSize: true);
      followerConstraints = BoxConstraints.tight(child.size);
    }

    final overlay = _comment;
    if (overlay != null) {
      overlay.layout(followerConstraints, parentUsesSize: true);
    }

    size = _avatar?.size ?? _comment?.size ?? constraints.smallest;
  }

  @override
  bool get hasSize => true;

  @override
  void paint(PaintingContext context, Offset offset) {
    // if (_comment != null) {
    //   context.paintChild(_comment!, offset);
    // }
    if (_avatar != null) {
      context.paintChild(_avatar!, offset);
    }

    final canvas = context.canvas;
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
