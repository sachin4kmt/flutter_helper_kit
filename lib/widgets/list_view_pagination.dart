import 'package:flutter/material.dart';

class ListViewPagination extends StatefulWidget {
  const ListViewPagination({
    required this.itemBuilder,
    required this.itemCount,
    required this.nextData,
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.loadingWidget,
    this.scrollThreshold = 400,
    this.hasNext = false,
  })  : _separated = false,
        _separatorBuilder = null,
        semanticChildCount = null,
        itemExtent = null;

  const ListViewPagination.separated({
    required this.itemBuilder,
    required this.itemCount,
    required this.nextData,
    required Widget Function(BuildContext context, int index) separatorBuilder,
    super.key,
    this.semanticChildCount,
    this.itemExtent,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.loadingWidget,
    this.scrollThreshold = 300,
    this.hasNext = false,
  })  : _separated = true,
        _separatorBuilder = separatorBuilder;
  final double scrollThreshold;
  final VoidCallback? nextData;
  final bool hasNext;
  final Widget? loadingWidget;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final bool _separated;
  final Widget Function(BuildContext, int)? _separatorBuilder;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double? cacheExtent;
  final int? semanticChildCount;
  final double? itemExtent;

  @override
  State<StatefulWidget> createState() => _InfiniteListViewState();
}

class _InfiniteListViewState extends State<ListViewPagination> {
  int? _lastLoadedEvent;

  @override
  void didUpdateWidget(ListViewPagination oldWidget) {
    if (oldWidget.itemCount != widget.itemCount) {
      _lastLoadedEvent = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget itemBuilder(BuildContext context, int index) {
      if (index == widget.itemCount) {
        return widget.loadingWidget ??
            const Center(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: CircularProgressIndicator(),
              ),
            );
      }
      return widget.itemBuilder(context, index);
    }

    if (widget._separated) {
      return NotificationListener<ScrollNotification>(
        onNotification: _onScroll,
        child: ListView.separated(
          controller: widget.controller,
          itemBuilder: itemBuilder,
          scrollDirection: widget.scrollDirection,
          reverse: widget.reverse,
          padding: widget.padding,
          addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
          addRepaintBoundaries: widget.addRepaintBoundaries,
          addSemanticIndexes: widget.addSemanticIndexes,
          cacheExtent: widget.cacheExtent,
          primary: widget.primary,
          physics: widget.physics,
          shrinkWrap: widget.shrinkWrap,
          separatorBuilder:
              widget._separatorBuilder ?? (_, __) => const Divider(),
          itemCount: widget.hasNext ? widget.itemCount + 1 : widget.itemCount,
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: ListView.builder(
        controller: widget.controller,
        itemBuilder: itemBuilder,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        itemExtent: widget.itemExtent,
        padding: widget.padding,
        semanticChildCount: widget.semanticChildCount,
        addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
        addRepaintBoundaries: widget.addRepaintBoundaries,
        addSemanticIndexes: widget.addSemanticIndexes,
        cacheExtent: widget.cacheExtent,
        primary: widget.primary,
        physics: widget.physics,
        shrinkWrap: widget.shrinkWrap,
        itemCount: widget.hasNext ? widget.itemCount + 1 : widget.itemCount,
      ),
    );
  }

  bool _onScroll(ScrollNotification notification) {
    bool isScrollDirection;
    //the direction of user scroll up, down, left, right.
    final scrollDirection = notification.metrics.axisDirection;

    switch (widget.scrollDirection) {
      case Axis.vertical:
        isScrollDirection = scrollDirection == AxisDirection.down ||
            scrollDirection == AxisDirection.up;
        break;
      case Axis.horizontal:
        isScrollDirection = scrollDirection == AxisDirection.left ||
            scrollDirection == AxisDirection.right;
        break;
    }
    final maxScroll = notification.metrics.maxScrollExtent;

    //end of the listview reached
    if (isScrollDirection &&
        maxScroll - notification.metrics.pixels <= widget.scrollThreshold) {
      if (widget.nextData != null && _lastLoadedEvent == null) {
        _lastLoadedEvent = widget.itemCount;
        widget.nextData?.call();
      }
    }

    return false;
  }
}
