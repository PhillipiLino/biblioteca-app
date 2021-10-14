import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class DatabaseFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NullParamFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class SaveImageFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}
