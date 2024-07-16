import 'package:freezed_annotation/freezed_annotation.dart';
import 'address.dart'; // Ensure this import is correct

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
class Person with _$Person {
  const factory Person({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    String? birthday,
    String? gender,
    Address? address,
    String? website,
    String? image,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}

