import 'dart:async';

class CancelToken {
  CancelToken();

  final Completer<Exception> _completer = Completer<Exception>();

  /// If request have been canceled, save the cancel error.
  Exception? get cancelError => _cancelError;
  Exception? _cancelError;

  /// Whether the token is cancelled.
  bool get isCancelled => _cancelError != null;

  /// When cancelled, this future will be resolved.
  Future<Exception> get whenCancel => _completer.future;

  /// Cancel the request with the given [reason].
  void cancel([Object? reason]) {
    _cancelError = Exception('cancel token');
    if (!_completer.isCompleted) {
      _completer.complete(_cancelError);
    }
  }
}
