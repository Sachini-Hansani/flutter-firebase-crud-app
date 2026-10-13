import 'package:crud_app/screens/update.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final int id;
  final String degree;
  final VoidCallback? onUpdated;

  const StudentCard({
    super.key,
    required this.name,
    required this.id,
    required this.degree,
    this.onUpdated,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the layout for the Student Card
    // 1. Return a Card widget containing the student's name, ID, and degree.
    // 2. Add an IconButton (e.g., an edit icon) that uses Navigator.push
    //    to route the user to the UpdateScreen, passing along the student's data.

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blue,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('Student ID: $id'),
                  const SizedBox(height: 4),
                  Text('Degree: $degree'),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Edit student',
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final bool? updated = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UpdateScreen(name: name, id: id, degree: degree),
                  ),
                );

                if (updated == true) {
                  onUpdated?.call();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
