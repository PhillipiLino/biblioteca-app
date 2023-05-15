import 'package:clean_architecture_utils/failures.dart';

class DatabaseFailure extends Failure {
  const DatabaseFailure() : super('Ocorreu um erro inesperado');

  @override
  List<Object?> get props => [];
}

class SaveImageFailure extends Failure {
  const SaveImageFailure() : super('');

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure() : super('');
  @override
  List<Object?> get props => [];
}
