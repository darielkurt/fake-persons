import 'package:dio/dio.dart';
import 'package:fake_persons/core/client.dart';
import 'package:fake_persons/core/models/list_state.dart';
import 'package:fake_persons/src/view_person/data/person.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const baseUrl = 'https://fakerapi.it/api/v1/persons';

class PersonsRepositoryImpl extends PersonsRepository {
  PersonsRepositoryImpl(this.dio);
  final Dio dio;

  @override
  Future<ListState<Person>> getPersons({required int quantity}) async {
    final url = '$baseUrl?_quantity=$quantity';
    final result = await dio.get(url);

    if (result.data != null) {
      final ListState<Person> listState =
          ListState.fromJson(result.data, (json) => Person.fromJson(json));
      return listState;
    }

    // TODO error handling
    throw UnimplementedError();
  }
}

abstract class PersonsRepository {
  Future<ListState<Person>> getPersons({required int quantity});
}

final personsRepositoryProvider =
    Provider.autoDispose<PersonsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return PersonsRepositoryImpl(dio);
});
