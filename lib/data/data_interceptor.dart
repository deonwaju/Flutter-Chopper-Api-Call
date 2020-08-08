import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:connectivity/connectivity.dart';

class MobileDataInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    final isMobile = connectivityResult == ConnectivityResult.mobile;
    final isLargeFile = request.url.contains(RegExp(r'(/large|/video|/posts)'));

    if (isMobile && isLargeFile) {
      throw DataExpenseException();
    }
    return request;
  }
}

class DataExpenseException implements Exception {
  final message = 'Please switch to wifi for large file downloads';

  @override
  String toString() => message;
}
