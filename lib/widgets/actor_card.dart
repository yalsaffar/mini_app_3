import 'package:flutter/material.dart';
import '../models/actor.dart';

class ActorCard extends StatelessWidget {
  final Actor actor;

  ActorCard({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(actor.pictureUrl), // Assuming 'pictureUrl' is a property of the Actor model
        title: Text(actor.name),
        subtitle: Text("Age: ${actor.age}"), // Assuming 'age' is a property of the Actor model
        // Other actor details...
      ),
    );
  }
}
