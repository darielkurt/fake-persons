import 'package:easy_refresh/easy_refresh.dart';
import 'package:fake_persons/core/models/list_state.dart';
import 'package:fake_persons/core/routing/app_router.dart';
import 'package:fake_persons/core/widgets/async_value_widget.dart';
import 'package:fake_persons/src/persons_list/applications/persons_notifier.dart';
import 'package:fake_persons/src/persons_list/domain/persons_repository.dart';
import 'package:fake_persons/src/view_person/data/person.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersonsList extends HookConsumerWidget {
  const PersonsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPersons = ref.watch(asyncPersonsProvider);
    final scrollController = useScrollController();
    final easyRefreshController = EasyRefreshController();

    useEffect(() {
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                0.8 * scrollController.position.maxScrollExtent &&
            !asyncPersons.isLoading) {
          // isLoading.value = true;
          // fetchPersons(currentPage.value).then((newPersons) {
          //   if (newPersons.isNotEmpty) {
          //     persons.value = [...persons.value, ...newPersons];
          //     currentPage.value += 1;
          //   }
          //   isLoading.value = false;
          // });
        }
      });

      return () => scrollController.dispose();
    }, []);

    final page = useState(2);
    return EasyRefresh(
      controller: easyRefreshController,
      onLoad: () async {
        await ref
            .read(asyncPersonsProvider.notifier)
            .fetchMore(page: page.value);
        page.value++;
      },
      child: AsyncValueWidget<ListState<Person>>(
          value: asyncPersons,
          data: (persons) {
            return ListView.builder(
              itemCount: persons.items.length,
              itemBuilder: (context, index) {
                final person = persons.items[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.image ?? ""),
                  ),
                  title: Text('${person.firstname} ${person.lastname}'),
                  subtitle: Text(person.email ?? ""),
                  onTap: () {
                    context.pushNamed(
                      AppRoute.person.name,
                      pathParameters: {'id': person.id.toString()},
                      extra: person,
                    );
                  },
                );
              },
            );
          }),
    );
  }
}
