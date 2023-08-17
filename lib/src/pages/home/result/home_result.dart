import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_result.freezed.dart';

@freezed
class HomeResult<T> with _$HomeResult<T> {
  factory HomeResult.success(List<T> categories) = Success;
  factory HomeResult.error(String error) = Error;
}