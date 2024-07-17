import 'package:fake_persons/src/persons_list/presentations/persons_screen.dart';
import 'package:fake_persons/src/view_person/data/person.dart';
import 'package:fake_persons/src/view_person/presentations/view_person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  person,
}

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const PersonsScreen(),
        routes: [
          GoRoute(
            path: 'person/:id',
            name: AppRoute.person.name,
            pageBuilder: (context, state) {
              final Person person = state.extra as Person;
              return MaterialPage(child: ViewPerson(person: person));
            },
          ),
        ],
      ),
    ],
  );
});
