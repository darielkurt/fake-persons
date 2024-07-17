import 'package:dio/dio.dart';
import 'package:fake_persons/core/client.dart';
import 'package:fake_persons/src/view_person/data/person.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const baseUrl = 'https://fakerapi.it/api/v1/persons';

class PersonsRepositoryImpl extends PersonsRepository {
  PersonsRepositoryImpl(this.dio);
  final Dio dio;

  @override
  Future<List<Person>> getPersons() async {
    const url = '$baseUrl?_quantity=10';
    final result = await dio.get(url);

    if (result.data != null) {
      final List personResult = result.data['data'];
      final List<Person> personList =
          personResult.map((e) => Person.fromJson(e)).toList();
      return personList;
    }

    // TODO error handling
    throw UnimplementedError();
  }
}

abstract class PersonsRepository {
  Future<List<Person>> getPersons();
}

final personsRepositoryProvider =
    Provider.autoDispose<PersonsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PersonsRepositoryImpl(dio);
});

final personsFutureProvider =
    FutureProvider.autoDispose<List<Person>>((ref) async {
  final personsRepository = ref.watch(personsRepositoryProvider);
  return personsRepository.getPersons();
});

