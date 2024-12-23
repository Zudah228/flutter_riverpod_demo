import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

PagingController<PageKeyType, ItemType>
    usePagingController<PageKeyType, ItemType>({
  required PageKeyType firstPageKey,
}) {
  return use(
    _PagingControllerHook<PageKeyType, ItemType>(firstPageKey: firstPageKey),
  );
}

class _PagingControllerHook<PageKeyType, ItemType>
    extends Hook<PagingController<PageKeyType, ItemType>> {
  const _PagingControllerHook({required this.firstPageKey});
  final PageKeyType firstPageKey;

  @override
  HookState<PagingController<PageKeyType, ItemType>,
      Hook<PagingController<PageKeyType, ItemType>>> createState() {
    return _PagingControllerHookState<PageKeyType, ItemType>(
      firstPageKey: firstPageKey,
    );
  }
}

class _PagingControllerHookState<PageKeyType, ItemType> extends HookState<
    PagingController<PageKeyType, ItemType>,
    Hook<PagingController<PageKeyType, ItemType>>> {
  _PagingControllerHookState({required this.firstPageKey});

  late final PagingController<PageKeyType, ItemType> _controller =
      PagingController(firstPageKey: firstPageKey);

  final PageKeyType firstPageKey;

  @override
  PagingController<PageKeyType, ItemType> build(BuildContext context) {
    return _controller;
  }
}
