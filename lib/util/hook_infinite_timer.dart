import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

int useInfiniteTimer(BuildContext context) {
  return use(const _InfiniteTimerHook());
}

class _InfiniteTimerHook extends Hook<int> {
  const _InfiniteTimerHook();

  @override
  HookState<int, _InfiniteTimerHook> createState() => _InfiniteTimerHookState();
}

class _InfiniteTimerHookState extends HookState<int, _InfiniteTimerHook> {
  late Timer _timer;
  int _number = 0;

  @override
  void initHook() {
    super.initHook();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timer = timer;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  int build(BuildContext context) {
    return _number;
  }
}
