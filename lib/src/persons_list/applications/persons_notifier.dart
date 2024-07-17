import 'package:fake_persons/src/persons_list/domain/persons_repository.dart';
import 'package:fake_persons/src/view_person/data/person.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncPersonsNotifier extends AutoDisposeAsyncNotifier<List<Person>> {
  @override
  Future<List<Person>> build() async {
    return await _fetchPersons(page: 1);
  }

  Future<List<Person>> _fetchPersons({required int page}) async {
    final personsRepository = ref.read(personsRepositoryProvider);
    final quantity = page < 2 ? 10 : 20;
    final persons = await personsRepository.getPersons(quantity: quantity);
    return persons;
  }

  Future<void> fetchMore({required int page}) async {
    state = const AsyncValue.loading();

    final currentPersons = state.value ?? [];
    final newPersons = await _fetchPersons(page: page);
    state = AsyncValue.data([...currentPersons, ...newPersons]);
  }
}

final asyncPersonsProvider =
    AsyncNotifierProvider.autoDispose<AsyncPersonsNotifier, List<Person>>(
        AsyncPersonsNotifier.new);
