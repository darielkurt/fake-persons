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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PersonsList extends HookConsumerWidget {
  const PersonsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPersons = ref.watch(asyncPersonsProvider);
    final scrollController = useScrollController();
    final easyRefreshController = EasyRefreshController();
    final page = useState(2);
    final pagingController = useMemoized(
      () => PagingController<int, int>(firstPageKey: 0),
      [],
    );

    Future<void> _fetchPage(int pageKey) async {
      try {
        await Future.delayed(Duration(seconds: 2)); // Simulate network delay
        final newItems = List.generate(_pageSize, (index) => pageKey * _pageSize + index);
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } catch (error) {
        pagingController.error = error;
      }
    }

    useEffect(() {
      pagingController.addPageRequestListener((pageKey) {
        _fetchPage(pageKey);
      });
      return pagingController.dispose;
    }, [pagingController]);

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
