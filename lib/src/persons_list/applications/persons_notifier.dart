import 'package:fake_persons/core/models/list_state.dart';
import 'package:fake_persons/src/persons_list/domain/persons_repository.dart';
import 'package:fake_persons/src/view_person/data/person.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncPersonsNotifier extends AutoDisposeAsyncNotifier<ListState<Person>> {
  @override
  Future<ListState<Person>> build() async {
    return await _fetchPersons(page: 1);
  }

  Future<ListState<Person>> _fetchPersons({required int page}) async {
    final personsRepository = ref.read(personsRepositoryProvider);
    final quantity = page < 2 ? 10 : 20;
    final persons = await personsRepository.getPersons(quantity: quantity);
    return persons;
  }

  Future<void> fetchMore({required int page}) async {
    state = AsyncValue.data(state.value!.copyWith(loadingMore: true));

    final currentPersons = state.value?.items ?? [];
    final newPersons = await _fetchPersons(page: page);
    state = AsyncValue.data(
      state.value!.copyWith(
        loadingMore: false,
        items: [...currentPersons, ...newPersons.items],
      ),
    );
  }
}

final asyncPersonsProvider =
    AsyncNotifierProvider.autoDispose<AsyncPersonsNotifier, ListState<Person>>(
        AsyncPersonsNotifier.new);
