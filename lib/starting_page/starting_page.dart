import 'package:discoveringbloc/snapshot_page/snapshot_page.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to Bill It !\nYour favorite app\nNot the one of your boss ;-)',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SnapshotPage(),
                  ),
                );
              },
              child: const Text('New bill'),
            ),
          ],
        ),
      ),
    );
  }
}
