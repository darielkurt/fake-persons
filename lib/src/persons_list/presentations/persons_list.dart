import 'package:easy_refresh/easy_refresh.dart';
import 'package:fake_persons/core/models/list_state.dart';
import 'package:fake_persons/core/routing/app_router.dart';
import 'package:fake_persons/core/widgets/async_value_widget.dart';
import 'package:fake_persons/src/persons_list/applications/persons_notifier.dart';
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
    final page = useState(2);

    return EasyRefresh(
      controller: easyRefreshController,
      onRefresh: () async {
        ref.invalidate(asyncPersonsProvider);
        await ref.read(asyncPersonsProvider.future);
        page.value = 2;

        return IndicatorResult.success;
      },
      onLoad: () async {
        await ref
            .read(asyncPersonsProvider.notifier)
            .fetchMore(page: page.value);
        if (page.value == 4) {
          return IndicatorResult.noMore;
        }
        page.value++;
      },
      child: AsyncValueWidget<ListState<Person>>(
          value: asyncPersons,
          data: (persons) {
            return ListView.builder(
              controller: scrollController,
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
