import 'package:fake_persons/core/widgets/async_value_widget.dart';
import 'package:fake_persons/src/persons_list/domain/persons_repository.dart';
import 'package:fake_persons/src/view_person/data/person.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fake_persons/src/view_person/presentations/view_person.dart';
import 'package:flutter/material.dart';

class PersonsList extends ConsumerWidget {
  const PersonsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final persons = ref.watch(personsFutureProvider);

    return AsyncValueWidget<List<Person>>(
        value: persons,
        data: (persons) {
          return ListView.builder(
            itemCount: persons.length,
            itemBuilder: (context, index) {
              final person = persons[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(person.image ?? ""),
                ),
                title: Text('${person.firstname} ${person.lastname}'),
                subtitle: Text(person.email ?? ""),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewPerson(person: person),
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
