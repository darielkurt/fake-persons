import 'package:fake_persons/main.dart';
import 'package:fake_persons/src/view_person/presentations/view_person.dart';
import 'package:flutter/material.dart';

class PersonsList extends StatelessWidget {
  const PersonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons List'),
      ),
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          var person = persons[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(person['image']),
            ),
            title: Text('${person['firstname']} ${person['lastname']}'),
            subtitle: Text(person['email']),
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
      ),
    );
  }
}
