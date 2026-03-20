import 'package:booking_app/core/error/failures.dart';

typedef Either<L, R> = _Either<L, R>;

abstract class _Either<L, R> {
  const _Either();

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  L get left => (this as Left<L, R>).value;
  R get right => (this as Right<L, R>).value;

  T fold<T>(T Function(L) onLeft, T Function(R) onRight) {
    if (isLeft) return onLeft(left);
    return onRight(right);
  }

  void when({required void Function(L) left, required void Function(R) right}) {
    if (isLeft) {
      left(this.left);
    } else {
      right(this.right);
    }
  }

  _Either<L, T> map<T>(T Function(R) mapper) {
    if (isRight) return Right(mapper(right));
    return Left(left);
  }

  @override
  String toString() => isLeft ? 'Left($left)' : 'Right($right)';
}

class Left<L, R> extends _Either<L, R> {
  final L value;
  const Left(this.value);
}

class Right<L, R> extends _Either<L, R> {
  final R value;
  const Right(this.value);
}

Either<Failure, R> left<R>(Failure failure) => Left(failure);
Either<Failure, R> right<R>(R value) => Right(value);
