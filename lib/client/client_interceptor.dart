import 'package:biblioteca_sdk/clients.dart';
import 'package:commons_tools_sdk/error_report.dart';
import 'package:commons_tools_sdk/logger.dart';

class ClientInterceptor implements IClientInterceptor {
  @override
  bool onDoRequest(RequestLogEvent event) => true;

  @override
  bool onReceiveResponse(RequestLogEvent event) => true;

  @override
  bool onReceiveError(RequestLogEvent event) => true;
}

class ErrorReport implements IErrorReport {
  @override
  Future recordException(
      {required Exception exception,
      required StackTrace stack,
      required String reason,
      int? errorCode,
      bool printDebugLog = true}) async {}
}
