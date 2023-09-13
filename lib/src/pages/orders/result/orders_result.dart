import 'package:freezed_annotation/freezed_annotation.dart';
part 'orders_result.freezed.dart';

@freezed
class OrderResult<T> with _$OrderResult<T> {
  factory OrderResult.success(T data) = Success;
  factory OrderResult.error(String error) = Error;
}
