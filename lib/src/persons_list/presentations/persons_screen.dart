import 'package:fake_persons/src/view_person/presentations/view_person.dart';
import 'package:flutter/material.dart';

class PersonsScreen extends StatelessWidget {
  const PersonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons List'),
      ),
      body: PersonsList(),
    );
  }
}
