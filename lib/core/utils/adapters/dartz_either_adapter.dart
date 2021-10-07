import 'package:dartz/dartz.dart';
import 'package:flutter_triple/flutter_triple.dart';

class DartzEitherAdapter<L, R> implements EitherAdapter<L, R> {
  final Either<L, R> usecase;
  DartzEitherAdapter(this.usecase);

  static Future<EitherAdapter<L, R>> adapter<L, R>(
      Future<Either<L, R>> usecase) {
    return usecase.then((value) => DartzEitherAdapter(value));
  }

  @override
  T fold<T>(T Function(L l) leftF, T Function(R l) rightF) {
    return usecase.fold(leftF, rightF);
  }
}
