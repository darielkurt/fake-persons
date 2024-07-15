import 'package:fake_persons/src/persons_list/presentations/persons_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Contact Tracing Form',
      home: PersonsList(),
    );
  }
}

final List<Map<String, dynamic>> persons = [
  {
    "id": 1,
    "firstname": "Herbert",
    "lastname": "Hickle",
    "email": "haleigh.fisher@yahoo.com",
    "phone": "+5138936293058",
    "birthday": "2012-05-11",
    "gender": "male",
    "address": {
      "id": 0,
      "street": "547 Rau Crossing Apt. 246",
      "streetName": "Zieme Pass",
      "buildingNumber": "78896",
      "city": "Lake Ernie",
      "zipcode": "95895",
      "country": "Sweden",
      "county_code": "PS",
      "latitude": 72.139997,
      "longitude": -115.384231
    },
    "website": "http://goyette.com",
    "image": "http://placeimg.com/640/480/people"
  },
  // Add more persons here if needed
];
