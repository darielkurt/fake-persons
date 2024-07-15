import 'package:flutter/material.dart';

class ViewPerson extends StatelessWidget {
  final Map<String, dynamic> person;

  const ViewPerson({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    var address = person['address'];
    return Scaffold(
      appBar: AppBar(
        title: Text('${person['firstname']} ${person['lastname']}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              person['image'],
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.grey[700],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Unavailable',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${person['firstname']} ${person['lastname']}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Email: ${person['email']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Phone: ${person['phone']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Birthday: ${person['birthday']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Gender: ${person['gender']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Address:',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    '${address['street']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${address['streetName']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${address['buildingNumber']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${address['city']}, ${address['zipcode']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${address['country']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Website: ${person['website']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
